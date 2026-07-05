<template>
  <ion-page>
    <ion-header class="ion-no-border">
      <ion-toolbar>
        <ion-buttons slot="start">
          <ion-back-button default-href="/tabs/profile"></ion-back-button>
        </ion-buttons>
        <ion-title>Settings</ion-title>
      </ion-toolbar>
    </ion-header>

    <ion-content class="app-background" :fullscreen="true">
      <div class="settings-container">
        
        <!-- Account Settings -->
        <div class="menu-group">
          <h3 class="menu-group-title">Account Settings</h3>
          <ion-list class="profile-list" lines="none">
            <ion-item button class="profile-item" :detail="false" @click="handleChangePassword">
              <div class="item-icon-box bg-orange" slot="start">
                <ion-icon :icon="lockClosedOutline" class="color-orange"></ion-icon>
              </div>
              <ion-label>Change Password</ion-label>
              <ion-icon :icon="chevronForwardOutline" slot="end" class="chevron-icon"></ion-icon>
            </ion-item>
            <ion-item button class="profile-item" :detail="false" @click="handleGoogleAccountClick">
              <div class="item-icon-box bg-blue" slot="start">
                <ion-icon :icon="logoGoogle" class="color-blue"></ion-icon>
              </div>
              <ion-label v-if="linkedGoogleEmail">{{ linkedGoogleEmail }}</ion-label>
              <ion-label v-else>Link Google Account</ion-label>
              <ion-icon v-if="!linkedGoogleEmail" :icon="chevronForwardOutline" slot="end" class="chevron-icon"></ion-icon>
            </ion-item>
          </ion-list>
        </div>

        <!-- Notifications -->
        <div class="menu-group">
          <h3 class="menu-group-title">Notifications</h3>
          <ion-list class="profile-list" lines="none">
            <ion-item class="profile-item">
              <div class="item-icon-box bg-gray" slot="start">
                <ion-icon :icon="notificationsOutline" class="color-gray"></ion-icon>
              </div>
              <ion-label>Push Notifications</ion-label>
              <ion-toggle slot="end" v-model="notificationsEnabled"></ion-toggle>
            </ion-item>
          </ion-list>
        </div>


        <!-- Privacy & Security -->
        <div class="menu-group">
          <h3 class="menu-group-title">Privacy & Security</h3>
          <ion-list class="profile-list" lines="none">
            <ion-item button class="profile-item" :detail="false" @click="handleDeleteAccount">
              <div class="item-icon-box" style="background: #fed7d7;" slot="start">
                <ion-icon :icon="trashOutline" style="color: #e53e3e;"></ion-icon>
              </div>
              <ion-label color="danger">Delete Account</ion-label>
            </ion-item>
          </ion-list>
        </div>

      </div>
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { ref, onMounted, watch } from 'vue';
import {
  IonPage, IonHeader, IonToolbar, IonButtons, IonBackButton, IonTitle,
  IonContent, IonList, IonItem, IonLabel, IonIcon, IonToggle, toastController,
  alertController
} from '@ionic/vue';
import {
  lockClosedOutline, logoGoogle, chevronForwardOutline,
  notificationsOutline, trashOutline
} from 'ionicons/icons';
import { supabase } from '../supabase';
import { useRouter } from 'vue-router';

const router = useRouter();

const notificationsEnabled = ref(true);

watch(notificationsEnabled, (newValue) => {
  localStorage.setItem('app_notifications_enabled', String(newValue));
});

const linkedGoogleEmail = ref<string | null>(null);
const googleIdentity = ref<any>(null);

onMounted(async () => {
  const savedNotifs = localStorage.getItem('app_notifications_enabled');
  if (savedNotifs !== null) {
    notificationsEnabled.value = savedNotifs === 'true';
  }

  const { data: { user } } = await supabase.auth.getUser();
  if (user && user.identities) {
    const identity = user.identities.find(id => id.provider === 'google');
    if (identity) {
      googleIdentity.value = identity;
      linkedGoogleEmail.value = identity.identity_data?.email || 'Linked to Google';
    }
  }
});

const handleGoogleAccountClick = async () => {
  if (!linkedGoogleEmail.value) {
    return linkGoogleAccount();
  }

  const alert = await alertController.create({
    header: 'Change Google Account',
    message: `Your account is currently linked to <strong>${linkedGoogleEmail.value}</strong>. Do you want to unlink it and link a new one?`,
    buttons: [
      {
        text: 'Cancel',
        role: 'cancel'
      },
      {
        text: 'Change',
        handler: async () => {
          if (googleIdentity.value) {
            try {
              const { error } = await supabase.auth.unlinkIdentity(googleIdentity.value);
              if (error) throw error;
              
              linkedGoogleEmail.value = null;
              googleIdentity.value = null;
              
              linkGoogleAccount();
            } catch (e: any) {
              const toast = await toastController.create({
                message: e.message || 'Failed to unlink account.',
                duration: 3000,
                color: 'danger'
              });
              toast.present();
            }
          }
        }
      }
    ]
  });
  
  await alert.present();
};

