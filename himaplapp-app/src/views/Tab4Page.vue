<template>
  <ion-page>
    <CustomHeader title="Profile" />

    <ion-content :fullscreen="true" class="app-background">
      <PullToRefresh @refresh="handleRefresh" />
      <div class="profile-header-section">
        <ion-avatar class="profile-avatar">
          <img :src="userData?.avatar_url || 'https://ionicframework.com/docs/img/demos/avatar.svg'" alt="Profile Avatar" />
        </ion-avatar>
        <h2 class="profile-name" v-if="!isLoading">{{ userData?.nama || 'Guest' }}</h2>
        <h2 class="profile-name" v-else>Loading...</h2>
        <p class="profile-role" v-if="!isLoading">{{ userData?.nim || userData?.email }}</p>
        <ion-badge class="profile-badge" v-if="!isLoading">{{ userData?.role || 'No Role' }}</ion-badge>
      </div>

      <div class="profile-content-section">
        <div class="menu-group">
          <h3 class="app-section-title" style="margin-top: 24px;">Account</h3>
          <ion-list class="profile-list" lines="none">
            <ion-item button class="profile-item" :detail="false" @click="openEditModal">
              <div class="item-icon-box bg-blue" slot="start">
                <ion-icon :icon="personOutline" class="color-blue"></ion-icon>
              </div>
              <ion-label>Edit Profile</ion-label>
              <ion-icon :icon="chevronForwardOutline" slot="end" class="chevron-icon"></ion-icon>
            </ion-item>
          </ion-list>
        </div>

        <div class="menu-group">
          <h3 class="app-section-title" style="margin-top: 24px;">General</h3>
          <ion-list class="profile-list" lines="none">
            <ion-item button class="profile-item" :detail="false" @click="router.push('/settings')">
              <div class="item-icon-box bg-gray" slot="start">
                <ion-icon :icon="settingsOutline" class="color-gray"></ion-icon>
              </div>
              <ion-label>Settings</ion-label>
              <ion-icon :icon="chevronForwardOutline" slot="end" class="chevron-icon"></ion-icon>
            </ion-item>
            <ion-item button class="profile-item" :detail="false" @click="openHelpForm">
              <div class="item-icon-box bg-gray" slot="start">
                <ion-icon :icon="helpCircleOutline" class="color-gray"></ion-icon>
              </div>
              <ion-label>Help & Support</ion-label>
              <ion-icon :icon="chevronForwardOutline" slot="end" class="chevron-icon"></ion-icon>
            </ion-item>
          </ion-list>
        </div>

        <ion-button expand="block" class="logout-btn" v-slot="" fill="clear" @click="handleLogout" :disabled="isLoading">
          <ion-icon :icon="logOutOutline" slot="start"></ion-icon>
          {{ isLoading ? 'Logging out...' : 'Log Out' }}
        </ion-button>
      </div>
    </ion-content>

    <!-- Edit Profile Modal -->
    <ion-modal :is-open="isEditModalOpen" @didDismiss="closeEditModal">
      <ion-header class="ion-no-border">
        <ion-toolbar>
          <ion-title class="header-title">Edit Profile</ion-title>
          <ion-buttons slot="end">
            <ion-button @click="closeEditModal">Back</ion-button>
          </ion-buttons>
        </ion-toolbar>
      </ion-header>
      <ion-content class="app-background">
        <div class="profile-content-section">
          <div class="menu-group">
            <h3 class="menu-group-title">Personal Information</h3>
            <ion-list class="profile-list" lines="none">
              <ion-item class="profile-item">
                <ion-input label="Full Name" label-placement="stacked" v-model="editData.nama" type="text" placeholder="Masukkan nama"></ion-input>
              </ion-item>
              <ion-item class="profile-item">
                <ion-input label="NIM" label-placement="stacked" v-model="editData.nim" type="text" placeholder="Masukkan NIM"></ion-input>
              </ion-item>
              <ion-item class="profile-item">
                <div style="width: 100%; padding: 12px 0;">
                  <div style="font-size: 14px; color: #718096; margin-bottom: 8px;">Upload Avatar Baru (Otomatis Dikompresi)</div>
                  <input type="file" accept="image/*" @change="handleFileUpload" :disabled="isSaving" style="width: 100%; font-size: 14px;" />
                  
                  <div style="font-size: 14px; color: #718096; margin-top: 16px; margin-bottom: 4px;">Atau gunakan URL Avatar</div>
                  <ion-input v-model="editData.avatar_url" type="url" placeholder="https://..." style="--padding-start: 0; min-height: 40px;"></ion-input>
                </div>
              </ion-item>
            </ion-list>
          </div>
          
          <ion-button expand="block" style="--background: #2b5a9b; --color: white; margin-top: 24px; --border-radius: 12px; height: 48px; font-family: 'Inter', sans-serif; font-weight: 600;" fill="solid" @click="saveProfile" :disabled="isSaving">
            {{ isSaving ? 'Menyimpan...' : 'Simpan Perubahan' }}
          </ion-button>
        </div>
      </ion-content>
    </ion-modal>
  </ion-page>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';
