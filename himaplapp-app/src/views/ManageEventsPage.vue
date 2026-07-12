<template>
  <ion-page>
    <CustomHeader title="Manage Events" />
    <ion-content class="ion-padding app-background">
      <div class="manage-container">
        <h2>Events Management</h2>
        
        <ion-button expand="block" class="create-btn" @click="createEvent">
          Create Event
        </ion-button>

        <!-- Filters Section -->
        <div class="filters-container">
          <div class="search-row">
            <ion-searchbar 
              placeholder="Search events..." 
              class="custom-searchbar"
              v-model="searchQuery"
              mode="ios">
            </ion-searchbar>
            <ion-button fill="clear" color="primary" class="filter-toggle-btn" @click="showFilters = !showFilters">
              <ion-icon slot="icon-only" :icon="optionsOutline"></ion-icon>
            </ion-button>
          </div>
          
          <div class="dropdown-filters" v-show="showFilters">
            <ion-item class="filter-item" lines="none">
              <ion-select placeholder="Year" interface="popover" v-model="selectedYear">
                <ion-select-option v-for="year in availableYears" :key="year" :value="year.toString()">{{ year }}</ion-select-option>
              </ion-select>
            </ion-item>
            
            <ion-button fill="clear" color="medium" class="reset-button" @click="resetFilters" v-if="hasActiveFilters">
              <ion-icon slot="icon-only" :icon="refreshOutline"></ion-icon>
            </ion-button>
          </div>
        </div>

        <ion-accordion-group>
          <ion-accordion v-for="event in filteredEvents" :key="event.id" :value="String(event.id)">
            <ion-item slot="header" color="light">
              <ion-label>
                <h2 style="font-weight: 600;">{{ event.nama_event }}</h2>
                <p>ID: {{ event.id }} <span v-if="event.start_date"> • {{ new Date(event.start_date).toLocaleDateString('id-ID') }} - {{ event.end_date ? new Date(event.end_date).toLocaleDateString('id-ID') : 'TBA' }}</span></p>
              </ion-label>
            </ion-item>
            
            <div class="accordion-content" slot="content">
              <ion-button fill="clear" @click="editEvent(event)">
                <ion-icon slot="start" :icon="createOutline"></ion-icon>
                Edit
              </ion-button>
              <ion-button fill="clear" color="danger" @click="deleteEvent(event.id)">
                <ion-icon slot="start" :icon="trashOutline"></ion-icon>
                Delete
              </ion-button>
            </div>
          </ion-accordion>
        </ion-accordion-group>
      </div>

      <!-- Create Event Modal -->
      <ion-modal :is-open="isCreateModalOpen" @didDismiss="isCreateModalOpen = false">
        <ion-header>
          <ion-toolbar>
            <ion-title>{{ isEditing ? 'Edit Event' : 'Create Event' }}</ion-title>
            <ion-buttons slot="end">
              <ion-button @click="isCreateModalOpen = false">Cancel</ion-button>
            </ion-buttons>
          </ion-toolbar>
          <ion-toolbar>
            <ion-segment v-model="selectedSegment" mode="ios">
              <ion-segment-button value="event">
                <ion-label>Event Details</ion-label>
              </ion-segment-button>
              <ion-segment-button value="task">
                <ion-label>Tasks</ion-label>
              </ion-segment-button>
            </ion-segment>
          </ion-toolbar>
        </ion-header>
        <ion-content class="ion-padding">
          <div v-show="selectedSegment === 'event'">
            <ion-list>
              <ion-item>
                <ion-input label="Event Name" label-placement="floating" v-model="newEvent.nama_event" placeholder="Enter event name"></ion-input>
              </ion-item>
              
              <ion-item>
                <div style="width: 100%; margin: 8px 0;">
                  <ion-label position="stacked" style="font-size: 14px; color: #64748b; margin-bottom: 8px; display: block;">Event Image (URL or Upload)</ion-label>
                  <ion-input type="text" placeholder="Paste image URL here" v-model="newEvent.image_url" style="margin-bottom: 8px; --background: #f8fafc; border-radius: 8px;"></ion-input>
                  <div style="display: flex; gap: 8px; align-items: center;">
                    <span style="font-size: 12px; color: #64748b;">OR</span>
                    <ion-button size="small" fill="outline" @click="pickImageFromGallery">
                      <ion-icon slot="start" :icon="imageOutline"></ion-icon>
                      Select from Gallery
                    </ion-button>
                  </div>
                  <div v-if="isUploadingImage" style="font-size: 12px; color: #2563eb; margin-top: 4px;">Uploading...</div>
                  <div v-if="newEvent.image_url" style="margin-top: 8px;">
                    <img :src="newEvent.image_url" style="max-height: 150px; border-radius: 8px; object-fit: cover; border: 1px solid #e2e8f0;" />
                  </div>
                </div>
              </ion-item>
            
            <ion-item>
              <ion-textarea label="Description" label-placement="floating" v-model="newEvent.deskripsi" placeholder="Enter description"></ion-textarea>
            </ion-item>

            <ion-item>
              <ion-label position="stacked" style="font-size: 14px; color: #64748b; margin-bottom: 8px;">Start Date</ion-label>
              <div style="padding-bottom: 8px;">
                <ion-datetime-button datetime="start-date"></ion-datetime-button>
              </div>
              <ion-modal :keep-contents-mounted="true">
                <ion-datetime id="start-date" v-model="newEvent.start_date" presentation="date-time"></ion-datetime>
              </ion-modal>
            </ion-item>

            <ion-item>
              <ion-label position="stacked" style="font-size: 14px; color: #64748b; margin-bottom: 8px;">End Date</ion-label>
              <div style="padding-bottom: 8px;">
                <ion-datetime-button datetime="end-date"></ion-datetime-button>
              </div>
              <ion-modal :keep-contents-mounted="true">
                <ion-datetime id="end-date" v-model="newEvent.end_date" presentation="date-time"></ion-datetime>
              </ion-modal>
            </ion-item>

            <ion-item button @click="isLokasiModalOpen = true">
              <ion-input label="Location" label-placement="floating" readonly :value="selectedLokasiText" placeholder="Click to select location"></ion-input>
            </ion-item>

            <ion-item>
              <ion-input type="number" label="Quota" label-placement="floating" v-model="newEvent.kuota" placeholder="Enter quota (e.g. 100)"></ion-input>
            </ion-item>

            <ion-item>
              <ion-select label="Category" label-placement="floating" :multiple="true" v-model="newEvent.kategori_ids">
                <ion-select-option v-for="k in kategoriList" :key="k.id" :value="k.id">{{ k.nama_kategori }}</ion-select-option>
              </ion-select>
            </ion-item>

            <div style="margin: 16px 0; border: 1px solid #e2e8f0; border-radius: 8px; padding-bottom: 8px;">
              <h3 style="margin: 16px; font-size: 14px; color: #64748b; font-weight: 600;">Event Links (Optional)</h3>
              <ion-list lines="none">
                <ion-item v-for="(link, idx) in eventLinks" :key="idx" style="--padding-start: 16px; --inner-padding-end: 16px; border-bottom: 1px solid #f1f5f9;">
                  <ion-input label="Name" label-placement="stacked" v-model="link.nama_tautan" placeholder="e.g. Zoom Link" style="flex: 1; margin-right: 8px;"></ion-input>
                  <ion-input label="URL" label-placement="stacked" v-model="link.url" placeholder="https://..." style="flex: 2; margin-right: 8px;"></ion-input>
                  <ion-button fill="clear" color="danger" @click="eventLinks.splice(idx, 1)" style="margin-top: auto;">
                    <ion-icon :icon="trashOutline"></ion-icon>
                  </ion-button>
                </ion-item>
              </ion-list>
              <ion-button fill="clear" @click="eventLinks.push({ nama_tautan: '', url: '' })" style="margin-left: 8px; font-size: 14px;">+ Add Link</ion-button>
            </div>

            <ion-item>
              <ion-select label="Status" label-placement="floating" v-model="newEvent.status">
                <ion-select-option value="DRAFT">DRAFT</ion-select-option>
                <ion-select-option value="PUBLISHED">PUBLISHED</ion-select-option>
                <ion-select-option value="AVAILABLE">AVAILABLE</ion-select-option>
                <ion-select-option value="UPCOMING">UPCOMING</ion-select-option>
                <ion-select-option value="COMPLETED">COMPLETED</ion-select-option>
                <ion-select-option value="CANCELLED">CANCELLED</ion-select-option>
                <ion-select-option value="CLOSED">CLOSED</ion-select-option>
              </ion-select>
            </ion-item>
          </ion-list>
          </div>
          
          <div v-show="selectedSegment === 'task'">
            <div style="margin-bottom: 16px;">
              <h3 style="margin-top: 0; color: #1e293b; font-size: 18px; font-weight: 600;">Event Tasks</h3>
              <p style="color: #64748b; font-size: 14px;">Add tasks to be completed for this event. These will be assigned to everyone by default.</p>
            </div>
            
            <ion-list>
              <ion-item v-for="(task, index) in newTasks" :key="index" style="--padding-start: 0; --inner-padding-end: 0; border: 1px solid #e2e8f0; border-radius: 8px; margin-bottom: 12px; padding: 0 16px;">
                <div style="width: 100%; padding: 8px 0;">
                  <div style="display: flex; align-items: center; width: 100%;">
                    <ion-input label="Task Name" label-placement="floating" v-model="task.nama_tugas" placeholder="Enter task name" style="flex: 1;"></ion-input>
                    <ion-button fill="clear" color="danger" @click="removeTask(index)">
                      <ion-icon :icon="trashOutline"></ion-icon>
                    </ion-button>
                  </div>
                  
                  <ion-select label="Assign To" label-placement="floating" v-model="task.assign_type" @ionChange="task.assigned_to_ids = []; task.assigned_to_divisi_id = null;" style="margin-top: 8px;">
                    <ion-select-option value="global">Global (Everyone)</ion-select-option>
                    <ion-select-option value="individu">Individu (Specific Person)</ion-select-option>
                    <ion-select-option value="kelompok">Kelompok (Division)</ion-select-option>
                  </ion-select>
                  
                  <ion-item v-if="task.assign_type === 'individu'" button @click="openUserSearchModal(index)" style="margin-top: 8px; --padding-start: 0; --inner-padding-end: 0;">
                    <ion-input label="Select Persons" label-placement="floating" readonly :value="getSelectedUserName(task.assigned_to_ids)" placeholder="Click to select persons"></ion-input>
                  </ion-item>
                  
                  <ion-select v-if="task.assign_type === 'kelompok'" label="Select Division" label-placement="floating" v-model="task.assigned_to_divisi_id" style="margin-top: 8px;">
                    <ion-select-option v-for="d in divisiList" :key="d.id" :value="d.id">{{ d.nama_divisi }}</ion-select-option>
                  </ion-select>
                </div>
              </ion-item>
            </ion-list>
            
            <ion-button expand="block" fill="outline" @click="addTask" style="margin-top: 16px; margin-bottom: 16px; --border-color: #2563eb; --color: #2563eb;">
              + Add Task
            </ion-button>
          </div>
          
          <ion-button expand="block" class="save-btn" @click="saveEvent" :disabled="isSaving">
            {{ isSaving ? 'Saving...' : (isEditing ? 'Update Event' : 'Save Event') }}
          </ion-button>
        </ion-content>
      </ion-modal>

      <!-- User Search Modal -->
      <ion-modal :is-open="isUserSelectModalOpen" @didDismiss="isUserSelectModalOpen = false">
        <ion-header>
          <ion-toolbar>
            <ion-title>Select Person</ion-title>
            <ion-buttons slot="end">
              <ion-button @click="isUserSelectModalOpen = false">Close</ion-button>
            </ion-buttons>
          </ion-toolbar>
          <ion-toolbar>
            <ion-searchbar v-model="userSearchQuery" placeholder="Search by name or NIM"></ion-searchbar>
          </ion-toolbar>
        </ion-header>
        <ion-content>
          <ion-list>
            <ion-item v-for="u in filteredUsers" :key="u.id">
              <ion-checkbox slot="start" :checked="activeTaskIndex !== null && newTasks[activeTaskIndex].assigned_to_ids.includes(u.id)" @ionChange="toggleUserSelection(u.id, $event)"></ion-checkbox>
              <ion-label>
                <h2>{{ u.nama }}</h2>
                <p v-if="u.nim">{{ u.nim }}</p>
              </ion-label>
            </ion-item>
            <ion-item v-if="filteredUsers.length === 0">
              <ion-label class="ion-text-center" color="medium">No users found</ion-label>
            </ion-item>
          </ion-list>
        </ion-content>
      </ion-modal>

      <!-- Lokasi Search Modal -->
      <ion-modal :is-open="isLokasiModalOpen" @didDismiss="isLokasiModalOpen = false">
        <ion-header>
          <ion-toolbar>
            <ion-title>Select Location</ion-title>
            <ion-buttons slot="end">
              <ion-button @click="isLokasiModalOpen = false">Close</ion-button>
            </ion-buttons>
          </ion-toolbar>
          <ion-toolbar>
            <ion-searchbar v-model="lokasiSearchQuery" placeholder="Search location..."></ion-searchbar>
          </ion-toolbar>
        </ion-header>
        <ion-content>
          <ion-list>
            <ion-item button @click="selectLokasi(null)">
              <ion-label>None (TBA)</ion-label>
            </ion-item>
            <ion-item v-for="l in filteredLokasi" :key="l.id" button @click="selectLokasi(l.id)">
              <ion-label>
                <h2>{{ l.nama_ruangan }}</h2>
                <p>Capacity: {{ l.kapasitas || 'Unlimited' }}</p>
              </ion-label>
            </ion-item>
            <ion-item button @click="createNewLokasi">
              <ion-icon slot="start" :icon="addOutline" color="primary"></ion-icon>
              <ion-label color="primary">Add New Location...</ion-label>
            </ion-item>
          </ion-list>
        </ion-content>
      </ion-modal>

    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { 
  IonPage, IonContent, IonButton, 
  IonAccordionGroup, IonAccordion, IonItem, IonLabel, IonIcon, toastController, alertController,
  IonModal, IonHeader, IonToolbar, IonTitle, IonButtons, IonList, IonInput, IonTextarea, IonSelect, IonSelectOption,
  IonSegment, IonSegmentButton, IonDatetime, IonDatetimeButton, IonPopover, IonSearchbar, IonCheckbox
} from '@ionic/vue';
import { createOutline, trashOutline, addOutline, optionsOutline, refreshOutline, imageOutline } from 'ionicons/icons';
import { ref, onMounted, computed } from 'vue';
import CustomHeader from '../components/CustomHeader.vue';
import { supabase } from '../supabase';
import { Camera, CameraResultType, CameraSource } from '@capacitor/camera';

