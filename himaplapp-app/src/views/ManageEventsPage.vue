<template>
  <ion-page>
    <CustomHeader title="Manage Events" />
    <ion-content class="ion-padding app-background">
      <div class="manage-container">
        <h2>Events Management</h2>
        
        <ion-button expand="block" class="create-btn" @click="createEvent">
          Create Event
        </ion-button>

        <ion-accordion-group>
          <ion-accordion v-for="event in events" :key="event.id" :value="String(event.id)">
            <ion-item slot="header" color="light">
              <ion-label>
                <h2>ID: {{ event.id }}</h2>
                <p>{{ event.nama_event }}</p>
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
                    <input type="file" accept="image/*" @change="handleImageUpload" style="font-size: 12px; max-width: 200px;" />
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

            <ion-item>
              <ion-input type="text" label="Location" label-placement="floating" v-model="newEvent.location" placeholder="Enter location"></ion-input>
            </ion-item>

            <ion-item>
              <ion-input type="number" label="Quota" label-placement="floating" v-model="newEvent.kuota" placeholder="Enter quota (e.g. 100)"></ion-input>
            </ion-item>

            <ion-item>
              <ion-select label="Category" label-placement="floating" :multiple="true" v-model="newEvent.kategori">
                <ion-select-option value="Seminar">Seminar</ion-select-option>
                <ion-select-option value="Certificate">Certificate</ion-select-option>
                <ion-select-option value="Workshop">Workshop</ion-select-option>
                <ion-select-option value="Industrial Visit">Industrial Visit</ion-select-option>
                <ion-select-option value="Course">Course</ion-select-option>
                <ion-select-option value="Project">Project</ion-select-option>
                <ion-select-option value="Celebration">Celebration</ion-select-option>
                <ion-select-option value="Free">Free</ion-select-option>
                <ion-select-option value="Paid">Paid</ion-select-option>
                <ion-select-option value="Limited">Limited</ion-select-option>
                <ion-select-option value="Meeting">Meeting</ion-select-option>
              </ion-select>
            </ion-item>

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
                  
                  <ion-select label="Assign To" label-placement="floating" v-model="task.assign_type" @ionChange="task.assigned_to_id = null; task.assigned_to_divisi_id = null;" style="margin-top: 8px;">
                    <ion-select-option value="global">Global (Everyone)</ion-select-option>
                    <ion-select-option value="individu">Individu (Specific Person)</ion-select-option>
                    <ion-select-option value="kelompok">Kelompok (Division)</ion-select-option>
                  </ion-select>
                  
                  <ion-select v-if="task.assign_type === 'individu'" label="Select Person" label-placement="floating" v-model="task.assigned_to_id" style="margin-top: 8px;">
                    <ion-select-option v-for="u in usersList" :key="u.id" :value="u.id">{{ u.nama }}</ion-select-option>
                  </ion-select>
                  
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

    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { 
  IonPage, IonContent, IonButton, 
  IonAccordionGroup, IonAccordion, IonItem, IonLabel, IonIcon, toastController, alertController,
  IonModal, IonHeader, IonToolbar, IonTitle, IonButtons, IonList, IonInput, IonTextarea, IonSelect, IonSelectOption,
  IonSegment, IonSegmentButton, IonDatetime, IonDatetimeButton, IonPopover
} from '@ionic/vue';
import { createOutline, trashOutline } from 'ionicons/icons';
import { ref, onMounted } from 'vue';
import CustomHeader from '../components/CustomHeader.vue';
import { supabase } from '../supabase';

const events = ref<any[]>([]);
const isCreateModalOpen = ref(false);
const isSaving = ref(false);
const isUploadingImage = ref(false);
const selectedSegment = ref('event');
const isEditing = ref(false);
const editingEventId = ref<number | null>(null);

const usersList = ref<any[]>([]);
const divisiList = ref<any[]>([]);

const newTasks = ref<{ nama_tugas: string, assign_type: 'global' | 'individu' | 'kelompok', assigned_to_id: string | null, assigned_to_divisi_id: number | null }[]>([]);

const newEvent = ref({
  nama_event: '',
  deskripsi: '',
  start_date: '',
  end_date: '',
  location: '',
  kuota: null as number | null,
  kategori: [] as string[],
  status: 'DRAFT',
  image_url: ''
});

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
      .select('id, nama_event')
      .order('id', { ascending: false });
      
    if (error) throw error;
    if (data) events.value = data;
  } catch (error) {
    console.error('Error fetching events:', error);
  }
};

