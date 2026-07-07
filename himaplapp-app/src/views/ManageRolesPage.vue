<template>
  <ion-page>
    <ion-header class="ion-no-border">
      <ion-toolbar class="custom-toolbar">
        <ion-buttons slot="start">
          <ion-menu-button color="primary"></ion-menu-button>
        </ion-buttons>
        <ion-title>Manage Roles</ion-title>
      </ion-toolbar>
      <ion-toolbar class="custom-toolbar">
        <ion-segment v-model="activeSegment" @ionChange="segmentChanged">
          <ion-segment-button value="users">
            <ion-label>Users</ion-label>
          </ion-segment-button>
          <ion-segment-button value="divisions">
            <ion-label>Divisions</ion-label>
          </ion-segment-button>
        </ion-segment>
      </ion-toolbar>
    </ion-header>

    <ion-content class="ion-padding">
      <!-- USERS SEGMENT -->
      <div v-if="activeSegment === 'users'">
        <div class="page-header">
          <h1>Users & Roles</h1>
          <p>Assign and update user roles and permissions.</p>
        </div>
        
        <ion-list class="custom-list">
          <ion-item v-for="user in usersList" :key="user.id" class="user-item" @click="openUserRoleModal(user)" button>
            <ion-avatar slot="start">
              <img :src="user.avatar_url || 'https://ionicframework.com/docs/img/demos/avatar.svg'" />
            </ion-avatar>
            <ion-label>
              <h2>{{ user.nama }}</h2>
              <p v-if="user.nim">{{ user.nim }}</p>
              <p class="division-text" v-if="user.divisi">Divisi: {{ user.divisi.nama_divisi }}</p>
            </ion-label>
            <ion-badge :color="getRoleBadgeColor(user.displayRole)" slot="end">{{ user.displayRole }}</ion-badge>
          </ion-item>
        </ion-list>
      </div>

      <!-- DIVISIONS SEGMENT -->
      <div v-if="activeSegment === 'divisions'">
        <div class="page-header">
          <h1>Divisions</h1>
          <p>Create and manage organizational divisions.</p>
        </div>
        
        <ion-accordion-group>
          <ion-accordion v-for="div in divisionsList" :key="div.id" :value="String(div.id)">
            <ion-item slot="header" color="light">
              <ion-icon slot="start" :icon="peopleOutline" color="primary"></ion-icon>
              <ion-label>
                <h2>{{ div.nama_divisi }}</h2>
                <p>Ketua: <strong style="color: #475569;">{{ div.ketua_name || 'Belum ditugaskan' }}</strong></p>
              </ion-label>
            </ion-item>
            
            <div class="accordion-content" slot="content">
              <div style="display: flex; justify-content: flex-end; gap: 8px;">
                <ion-button fill="clear" @click="editDivision(div)">
                  <ion-icon slot="start" :icon="createOutline"></ion-icon>
                  Edit
                </ion-button>
                <ion-button fill="clear" color="danger" @click="deleteDivision(div.id)">
                  <ion-icon slot="start" :icon="trashOutline"></ion-icon>
                  Delete
                </ion-button>
              </div>
            </div>
          </ion-accordion>
        </ion-accordion-group>

        <ion-fab vertical="bottom" horizontal="end" slot="fixed">
          <ion-fab-button @click="openCreateDivisionAlert">
            <ion-icon :icon="addOutline"></ion-icon>
          </ion-fab-button>
        </ion-fab>
      </div>

      <!-- MODAL FOR EDITING USER -->
      <ion-modal :is-open="isModalOpen" @didDismiss="closeUserRoleModal">
        <ion-header>
          <ion-toolbar>
            <ion-title>Edit Role</ion-title>
            <ion-buttons slot="end">
              <ion-button @click="closeUserRoleModal">Close</ion-button>
            </ion-buttons>
          </ion-toolbar>
        </ion-header>
        <ion-content class="ion-padding" v-if="selectedUser">
          <div class="modal-user-info">
            <h2>{{ selectedUser.nama }}</h2>
            <p v-if="selectedUser.nim">{{ selectedUser.nim }}</p>
            <p>Current Role: <strong>{{ selectedUser.displayRole }}</strong></p>
          </div>

          <!-- Dosen Options -->
          <div v-if="currentUserRole === 'Dosen'">
            <ion-list>
              <ion-item>
                <ion-select v-model="editingUser.role" label="Role" label-placement="floating">
                  <ion-select-option value="Anggota">Anggota</ion-select-option>
                  <ion-select-option value="Ketua Divisi">Ketua Divisi</ion-select-option>
                  <ion-select-option value="Ketua">Ketua</ion-select-option>
                  <ion-select-option value="Wakil Ketua">Wakil Ketua</ion-select-option>
                  <ion-select-option value="Dosen">Dosen</ion-select-option>
                </ion-select>
              </ion-item>
              
              <ion-item v-if="editingUser.role === 'Ketua Divisi' || editingUser.role === 'Anggota'">
                <ion-select v-model="editingUser.divisi_id" label="Division" label-placement="floating">
                  <ion-select-option :value="null">None</ion-select-option>
                  <ion-select-option v-for="div in divisionsList" :key="div.id" :value="div.id">
                    {{ div.nama_divisi }}
                  </ion-select-option>
                </ion-select>
              </ion-item>
            </ion-list>
            <ion-button expand="block" class="ion-margin-top" @click="saveUserChanges">Save Changes</ion-button>
          </div>

          <!-- Ketua & Wakil Ketua Options -->
          <div v-else-if="currentUserRole === 'Ketua' || currentUserRole === 'Wakil Ketua'">
            <div v-if="selectedUser.role === 'Ketua' || selectedUser.role === 'Wakil Ketua' || selectedUser.role === 'Dosen'">
              <p class="error-text">You do not have permission to change the role of a {{ selectedUser.role }}.</p>
            </div>
            <div v-else>
              <ion-list>
                <ion-item>
                  <ion-select v-model="editingUser.role" label="Role" label-placement="floating">
                    <ion-select-option value="Anggota">Anggota</ion-select-option>
                    <ion-select-option value="Ketua Divisi">Ketua Divisi</ion-select-option>
                  </ion-select>
                </ion-item>
                
                <ion-item v-if="editingUser.role === 'Ketua Divisi' || editingUser.role === 'Anggota'">
                  <ion-select v-model="editingUser.divisi_id" label="Division" label-placement="floating">
                    <ion-select-option :value="null">None</ion-select-option>
                    <ion-select-option v-for="div in divisionsList" :key="div.id" :value="div.id">
                      {{ div.nama_divisi }}
                    </ion-select-option>
                  </ion-select>
                </ion-item>
              </ion-list>
              <ion-button expand="block" class="ion-margin-top" @click="saveUserChanges">Save Changes</ion-button>
            </div>
          </div>
        </ion-content>
      </ion-modal>

    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import {
  IonPage,
  IonHeader,
  IonToolbar,
  IonTitle,
  IonContent,
  IonButtons,
  IonMenuButton,
  IonIcon,
  IonSegment,
  IonSegmentButton,
  IonLabel,
  IonList,
  IonItem,
  IonAvatar,
  IonBadge,
  IonFab,
  IonFabButton,
  alertController,
  IonModal,
  IonButton,
  IonSelect,
  IonSelectOption,
  toastController,
  IonAccordionGroup,
  IonAccordion
} from '@ionic/vue';
import { shieldOutline, peopleOutline, addOutline, createOutline, trashOutline } from 'ionicons/icons';
import { ref, onMounted } from 'vue';
import { supabase } from '../supabase';