const events = ref<any[]>([]);
const isCreateModalOpen = ref(false);
const isSaving = ref(false);
const isUploadingImage = ref(false);
const selectedSegment = ref('event');
const isEditing = ref(false);
const editingEventId = ref<number | null>(null);
const originalImageUrl = ref('');

// Search & Filter State
const searchQuery = ref('');
const showFilters = ref(false);
const selectedYear = ref('');

const availableYears = computed(() => {
  const years = new Set<string>();
  events.value.forEach(event => {
    if (event.start_date) {
      years.add(new Date(event.start_date).getFullYear().toString());
    }
  });
  return Array.from(years).sort((a, b) => parseInt(b) - parseInt(a));
});

const hasActiveFilters = computed(() => {
  return searchQuery.value !== '' || selectedYear.value !== '';
});

const resetFilters = () => {
  searchQuery.value = '';
  selectedYear.value = '';
};

const filteredEvents = computed(() => {
  return events.value.filter(event => {
    // Search filter
    if (searchQuery.value && event.nama_event && !event.nama_event.toLowerCase().includes(searchQuery.value.toLowerCase())) {
      return false;
    }
    // Year filter
    if (selectedYear.value && event.start_date) {
      const eventYear = new Date(event.start_date).getFullYear().toString();
      if (eventYear !== selectedYear.value) return false;
    } else if (selectedYear.value && !event.start_date) {
      return false;
    }
    return true;
  });
});