const handleChangePassword = async () => {
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) return;

  const isGoogleOnly = user.app_metadata?.providers?.includes('google') && !user.app_metadata?.providers?.includes('email');
  
  if (isGoogleOnly) {
    const alert = await alertController.create({
      header: 'Set App Password',
      message: 'You logged in using Google. Do you want to set an app password?',
      buttons: [
        { text: 'Cancel', role: 'cancel' },
        { text: 'Continue', handler: () => { router.push('/update-password'); } }
      ]
    });
    await alert.present();
    return;
  }

  const alert = await alertController.create({
    header: 'Confirm Password',
    message: 'Please enter your current password to continue.',
    inputs: [
      {
        name: 'oldPassword',
        type: 'password',
        placeholder: 'Current Password',
      }
    ],
    buttons: [
      {
        text: 'Forgot Password?',
        handler: async () => {
          if (user.email) {
            try {
              const isNative = typeof window !== 'undefined' && (window as any).Capacitor?.isNative;
              const redirectUrl = isNative ? 'himaplapp://update-password' : window.location.origin + '/update-password';
              
              const { error } = await supabase.auth.resetPasswordForEmail(user.email, {
                redirectTo: redirectUrl
              });
              
              if (error) throw error;
              showToast('Password reset link sent to your email', 'success');
            } catch (e: any) {
              showToast(e.message || 'Failed to send reset link', 'danger');
            }
          }
        }
      },
      {
        text: 'Cancel',
        role: 'cancel'
      },
      {
        text: 'Confirm',
        handler: async (data) => {
          if (!data.oldPassword) {
            showToast('Current password is required', 'danger');
            return false;
          }

          try {
            if (user.email) {
              const { error: signInError } = await supabase.auth.signInWithPassword({
                email: user.email,
                password: data.oldPassword
              });
              
              if (signInError) {
                showToast('Incorrect current password', 'danger');
                return false;
              }
            }
            // Password correct! Navigate to update password page
            router.push('/update-password');
          } catch (e: any) {
            showToast(e.message || 'Failed to verify password', 'danger');
            return false;
          }
        }
      }
    ]
  });

  await alert.present();
};

const showToast = async (msg: string, color: string) => {
  const toast = await toastController.create({
    message: msg,
    duration: 3000,
    color
  });
  toast.present();
};

const linkGoogleAccount = async () => {
  try {
    const { data, error } = await supabase.auth.linkIdentity({
      provider: 'google',
      options: {
        redirectTo: window.location.origin + '/tabs/profile'
      }
    });
    
    if (error) {
      throw error;
    }
    
    // Explicitly redirect if Supabase returns a URL (sometimes auto-redirect doesn't fire)
    if (data?.url) {
      window.location.href = data.url;
      return;
    }
    
    const toast = await toastController.create({
      message: 'Redirecting to Google...',
      duration: 2000,
      color: 'success'
    });
    await toast.present();
    
  } catch (error: any) {
    const toast = await toastController.create({
      message: error.message || 'Failed to link Google account',
      duration: 3000,
      color: 'danger'
    });
    await toast.present();
  }
};


const handleDeleteAccount = async () => {
  const alert = await alertController.create({
    header: 'Delete Account',
    message: 'Are you sure you want to delete your account? This action cannot be undone and will permanently remove your data.<br><br>Type <strong>DELETE ACCOUNT</strong> below to confirm deletion:',
    inputs: [
      {
        name: 'confirmation',
        type: 'text',
        placeholder: 'DELETE ACCOUNT'
      }
    ],
    buttons: [
      {
        text: 'Cancel',
        role: 'cancel'
      },
      {
        text: 'Delete Permanently',
        role: 'confirm',
        handler: async (data) => {
          if (data.confirmation !== 'DELETE ACCOUNT') {
            const toast = await toastController.create({
              message: 'Incorrect confirmation text. Deletion cancelled.',
              duration: 3000,
              color: 'warning'
            });
            await toast.present();
            return false;
          }

          try {
            // Hapus semua foto profil pengguna dari storage (jika ada) untuk menghemat penyimpanan
            const { data: authData } = await supabase.auth.getUser();
            if (authData?.user) {
              const { data: files, error: listError } = await supabase.storage.from('avatars').list('', {
                search: authData.user.id
              });
              
              if (listError) {
                console.error('Storage List Error (Mungkin karena RLS SELECT Policy):', listError);
              }
              
              if (files && files.length > 0) {
                const filesToRemove = files.map(f => f.name);
                const { error: removeError } = await supabase.storage.from('avatars').remove(filesToRemove);
                
                if (removeError) {
                  console.error('Storage Remove Error (Mungkin karena RLS DELETE Policy):', removeError);
                } else {
                  console.log('User avatars deleted:', filesToRemove);
                }
              }
            }

            // Memanggil RPC function untuk menghapus akun (dari database.types.ts)
            const { error } = await supabase.rpc('delete_my_account');
            
            if (error) throw error;
            
            // Log out secara lokal setelah berhasil di server
            await supabase.auth.signOut();
            
            const toast = await toastController.create({
              message: 'Your account has been successfully deleted.',
              duration: 3000,
              color: 'success'
            });
            await toast.present();
            
            // Redirect ke halaman login
            router.push('/login');
          } catch (error: any) {
            console.error("Failed to delete account:", error);
            const toast = await toastController.create({
              message: error.message || 'Failed to delete account. Try again later.',
              duration: 3000,
              color: 'danger'
            });
            await toast.present();
          }
        }
      }
    ]
  });
  await alert.present();
};
</script>

<style scoped>
.app-background {
  --background: #ebeff5;
}

.settings-container {
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
</style>