const activeSegment = ref('users');
const usersList = ref<any[]>([]);
const divisionsList = ref<any[]>([]);

const currentUserRole = ref('');

const isModalOpen = ref(false);
const selectedUser = ref<any>(null);
const editingUser = ref({
  role: '',
  divisi_id: null as number | null
});

onMounted(async () => {
  await fetchCurrentUser();
  await fetchData();
});

const segmentChanged = (e: any) => {
  activeSegment.value = e.detail.value;
};

const fetchCurrentUser = async () => {
  const { data: { user } } = await supabase.auth.getUser();
  if (user) {
    const { data } = await supabase.from('users').select('role').eq('id', user.id).single();
    if (data) {
      currentUserRole.value = data.role || '';
    }
  }
};

const fetchData = async () => {
  // Fetch divisions
  const { data: divData, error: divError } = await supabase.from('divisi').select('*').order('nama_divisi');
  if (divError) {
    console.error('Divisions fetch error:', divError);
    showToast(`Error loading divisions: ${divError.message}`);
  }
  if (divData) {
    divisionsList.value = divData;
  }

  // Fetch users with division
  const { data: userData, error: userError } = await supabase
    .from('users')
    .select(`
      *,
      divisi!users_divisi_id_fkey (
        nama_divisi
      )
    `)
    .order('created_at', { ascending: true }); // Order by created_at to easily find first Ketua

  if (userError) {
    console.error('Users fetch error:', userError);
    showToast(`Error loading users: ${userError.message}`);
  }

  if (userData) {
    usersList.value = userData.map((user: any) => {
      let displayRole = user.role || 'Anggota';
      return {
        ...user,
        displayRole
      };
    });

    // Also populate ketua_name in divisions based on current users
    divisionsList.value = divisionsList.value.map(div => {
      const ketua = usersList.value.find(u => u.role === 'Ketua Divisi' && u.divisi_id === div.id);
      return {
        ...div,
        ketua_name: ketua ? ketua.nama : null
      };
    });
  }
};