const usersList = ref<any[]>([]);
const divisiList = ref<any[]>([]);
const lokasiList = ref<any[]>([]);
const kategoriList = ref<any[]>([]);

const newTasks = ref<{ nama_tugas: string, assign_type: 'global' | 'individu' | 'kelompok', assigned_to_ids: string[], assigned_to_divisi_id: number | null }[]>([]);

const isUserSelectModalOpen = ref(false);
const activeTaskIndex = ref<number | null>(null);
const userSearchQuery = ref('');

const filteredUsers = computed(() => {
  const query = userSearchQuery.value.toLowerCase();
  if (!query) return usersList.value;
  return usersList.value.filter(u => 
    u.nama.toLowerCase().includes(query) || 
    (u.nim && u.nim.toLowerCase().includes(query))
  );
});

const openUserSearchModal = (index: number) => {
  activeTaskIndex.value = index;
  isUserSelectModalOpen.value = true;
};

const toggleUserSelection = (id: string, event: any) => {
  if (activeTaskIndex.value === null) return;
  const isChecked = event.detail.checked;
  const task = newTasks.value[activeTaskIndex.value];
  if (isChecked && !task.assigned_to_ids.includes(id)) {
    task.assigned_to_ids.push(id);
  } else if (!isChecked) {
    task.assigned_to_ids = task.assigned_to_ids.filter((uid: string) => uid !== id);
  }
};

