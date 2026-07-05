<template>
  <ion-page>
    <CustomHeader title="Manage Notifications" />
    <ion-content class="ion-padding app-background">
      <div class="manage-container">
        <h2>Notification Management</h2>
        
        <ion-button expand="block" class="create-btn" @click="createNotif">
          Create Notification
        </ion-button>

        <ion-accordion-group>
          <ion-accordion v-for="notif in notifList" :key="notif.id" :value="notif.id">
            <ion-item slot="header" color="light">
              <ion-label>
                <h2 style="font-weight: 600;">{{ notif.judul }}</h2>
                <p>
                  <span v-if="notif.tipe === 'PERSONAL'">👤 Personal</span>
                  <span v-else-if="notif.tipe === 'GROUP'">👥 Group</span>
                  <span v-else>🌍 Global</span>
                  • {{ new Date(notif.created_at).toLocaleDateString() }}
                </p>
              </ion-label>
            </ion-item>
            
            <div class="accordion-content" slot="content">
              <p style="margin-bottom: 16px; font-size: 14px; color: #475569; white-space: pre-wrap;">{{ notif.pesan }}</p>
              
              <div style="display: flex; justify-content: flex-end; gap: 8px; border-top: 1px solid #e2e8f0; padding-top: 12px;">
                <ion-button fill="clear" @click="editNotif(notif)">
                  <ion-icon slot="start" :icon="createOutline"></ion-icon>
                  Edit
                </ion-button>
                <ion-button fill="clear" color="danger" @click="deleteNotif(notif.id)">
                  <ion-icon slot="start" :icon="trashOutline"></ion-icon>
                  Delete
                </ion-button>
              </div>
            </div>
          </ion-accordion>
        </ion-accordion-group>
      </div>

      <!-- Create/Edit Notification Modal -->
      <ion-modal :is-open="isCreateModalOpen" @didDismiss="isCreateModalOpen = false">
        <ion-header>
          <ion-toolbar>
            <ion-title>{{ isEditing ? 'Edit Notification' : 'Create Notification' }}</ion-title>
            <ion-buttons slot="end">
              <ion-button @click="isCreateModalOpen = false">Cancel</ion-button>
            </ion-buttons>
          </ion-toolbar>
        </ion-header>
        <ion-content class="ion-padding">
          <ion-list>
            <ion-item>
              <ion-input label="Title" label-placement="floating" v-model="newNotif.judul" placeholder="Enter title"></ion-input>
            </ion-item>
            
            <ion-item>
              <ion-select label="Assign To" label-placement="floating" v-model="newNotif.assign_type" @ionChange="newNotif.user_ids = []; newNotif.divisi_id = null;">
                <ion-select-option value="GLOBAL">Global (Everyone)</ion-select-option>
                <ion-select-option value="PERSONAL">Specific Person</ion-select-option>
                <ion-select-option value="GROUP">Specific Group/Divisi</ion-select-option>
              </ion-select>
            </ion-item>

            <ion-item v-if="newNotif.assign_type === 'PERSONAL'" button @click="isUserSelectModalOpen = true">
              <ion-input label="Select Persons" label-placement="floating" readonly :value="selectedUserName" placeholder="Click to select persons"></ion-input>
            </ion-item>

            <ion-item v-if="newNotif.assign_type === 'GROUP'">
              <ion-input label="Divisi ID" label-placement="floating" type="number" v-model.number="newNotif.divisi_id" placeholder="Enter Divisi ID"></ion-input>
            </ion-item>
          
            <ion-item>
              <ion-textarea label="Message" label-placement="floating" v-model="newNotif.pesan" placeholder="Enter notification message..." :auto-grow="true" :rows="5"></ion-textarea>
            </ion-item>
          </ion-list>
          
          <ion-button expand="block" class="save-btn" @click="saveNotif" :disabled="isSaving">
            {{ isSaving ? 'Saving...' : (isEditing ? 'Update Notification' : 'Save Notification') }}
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
              <ion-checkbox slot="start" :checked="newNotif.user_ids.includes(u.id)" @ionChange="toggleUserSelection(u.id, $event)"></ion-checkbox>
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

    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { 
  IonPage, IonContent, IonButton, 
  IonAccordionGroup, IonAccordion, IonItem, IonLabel, IonIcon, toastController, alertController,
  IonModal, IonHeader, IonToolbar, IonTitle, IonButtons, IonList, IonInput, IonTextarea, IonSelect, IonSelectOption, IonSearchbar, IonCheckbox
} from '@ionic/vue';
import { createOutline, trashOutline } from 'ionicons/icons';
import { ref, onMounted, computed } from 'vue';
import CustomHeader from '../components/CustomHeader.vue';
import { supabase } from '../supabase';

const notifList = ref<any[]>([]);
const usersList = ref<any[]>([]);
const isCreateModalOpen = ref(false);
const isSaving = ref(false);
const isEditing = ref(false);
const editingNotifId = ref<number | null>(null);

const newNotif = ref({
  judul: '',
  pesan: '',
  assign_type: 'GLOBAL',
  user_ids: [] as string[],
  divisi_id: null as number | null
});

const isUserSelectModalOpen = ref(false);
const userSearchQuery = ref('');

const filteredUsers = computed(() => {
  const query = userSearchQuery.value.toLowerCase();
  if (!query) return usersList.value;
  return usersList.value.filter(u => 
    u.nama.toLowerCase().includes(query) || 
    (u.nim && u.nim.toLowerCase().includes(query))
  );
});