import {
  IonPage, IonContent, IonAvatar, IonList, IonItem,
  IonIcon, IonLabel, IonBadge, IonButton,
  IonModal, IonHeader, IonToolbar, IonTitle, IonButtons, IonInput,
  toastController
} from '@ionic/vue';
import {
  personOutline, lockClosedOutline, settingsOutline,
  helpCircleOutline, logOutOutline, chevronForwardOutline
} from 'ionicons/icons';
import CustomHeader from "@/components/CustomHeader.vue";
import PullToRefresh from "@/components/PullToRefresh.vue";
import { supabase } from "../supabase";
import { useRouter } from 'vue-router';
import imageCompression from 'browser-image-compression';

const userData = ref<any>(null);
const isLoading = ref(true);
const router = useRouter();

const handleRefresh = async (event: any) => {
  await fetchUserProfile();
  event.target.complete();
};

const isEditModalOpen = ref(false);
const isSaving = ref(false);
const selectedFile = ref<File | null>(null);
const editData = ref({
  nama: '',
  nim: '',
  avatar_url: ''
});

const handleFileUpload = (event: any) => {
  const file = event.target.files[0];
  if (file) {
    selectedFile.value = file;
  }
};

const openEditModal = () => {
  if (userData.value) {
    editData.value = {
      nama: userData.value.nama || '',
      nim: userData.value.nim || '',
      avatar_url: userData.value.avatar_url || ''
    };
  }
  selectedFile.value = null;
  isEditModalOpen.value = true;
};

const closeEditModal = () => {
  isEditModalOpen.value = false;
};

const showToast = async (message: string, color: string = 'success') => {
  const toast = await toastController.create({
    message,
    duration: 2000,
    color,
    position: 'top'
  });
  await toast.present();
};

const openHelpForm = () => {
  window.open('https://docs.google.com/forms/d/e/1FAIpQLSeAoB7Gnw0kw_Pg4SiYO7CS_y_3wEpCSPADwv97zTMXgtMX0A/viewform?usp=publish-editor', '_blank');
};

const saveProfile = async () => {
  if (!userData.value || !userData.value.id) {
    showToast('Data profil belum dimuat dengan benar', 'danger');
    return;
  }
  
  isSaving.value = true;
  try {
    let finalAvatarUrl = editData.value.avatar_url;

    if (selectedFile.value) {
      const options = {
        maxSizeMB: 1,
        maxWidthOrHeight: 800,
        useWebWorker: true,
      };
      
      const compressedFile = await imageCompression(selectedFile.value, options);
      
      const fileName = `${userData.value.id}_${Date.now()}.jpg`;
      const { error: uploadError } = await supabase.storage
        .from('avatars')
        .upload(fileName, compressedFile, { upsert: true });

      if (uploadError) throw uploadError;

      const { data } = supabase.storage
        .from('avatars')
        .getPublicUrl(fileName);
        
      finalAvatarUrl = data.publicUrl;
    }

    const { error } = await supabase
      .from('users')
      .update({
        nama: editData.value.nama,
        nim: editData.value.nim,
        avatar_url: finalAvatarUrl
      })
      .eq('id', userData.value.id);

    if (error) throw error;
    
    // Update local data
    userData.value = {
      ...userData.value,
      nama: editData.value.nama,
      nim: editData.value.nim,
      avatar_url: finalAvatarUrl
    };
    
    showToast('Profil berhasil diperbarui!');
    closeEditModal();
  } catch (error: any) {
    console.error('Update Profile Error:', error);
    showToast(error.message || 'Gagal memperbarui profil', 'danger');
  } finally {
    isSaving.value = false;
  }
};