const getSelectedUserName = (userIds: string[]) => {
  if (!userIds || userIds.length === 0) return '';
  if (userIds.length === 1) {
    const u = usersList.value.find(user => user.id === userIds[0]);
    return u ? (u.nim ? `${u.nama} (${u.nim})` : u.nama) : '';
  }
  return `${userIds.length} persons selected`;
};

const isLokasiModalOpen = ref(false);
const lokasiSearchQuery = ref('');

const filteredLokasi = computed(() => {
  const query = lokasiSearchQuery.value.toLowerCase();
  if (!query) return lokasiList.value;
  return lokasiList.value.filter(l => l.nama_ruangan.toLowerCase().includes(query));
});

const selectedLokasiText = computed(() => {
  if (newEvent.value.lokasi_id === null) return 'None (TBA)';
  const l = lokasiList.value.find(l => l.id === newEvent.value.lokasi_id);
  return l ? `${l.nama_ruangan} (Cap: ${l.kapasitas || 'Unlimited'})` : 'None (TBA)';
});

const selectLokasi = (id: number | null) => {
  newEvent.value.lokasi_id = id;
  isLokasiModalOpen.value = false;
};

const createNewLokasi = async () => {
  isLokasiModalOpen.value = false;
  const alert = await alertController.create({
    header: 'New Location',
    inputs: [
      { name: 'nama_ruangan', type: 'text', placeholder: 'Room Name (e.g. Hall A)' },
      { name: 'kapasitas', type: 'number', placeholder: 'Capacity (Optional)' }
    ],
    buttons: [
      { text: 'Cancel', role: 'cancel' },
      {
        text: 'Save',
        handler: async (data) => {
          if (!data.nama_ruangan) {
            showToast('Room name is required', 'danger');
            return false;
          }
          const capacity = data.kapasitas ? parseInt(data.kapasitas) : null;
          const { data: newLokasi, error } = await supabase
            .from('lokasi')
            .insert([{ nama_ruangan: data.nama_ruangan, kapasitas: capacity }])
            .select('*')
            .single();
          if (error) {
            showToast('Failed to add location: ' + error.message, 'danger');
          } else if (newLokasi) {
            lokasiList.value.push(newLokasi);
            lokasiList.value.sort((a, b) => a.nama_ruangan.localeCompare(b.nama_ruangan));
            newEvent.value.lokasi_id = newLokasi.id;
            showToast('Location added successfully', 'success');
          }
        }
      }
    ]
  });
  await alert.present();
};