const fetchUsersAndDivisi = async () => {
  try {
    const [usersRes, divisiRes] = await Promise.all([
      supabase.from('users').select('id, nama').order('nama'),
      supabase.from('divisi').select('id, nama_divisi').order('nama_divisi')
    ]);
    if (usersRes.data) usersList.value = usersRes.data;
    if (divisiRes.data) divisiList.value = divisiRes.data;
  } catch (err) {
    console.error('Error fetching users/divisi', err);
  }
};

onMounted(() => {
  fetchEvents();
  fetchUsersAndDivisi();
});

const createEvent = () => {
  isEditing.value = false;
  editingEventId.value = null;
  
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
    location: '',
    kuota: null,
    kategori: [],
    status: 'DRAFT',
    image_url: ''
  };
  newTasks.value = [];
  selectedSegment.value = 'event';
  isCreateModalOpen.value = true;
};

const handleImageUpload = async (event: Event) => {
  const target = event.target as HTMLInputElement;
  const file = target.files?.[0];
  if (!file) return;

  isUploadingImage.value = true;
  try {
    const fileExt = file.name.split('.').pop();
    const fileName = `${Math.random()}.${fileExt}`;
    const filePath = `events/${fileName}`;

    const { error: uploadError } = await supabase.storage
      .from('DOKUMENTASI-EVENT') 
      .upload(filePath, file);

    if (uploadError) throw uploadError;

    const { data: { publicUrl } } = supabase.storage
      .from('DOKUMENTASI-EVENT')
      .getPublicUrl(filePath);

    newEvent.value.image_url = publicUrl;
    showToast('Image uploaded', 'success');
  } catch (error: any) {
    console.error('Upload error:', error);
    showToast('Failed to upload image', 'danger');
  } finally {
    isUploadingImage.value = false;
  }
};

const addTask = () => {
  newTasks.value.push({ 
    nama_tugas: '', 
    assign_type: 'global',
    assigned_to_id: null,
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
      location: newEvent.value.location || null,
      kuota: newEvent.value.kuota ? Number(newEvent.value.kuota) : null,
      kategori: newEvent.value.kategori.length > 0 ? (newEvent.value.kategori as any) : null,
      status: newEvent.value.status as any,
      created_by: user.id
    };

    if (isEditing.value && editingEventId.value) {
      const { error: updateError } = await supabase
        .from('events')
        .update(payload)
        .eq('id', editingEventId.value);
        
      if (updateError) throw updateError;
      
      await supabase.from('tugas').delete().eq('event_id', editingEventId.value);
      
      const validTasks = newTasks.value.filter(t => t.nama_tugas.trim() !== '');
      if (validTasks.length > 0) {
        const tasksPayload = validTasks.map(t => ({
          nama_tugas: t.nama_tugas,
          event_id: editingEventId.value,
          assigned_by_id: user.id,
          assigned_to_id: t.assign_type === 'individu' ? t.assigned_to_id : null,
          assigned_to_divisi_id: t.assign_type === 'kelompok' ? t.assigned_to_divisi_id : null
        }));
        await supabase.from('tugas').insert(tasksPayload);
      }

      if (newEvent.value.image_url) {
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
          assigned_to_id: t.assign_type === 'individu' ? t.assigned_to_id : null,
          assigned_to_divisi_id: t.assign_type === 'kelompok' ? t.assigned_to_divisi_id : null
        }));
        await supabase.from('tugas').insert(tasksPayload);
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
      .select('nama_tugas, assigned_to_id, assigned_to_divisi_id')
      .eq('event_id', event.id);
      
    if (tasksError) throw tasksError;

    const { data: docData } = await supabase
      .from('dokumentasi')
      .select('url_foto')
      .eq('event_id', event.id)
      .order('created_at', { ascending: false })
      .limit(1);

    newEvent.value = {
      nama_event: eventData.nama_event,
      deskripsi: eventData.deskripsi || '',
      start_date: eventData.start_date ? eventData.start_date.slice(0, 16) : '',
      end_date: eventData.end_date ? eventData.end_date.slice(0, 16) : '',
      location: eventData.location || '',
      kuota: eventData.kuota,
      kategori: eventData.kategori || [],
      status: eventData.status || 'DRAFT',
      image_url: docData && docData.length > 0 ? docData[0].url_foto : ''
    };

    newTasks.value = tasksData ? tasksData.map(t => {
      let type: 'global' | 'individu' | 'kelompok' = 'global';
      if (t.assigned_to_id) type = 'individu';
      else if (t.assigned_to_divisi_id) type = 'kelompok';
      return {
        nama_tugas: t.nama_tugas,
        assign_type: type,
        assigned_to_id: t.assigned_to_id,
        assigned_to_divisi_id: t.assigned_to_divisi_id
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
</style>