const getRoleBadgeColor = (role: string) => {
  switch (role) {
    case 'Dosen': return 'danger';
    case 'Ketua': return 'primary';
    case 'Wakil Ketua': return 'tertiary';
    case 'Ketua Divisi': return 'warning';
    default: return 'medium';
  }
};

const openCreateDivisionAlert = async () => {
  const alert = await alertController.create({
    header: 'New Division',
    inputs: [
      {
        name: 'nama_divisi',
        type: 'text',
        placeholder: 'Division Name'
      }
    ],
    buttons: [
      {
        text: 'Cancel',
        role: 'cancel'
      },
      {
        text: 'Create',
        handler: async (data) => {
          if (data.nama_divisi) {
            await createDivision(data.nama_divisi);
          }
        }
      }
    ]
  });
  await alert.present();
};

const createDivision = async (nama_divisi: string) => {
  const { error } = await supabase.from('divisi').insert([{ nama_divisi }]);
  if (error) {
    showToast('Failed to create division');
  } else {
    showToast('Division created successfully');
    await fetchData();
  }
};

const editDivision = async (div: any) => {
  const alert = await alertController.create({
    header: 'Edit Division',
    inputs: [
      {
        name: 'nama_divisi',
        type: 'text',
        value: div.nama_divisi,
        placeholder: 'Division Name'
      }
    ],
    buttons: [
      { text: 'Cancel', role: 'cancel' },
      {
        text: 'Save',
        handler: async (data) => {
          if (!data.nama_divisi) return false;
          const { error } = await supabase
            .from('divisi')
            .update({ nama_divisi: data.nama_divisi })
            .eq('id', div.id);
            
          if (error) {
            showToast('Failed to update division');
          } else {
            showToast('Division updated successfully');
            await fetchData();
          }
        }
      }
    ]
  });
  await alert.present();
};

const deleteDivision = async (id: number) => {
  const alert = await alertController.create({
    header: 'Confirm Delete',
    message: 'Are you sure you want to delete this division? Users in this division will have their division set to None.',
    buttons: [
      { text: 'Cancel', role: 'cancel' },
      {
        text: 'Delete',
        role: 'destructive',
        handler: async () => {
          const { error } = await supabase.from('divisi').delete().eq('id', id);
          if (error) {
            showToast('Failed to delete division');
          } else {
            showToast('Division deleted successfully');
            await fetchData();
          }
        }
      }
    ]
  });
  await alert.present();
};