const newEvent = ref({
  nama_event: '',
  deskripsi: '',
  start_date: '',
  end_date: '',
  lokasi_id: null as number | null,
  kuota: null as number | null,
  kategori_ids: [] as number[],
  status: 'DRAFT',
  image_url: ''
});

const eventLinks = ref<{ nama_tautan: string, url: string }[]>([]);

const showToast = async (msg: string, color: string) => {
  const toast = await toastController.create({
    message: msg,
    duration: 2000,
    color: color
  });
  toast.present();
};

const fetchEvents = async () => {
  try {
    const { data, error } = await supabase
      .from('events')
      .select('id, nama_event, start_date, end_date')
      .order('id', { ascending: false });
      
    if (error) throw error;
    if (data) events.value = data;
  } catch (error) {
    console.error('Error fetching events:', error);
  }
};

const fetchMasterData = async () => {
  try {
    const [usersRes, divisiRes, lokasiRes, kategoriRes] = await Promise.all([
      supabase.from('users').select('id, nama, nim').order('nama'),
      supabase.from('divisi').select('id, nama_divisi').order('nama_divisi'),
      supabase.from('lokasi').select('*').order('nama_ruangan'),
      supabase.from('kategori_event').select('*').order('nama_kategori')
    ]);
    if (usersRes.data) usersList.value = usersRes.data;
    if (divisiRes.data) divisiList.value = divisiRes.data;
    if (lokasiRes.data) lokasiList.value = lokasiRes.data;
    if (kategoriRes.data) kategoriList.value = kategoriRes.data;
  } catch (err) {
    console.error('Error fetching master data', err);
  }
};

onMounted(() => {
  fetchEvents();
  fetchMasterData();
});

const createEvent = () => {
  isEditing.value = false;
  editingEventId.value = null;
  originalImageUrl.value = '';
  
  const now = new Date();
  // Adjust to local timezone ISO string for the picker
  const tzOffset = now.getTimezoneOffset() * 60000;
  const localISOTime = (new Date(Date.now() - tzOffset)).toISOString().slice(0, 16);
  const laterISOTime = (new Date(Date.now() - tzOffset + 3600000)).toISOString().slice(0, 16);
  
  newEvent.value = {
    nama_event: '',
    deskripsi: '',
    start_date: localISOTime,
    end_date: laterISOTime,
    lokasi_id: null,
    kuota: null,
    kategori_ids: [],
    status: 'DRAFT',
    image_url: ''
  };
  eventLinks.value = [];
  newTasks.value = [];
  selectedSegment.value = 'event';
  isCreateModalOpen.value = true;
};