const selectedUserName = computed(() => {
  if (newNotif.value.user_ids.length === 0) return '';
  if (newNotif.value.user_ids.length === 1) {
    const u = usersList.value.find(user => user.id === newNotif.value.user_ids[0]);
    return u ? (u.nim ? `${u.nama} (${u.nim})` : u.nama) : '';
  }
  return `${newNotif.value.user_ids.length} persons selected`;
});

const toggleUserSelection = (id: string, event: any) => {
  const isChecked = event.detail.checked;
  if (isChecked && !newNotif.value.user_ids.includes(id)) {
    newNotif.value.user_ids.push(id);
  } else if (!isChecked) {
    newNotif.value.user_ids = newNotif.value.user_ids.filter(uid => uid !== id);
  }
};

const showToast = async (msg: string, color: string) => {
  const toast = await toastController.create({
    message: msg,
    duration: 2000,
    color: color
  });
  toast.present();
};

const fetchNotifsAndUsers = async () => {
  try {
    const [notifRes, userRes] = await Promise.all([
      supabase.from('notifikasi').select('*').order('created_at', { ascending: false }),
      supabase.from('users').select('id, nama, nim').order('nama')
    ]);
      
    if (notifRes.error) throw notifRes.error;
    if (notifRes.data) notifList.value = notifRes.data;

    if (userRes.error) throw userRes.error;
    if (userRes.data) usersList.value = userRes.data;

  } catch (error) {
    console.error('Error fetching data:', error);
  }
};

onMounted(() => {
  fetchNotifsAndUsers();
});

const getUserName = (id: string) => {
  const u = usersList.value.find(user => user.id === id);
  return u ? (u.nim ? `${u.nama} (${u.nim})` : u.nama) : 'Unknown';
};

const createNotif = () => {
  isEditing.value = false;
  editingNotifId.value = null;
  newNotif.value = {
    judul: '',
    pesan: '',
    assign_type: 'GLOBAL',
    user_ids: [],
    divisi_id: null
  };
  isCreateModalOpen.value = true;
};

const saveNotif = async () => {
  if (!newNotif.value.judul) {
    showToast('Title is required', 'warning');
    return;
  }
  if (!newNotif.value.pesan) {
    showToast('Message is required', 'warning');
    return;
  }
  if (newNotif.value.assign_type === 'PERSONAL' && newNotif.value.user_ids.length === 0) {
    showToast('Please select at least one person', 'warning');
    return;
  }

  isSaving.value = true;
  try {
    const { data: authData } = await supabase.auth.getUser();
    const senderId = authData?.user?.id || null;

    const payload = {
      judul: newNotif.value.judul,
      pesan: newNotif.value.pesan,
      tipe: newNotif.value.assign_type as "GLOBAL" | "PERSONAL" | "GROUP",
      sender_id: senderId
    };

    if (isEditing.value && editingNotifId.value) {
      // For editing, just update the notification details
      const { error: updateError } = await supabase
        .from('notifikasi')
        .update({ judul: payload.judul, pesan: payload.pesan })
        .eq('id', editingNotifId.value);
        
      if (updateError) throw updateError;
      showToast('Notification updated successfully', 'success');
    } else {
      const { data: insertedNotif, error: insertError } = await supabase
        .from('notifikasi')
        .insert([payload])
        .select()
        .single();
        
      if (insertError) throw insertError;
      
      const notifId = insertedNotif.id;
      let targetUserIds: string[] = [];

      if (newNotif.value.assign_type === 'GLOBAL') {
        const { data: allUsers } = await supabase.from('users').select('id');
        if (allUsers) targetUserIds = allUsers.map((u: any) => u.id);
      } else if (newNotif.value.assign_type === 'PERSONAL') {
        if (newNotif.value.user_ids.length > 0) targetUserIds.push(...newNotif.value.user_ids);
      } else if (newNotif.value.assign_type === 'GROUP') {
        if (newNotif.value.divisi_id) {
           const { data: groupUsers } = await supabase.from('users').select('id').eq('divisi_id', newNotif.value.divisi_id);
           if (groupUsers) targetUserIds = groupUsers.map((u: any) => u.id);
        }
      }

      if (targetUserIds.length > 0) {
        const pivotPayload = targetUserIds.map(uid => ({
          notif_id: notifId,
          user_id: uid,
          is_read: false
        }));
        await supabase.from('penerima_notifikasi').insert(pivotPayload);
      }

      showToast('Notification created successfully', 'success');
    }
    
    isCreateModalOpen.value = false;
    fetchNotifsAndUsers();
  } catch (error: any) {
    console.error('Error saving notification:', error);
    showToast(error.message || 'Failed to save notification', 'danger');
  } finally {
    isSaving.value = false;
  }
};

const editNotif = (notif: any) => {
  isEditing.value = true;
  editingNotifId.value = notif.id;
  newNotif.value = {
    judul: notif.judul,
    pesan: notif.pesan || '',
    assign_type: notif.tipe || 'GLOBAL',
    user_ids: [],
    divisi_id: null
  };
  isCreateModalOpen.value = true;
};

const deleteNotif = async (id: number) => {
  const alert = await alertController.create({
    header: 'Confirm Delete',
    message: 'Are you sure you want to delete this notification?',
    buttons: [
      { text: 'Cancel', role: 'cancel' },
      {
        text: 'Delete',
        role: 'confirm',
        handler: async () => {
          try {
            const { error } = await supabase.from('notifikasi').delete().eq('id', id);
            if (error) throw error;
            notifList.value = notifList.value.filter(n => n.id !== id);
            showToast('Notification deleted successfully', 'success');
          } catch (err: any) {
            console.error('Error deleting notification:', err);
            showToast('Failed to delete notification', 'danger');
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
  background: white;
}
.save-btn {
  margin-top: 24px;
  --background: #2563eb;
  font-weight: 600;
}
</style>