const fetchUserProfile = async () => {
    isLoading.value = true;
    try {
        const { data: authData, error: authError } = await supabase.auth.getUser();
        if (authError || !authData.user) {
            console.error("Auth Error:", authError);
            showToast("Sesi Anda telah berakhir, silakan login kembali", "warning");
            router.push('/login');
            return;
        }
        
        const { data: publicUser, error: publicError } = await supabase
            .from('users')
            .select('*')
            .eq('id', authData.user.id)
            .single();
            
        if (publicError) {
            console.warn("Public User Fetch Error, attempting auto-create:", publicError);
            
            // Auto-create user profile if it doesn't exist
            const newUserData = {
               id: authData.user.id,
               nama: authData.user.user_metadata?.full_name || authData.user.email?.split('@')[0] || 'User',
               email: authData.user.email || '',
               avatar_url: authData.user.user_metadata?.avatar_url || ''
            };
            
            const { data: insertedUser, error: insertError } = await supabase
                .from('users')
                .insert([newUserData])
                .select()
                .single();
                
            if (insertError) {
                console.error("Auto-create Error:", insertError);
                showToast("Profile data not found in database and failed to create", "danger");
            } else {
                console.log("Successfully created profile automatically:", insertedUser);
                userData.value = insertedUser;
                showToast("Profile successfully created from Google Sign In!", "success");
            }
        } else {
            console.log("Data from Supabase:", publicUser);
            userData.value = publicUser;
        }
    } catch (e: any) {
        console.error("Unexpected Error:", e);
        showToast("Terjadi kesalahan tidak terduga: " + e.message, "danger");
    } finally {
        isLoading.value = false;
    }
};

const handleLogout = async () => {
  try {
    isLoading.value = true;
    const { error } = await supabase.auth.signOut();
    
    if (error) throw error;
    
    // Opsional: Tambahkan toast notifikasi sukses jika diperlukan
    console.log("Berhasil log out");
    
    // Arahkan pengguna kembali ke halaman login
    // Pastikan Anda sudah mengimpor useRouter dari 'vue-router'
    router.push('/login'); 
  } catch (error: any) {
    console.error("Logout Error:", error.message);
  } finally {
    isLoading.value = false;
  }
};

onMounted(() => {
    fetchUserProfile();
});
</script>

<style scoped>
.profile-header-section {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 32px 16px 24px;
  background: white;
  border-bottom-left-radius: 24px;
  border-bottom-right-radius: 24px;
  box-shadow: 0px 12px 24px -12px rgba(0, 0, 0, 0.05);
}

.profile-avatar {
  width: 96px;
  height: 96px;
  border: 4px solid #ebeff5;
  margin-bottom: 16px;
  box-shadow: 0px 8px 16px rgba(0,0,0,0.1);
}

.profile-name {
  font-family: "Manrope", sans-serif;
  font-weight: 700;
  font-size: 22px;
  color: #191c1e;
  margin: 0 0 4px 0;
}

.profile-role {
  font-family: "Inter", sans-serif;
  font-size: 14px;
  color: #424750;
  margin: 0 0 12px 0;
}

.profile-badge {
  --background: #184a85;
  --color: #ffffff;
  padding: 6px 12px;
  font-size: 10px;
  letter-spacing: 0.5px;
  border-radius: 12px;
  font-weight: 600;
}

.profile-content-section {
  padding: 24px 16px;
}

.menu-group {
  margin-bottom: 24px;
}

.menu-group-title {
  font-family: "Inter", sans-serif;
  font-size: 13px;
  font-weight: 600;
  color: #718096;
  text-transform: uppercase;
  letter-spacing: 1px;
  margin: 0 0 12px 8px;
}

.profile-list {
  background: white;
  border-radius: 16px;
  padding: 8px 0;
  box-shadow: 0px 8px 16px -8px rgba(0, 0, 0, 0.05);
}

.profile-item {
  --padding-start: 16px;
  --inner-padding-end: 16px;
  --min-height: 60px;
  font-family: "Inter", sans-serif;
  font-weight: 500;
  font-size: 15px;
  color: #191c1e;
}

.item-icon-box {
  width: 36px;
  height: 36px;
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-right: 16px;
}

.bg-blue { background: #dbe8fe; }
.color-blue { color: #2b5a9b; }

.bg-orange { background: #fde2ba; }
.color-orange { color: #624000; }

.bg-gray { background: #f3f4f6; }
.color-gray { color: #4a5568; }

.chevron-icon {
  color: #a0aec0;
  font-size: 20px;
}

.logout-btn {
  margin-top: 32px;
  --color: #e53e3e;
  font-family: "Inter", sans-serif;
  font-weight: 600;
  font-size: 16px;
  }
</style>