const base64ToBlob = (base64: string, mimeType: string) => {
  const byteCharacters = atob(base64);
  const byteArrays = [];
  for (let offset = 0; offset < byteCharacters.length; offset += 512) {
    const slice = byteCharacters.slice(offset, offset + 512);
    const byteNumbers = new Array(slice.length);
    for (let i = 0; i < slice.length; i++) {
      byteNumbers[i] = slice.charCodeAt(i);
    }
    const byteArray = new Uint8Array(byteNumbers);
    byteArrays.push(byteArray);
  }
  return new Blob(byteArrays, { type: mimeType });
};

const pickImageFromGallery = async () => {
  try {
    const image = await Camera.getPhoto({
      quality: 80,
      allowEditing: false,
      resultType: CameraResultType.Base64,
      source: CameraSource.Photos
    });

    isUploadingImage.value = true;
    
    // Convert base64 to File object using robust helper
    if (!image.base64String) throw new Error('No base64 string returned');
    const blob = base64ToBlob(image.base64String, `image/${image.format}`);
    const fileName = `${Math.random()}.${image.format}`;
    const file = new File([blob], fileName, { type: `image/${image.format}` });

    const filePath = `events/${fileName}`;

    const { error: uploadError } = await supabase.storage
      .from('dokumentasi-event') 
      .upload(filePath, file);

    if (uploadError) throw uploadError;

    const { data: { publicUrl } } = supabase.storage
      .from('dokumentasi-event')
      .getPublicUrl(filePath);

    newEvent.value.image_url = publicUrl;
    showToast('Image uploaded', 'success');
  } catch (error: any) {
    if (error.message !== 'User cancelled photos app') {
      console.error('Upload error:', error);
      showToast(`Upload failed: ${error.message || 'Unknown error'}`, 'danger');
    }
  } finally {
    isUploadingImage.value = false;
  }
};

const addTask = () => {
  newTasks.value.push({ 
    nama_tugas: '', 
    assign_type: 'global',
    assigned_to_ids: [],
    assigned_to_divisi_id: null 
  });
};

const removeTask = (index: number) => {
  newTasks.value.splice(index, 1);
};

