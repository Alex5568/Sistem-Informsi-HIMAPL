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
            <ion-item button class="profile-item" :detail="false">
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

        <!-- App Preferences -->
        <div class="menu-group">
          <h3 class="menu-group-title">App Preferences</h3>
          <ion-list class="profile-list" lines="none">
            <ion-item class="profile-item">
              <div class="item-icon-box bg-gray" slot="start">
                <ion-icon :icon="moonOutline" class="color-gray"></ion-icon>
              </div>
              <ion-label>Dark Mode</ion-label>
              <ion-toggle slot="end" v-model="darkModeEnabled" @ionChange="toggleDarkMode"></ion-toggle>
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
import { ref, onMounted } from 'vue';
import {
  IonPage, IonHeader, IonToolbar, IonButtons, IonBackButton, IonTitle,
  IonContent, IonList, IonItem, IonLabel, IonIcon, IonToggle, toastController,
  alertController
} from '@ionic/vue';
import {
  lockClosedOutline, logoGoogle, chevronForwardOutline,
  notificationsOutline, moonOutline, trashOutline
} from 'ionicons/icons';
import { supabase } from '../supabase';

const notificationsEnabled = ref(true);
const darkModeEnabled = ref(false);
const linkedGoogleEmail = ref<string | null>(null);
const googleIdentity = ref<any>(null);

onMounted(async () => {
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

const toggleDarkMode = (event: any) => {
  darkModeEnabled.value = event.detail.checked;
  if (darkModeEnabled.value) {
    document.body.classList.add('dark');
  } else {
    document.body.classList.remove('dark');
  }
};

const handleDeleteAccount = async () => {
  const toast = await toastController.create({
    message: 'Are you sure you want to delete your account? This action cannot be undone.',
    duration: 3000,
    color: 'danger',
    buttons: [
      {
        text: 'Cancel',
        role: 'cancel'
      },
      {
        text: 'Delete',
        role: 'confirm',
        handler: () => {
          console.log('Delete account confirmed');
        }
      }
    ]
  });
  await toast.present();
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