const openUserRoleModal = (user: any) => {
  selectedUser.value = user;
  editingUser.value = {
    role: user.role,
    divisi_id: user.divisi_id
  };
  isModalOpen.value = true;
};

const closeUserRoleModal = () => {
  isModalOpen.value = false;
  selectedUser.value = null;
};

const saveUserChanges = async () => {
  if (!selectedUser.value) return;

  const updates: any = {
    role: editingUser.value.role,
    divisi_id: editingUser.value.divisi_id
  };

  const { error } = await supabase
    .from('users')
    .update(updates)
    .eq('id', selectedUser.value.id);

  if (error) {
    console.error('Update error:', error);
    showToast('Failed to update user');
  } else {
    // Handle syncing the divisi table's ketua_divisi_id
    try {
      if (editingUser.value.role === 'Ketua Divisi' && editingUser.value.divisi_id) {
         // Assign them as the head of the new division
         await supabase.from('divisi').update({ ketua_divisi_id: selectedUser.value.id }).eq('id', editingUser.value.divisi_id);
      }
      
      // If they were previously a Ketua Divisi, and we are either changing their role or their division, nullify the old division's head
      if (selectedUser.value.role === 'Ketua Divisi' && selectedUser.value.divisi_id) {
         if (editingUser.value.role !== 'Ketua Divisi' || editingUser.value.divisi_id !== selectedUser.value.divisi_id) {
             await supabase.from('divisi').update({ ketua_divisi_id: null }).eq('id', selectedUser.value.divisi_id);
         }
      }
    } catch (e) {
      console.error('Failed to sync divisi table:', e);
    }

    showToast('User updated successfully');
    closeUserRoleModal();
    await fetchData();
  }
};

const showToast = async (message: string) => {
  const toast = await toastController.create({
    message,
    duration: 2000,
    position: 'bottom'
  });
  await toast.present();
};
</script>

<style scoped>
.custom-toolbar {
  --background: #f8fafc;
  --border-width: 0;
}

ion-title {
  font-family: "Manrope", sans-serif;
  font-weight: 700;
  color: #1e293b;
}

ion-content {
  --background: #f8fafc;
}

.page-header {
  margin-bottom: 24px;
}

.page-header h1 {
  font-family: "Manrope", sans-serif;
  font-weight: 800;
  font-size: 28px;
  color: #0f172a;
  margin: 0 0 8px 0;
}

.page-header p {
  font-family: "Inter", sans-serif;
  font-size: 15px;
  color: #64748b;
  margin: 0;
}

.accordion-content {
  padding: 16px;
  background: white;
}

.custom-list {
  background: transparent;
}

.user-item {
  --background: white;
  --border-radius: 12px;
  --padding-start: 16px;
  margin-bottom: 12px;
  border-radius: 12px;
  box-shadow: 0 2px 4px rgba(0,0,0,0.02);
}

.user-item h2 {
  font-family: "Manrope", sans-serif;
  font-weight: 700;
  color: #1e293b;
}

.user-item p {
  font-family: "Inter", sans-serif;
  color: #64748b;
}

.division-text {
  font-size: 12px;
  color: #3b82f6 !important;
  font-weight: 500;
  margin-top: 4px;
}

.modal-user-info {
  margin-bottom: 24px;
  text-align: center;
}

.modal-user-info h2 {
  font-family: "Manrope", sans-serif;
  font-weight: 800;
  font-size: 24px;
  color: #0f172a;
  margin-bottom: 4px;
}

.modal-user-info p {
  font-family: "Inter", sans-serif;
  color: #64748b;
  margin: 4px 0;
}

.error-text {
  color: #ef4444;
  font-family: "Inter", sans-serif;
  text-align: center;
  margin-top: 24px;
}
</style>