const saveEvent = async () => {
  if (!newEvent.value.nama_event) {
    showToast('Event name is required', 'warning');
    return;
  }

  isSaving.value = true;
  try {
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) throw new Error("Not logged in");

    // Format dates to ISO if provided, or leave null
    const payload = {
      nama_event: newEvent.value.nama_event,
      deskripsi: newEvent.value.deskripsi || null,
      start_date: newEvent.value.start_date ? new Date(newEvent.value.start_date).toISOString() : null,
      end_date: newEvent.value.end_date ? new Date(newEvent.value.end_date).toISOString() : null,
      lokasi_id: newEvent.value.lokasi_id || null,
      kuota: newEvent.value.kuota ? Number(newEvent.value.kuota) : null,
      status: newEvent.value.status as any,
      created_by: user.id
    };

    if (isEditing.value && editingEventId.value) {
      const { error: updateError } = await supabase
        .from('events')
        .update(payload)
        .eq('id', editingEventId.value);
        
      if (updateError) throw updateError;
      
      // Update Kategori Mapping
      await supabase.from('event_kategori_mapping').delete().eq('event_id', editingEventId.value);
      if (newEvent.value.kategori_ids.length > 0) {
        const catPayload = newEvent.value.kategori_ids.map(kid => ({ event_id: editingEventId.value!, kategori_id: kid }));
        await supabase.from('event_kategori_mapping').insert(catPayload);
      }

      // Update Links
      await supabase.from('event_links').delete().eq('event_id', editingEventId.value);
      const validLinks = eventLinks.value.filter(l => l.nama_tautan && l.url);
      if (validLinks.length > 0) {
        const linksPayload = validLinks.map(l => ({ event_id: editingEventId.value!, nama_tautan: l.nama_tautan, url: l.url }));
        await supabase.from('event_links').insert(linksPayload);
      }
      
      await supabase.from('tugas').delete().eq('event_id', editingEventId.value);
      
      const validTasks = newTasks.value.filter(t => t.nama_tugas.trim() !== '');
      if (validTasks.length > 0) {
        const tasksPayload = validTasks.map(t => ({
          nama_tugas: t.nama_tugas,
          event_id: editingEventId.value,
          assigned_by_id: user.id,
          assign_type: t.assign_type
        }));
        
        const { data: insertedTasks, error: taskErr } = await supabase
          .from('tugas')
          .insert(tasksPayload)
          .select('id');
          
        if (taskErr) throw taskErr;
        
        if (insertedTasks && insertedTasks.length === validTasks.length) {
          let assignmentsPayload: any[] = [];
          
          for (let i = 0; i < validTasks.length; i++) {
            const taskObj = validTasks[i];
            const taskId = insertedTasks[i].id;
            let targetUserIds: string[] = [];
            
            if (taskObj.assign_type === 'global') {
              const { data: allUsers } = await supabase.from('users').select('id');
              if (allUsers) targetUserIds = allUsers.map((u: any) => u.id);
            } else if (taskObj.assign_type === 'individu') {
              if (taskObj.assigned_to_ids && taskObj.assigned_to_ids.length > 0) targetUserIds.push(...taskObj.assigned_to_ids);
            } else if (taskObj.assign_type === 'kelompok') {
              if (taskObj.assigned_to_divisi_id) {
                const { data: groupUsers } = await supabase.from('users').select('id').eq('divisi_id', taskObj.assigned_to_divisi_id);
                if (groupUsers) targetUserIds = groupUsers.map((u: any) => u.id);
              }
            }
            
            targetUserIds.forEach(uid => {
              assignmentsPayload.push({
                tugas_id: taskId,
                user_id: uid,
                status_selesai: false
              });
            });
          }
          
          if (assignmentsPayload.length > 0) {
            await supabase.from('tugas_assignments').insert(assignmentsPayload);
          }
        }
      }

      if (newEvent.value.image_url && newEvent.value.image_url !== originalImageUrl.value) {
        await supabase.from('dokumentasi').insert([{
          event_id: editingEventId.value,
          uploader_id: user.id,
          url_foto: newEvent.value.image_url
        }]);
      }

      showToast('Event updated successfully', 'success');
    } else {
      const { data: insertedEvent, error } = await supabase
        .from('events')
        .insert([payload])
        .select('id')
        .single();
  
      if (error) throw error;
      
      // Insert Kategori Mapping
      if (newEvent.value.kategori_ids.length > 0 && insertedEvent) {
        const catPayload = newEvent.value.kategori_ids.map(kid => ({ event_id: insertedEvent.id, kategori_id: kid }));
        await supabase.from('event_kategori_mapping').insert(catPayload);
      }

      // Insert Links
      const validLinks = eventLinks.value.filter(l => l.nama_tautan && l.url);
      if (validLinks.length > 0 && insertedEvent) {
        const linksPayload = validLinks.map(l => ({ event_id: insertedEvent.id, nama_tautan: l.nama_tautan, url: l.url }));
        await supabase.from('event_links').insert(linksPayload);
      }
  
      if (newEvent.value.image_url && insertedEvent) {
        const docPayload = {
          event_id: insertedEvent.id,
          uploader_id: user.id,
          url_foto: newEvent.value.image_url
        };
        await supabase.from('dokumentasi').insert([docPayload]);
      }
  
      const validTasks = newTasks.value.filter(t => t.nama_tugas.trim() !== '');
      if (validTasks.length > 0 && insertedEvent) {
        const tasksPayload = validTasks.map(t => ({
          nama_tugas: t.nama_tugas,
          event_id: insertedEvent.id,
          assigned_by_id: user.id,
          assign_type: t.assign_type
        }));
        
        const { data: insertedTasks, error: taskErr } = await supabase
          .from('tugas')
          .insert(tasksPayload)
          .select('id');
          
        if (taskErr) throw taskErr;
        
        if (insertedTasks && insertedTasks.length === validTasks.length) {
          let assignmentsPayload: any[] = [];
          
          for (let i = 0; i < validTasks.length; i++) {
            const taskObj = validTasks[i];
            const taskId = insertedTasks[i].id;
            let targetUserIds: string[] = [];
            
            if (taskObj.assign_type === 'global') {
              const { data: allUsers } = await supabase.from('users').select('id');
              if (allUsers) targetUserIds = allUsers.map((u: any) => u.id);
            } else if (taskObj.assign_type === 'individu') {
              if (taskObj.assigned_to_ids && taskObj.assigned_to_ids.length > 0) targetUserIds.push(...taskObj.assigned_to_ids);
            } else if (taskObj.assign_type === 'kelompok') {
              if (taskObj.assigned_to_divisi_id) {
                const { data: groupUsers } = await supabase.from('users').select('id').eq('divisi_id', taskObj.assigned_to_divisi_id);
                if (groupUsers) targetUserIds = groupUsers.map((u: any) => u.id);
              }
            }
            
            targetUserIds.forEach(uid => {
              assignmentsPayload.push({
                tugas_id: taskId,
                user_id: uid,
                status_selesai: false
              });
            });
          }
          
          if (assignmentsPayload.length > 0) {
            await supabase.from('tugas_assignments').insert(assignmentsPayload);
          }
        }
      }
      showToast('Event created successfully', 'success');
    }
    
    isCreateModalOpen.value = false;
    fetchEvents();
  } catch (error: any) {
    console.error('Error creating event:', error);
    showToast(error.message || 'Failed to create event', 'danger');
  } finally {
    isSaving.value = false;
  }
};

const editEvent = async (event: any) => {
  try {
    const { data: eventData, error: eventError } = await supabase
      .from('events')
      .select('*')
      .eq('id', event.id)
      .single();
      
    if (eventError) throw eventError;

    const { data: tasksData, error: tasksError } = await supabase
      .from('tugas')
      .select('nama_tugas, assign_type')
      .eq('event_id', event.id);
      
    if (tasksError) throw tasksError;

    const { data: docData } = await supabase
      .from('dokumentasi')
      .select('url_foto')
      .eq('event_id', event.id)
      .order('created_at', { ascending: false })
      .limit(1);
      
    const { data: mappingData } = await supabase
      .from('event_kategori_mapping')
      .select('kategori_id')
      .eq('event_id', event.id);
      
    const { data: linksData } = await supabase
      .from('event_links')
      .select('nama_tautan, url')
      .eq('event_id', event.id);

    newEvent.value = {
      nama_event: eventData.nama_event,
      deskripsi: eventData.deskripsi || '',
      start_date: eventData.start_date ? eventData.start_date.slice(0, 16) : '',
      end_date: eventData.end_date ? eventData.end_date.slice(0, 16) : '',
      lokasi_id: eventData.lokasi_id || null,
      kuota: eventData.kuota,
      kategori_ids: mappingData ? mappingData.map(m => m.kategori_id) : [],
      status: eventData.status || 'DRAFT',
      image_url: docData && docData.length > 0 ? docData[0].url_foto : ''
    };
    originalImageUrl.value = newEvent.value.image_url;
    
    eventLinks.value = linksData || [];

    newTasks.value = tasksData ? tasksData.map(t => {
      return {
        nama_tugas: t.nama_tugas,
        assign_type: (t.assign_type as any) || 'global',
        assigned_to_ids: [],
        assigned_to_divisi_id: null
      };
    }) : [];
    
    isEditing.value = true;
    editingEventId.value = event.id;
    selectedSegment.value = 'event';
    isCreateModalOpen.value = true;
  } catch (err: any) {
    console.error('Error fetching event details:', err);
    showToast('Failed to load event details', 'danger');
  }
};

const deleteEvent = async (id: number) => {
  const alert = await alertController.create({
    header: 'Confirm Delete',
    message: 'Are you sure you want to delete this event? Associated tasks will also be deleted.',
    buttons: [
      { text: 'Cancel', role: 'cancel' },
      {
        text: 'Delete',
        role: 'confirm',
        handler: async () => {
          try {
            const { error } = await supabase.from('events').delete().eq('id', id);
            if (error) throw error;
            events.value = events.value.filter(e => e.id !== id);
            showToast('Event deleted successfully', 'success');
          } catch (err: any) {
            console.error('Error deleting event:', err);
            showToast('Failed to delete event', 'danger');
          }
        }
      }
    ]
  });
  await alert.present();
};
</script>

<style scoped>
.manage-container {
  background: white;
  padding: 24px;
  border-radius: 12px;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
  margin-top: 16px;
}
.manage-container h2 {
  margin-top: 0;
  margin-bottom: 16px;
  color: #1e293b;
  font-weight: 700;
}
.create-btn {
  margin-bottom: 24px;
  --background: #2563eb;
  font-weight: 600;
}
.accordion-content {
  padding: 16px;
  display: flex;
  justify-content: flex-end;
  gap: 8px;
  background: white;
}
.save-btn {
  margin-top: 24px;
  --background: #2563eb;
  font-weight: 600;
}

/* Filters Section */
.filters-container {
  margin-bottom: 24px;
}

.search-row {
  display: flex;
  align-items: center;
  gap: 8px;
}

.custom-searchbar {
  --background: white;
  --box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
  --border-radius: 12px;
  padding: 0;
  flex: 1;
}

.filter-toggle-btn {
  margin: 0;
  height: 36px;
  --background: white;
  --border-radius: 12px;
  box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
}

.dropdown-filters {
  display: flex;
  gap: 12px;
  margin-top: 12px;
}

.filter-item {
  --background: white;
  --border-radius: 8px;
  flex: 1;
  box-shadow: 0 1px 2px rgba(0,0,0,0.05);
}

.reset-button {
  margin: 0;
  height: 48px;
}
</style>
