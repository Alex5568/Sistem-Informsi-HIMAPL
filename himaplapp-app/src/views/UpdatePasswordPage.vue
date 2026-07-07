<template>
  <ion-page>
    <ion-content class="login-content" :fullscreen="true">
      <div class="login-container">
        <h1 class="logo-title">HIMAPL</h1>
        
        <div class="login-card">
          <h2 style="text-align: center; margin-bottom: 24px; font-weight: 600; font-size: 20px;">Update Password</h2>
          <p style="text-align: center; color: #64748b; font-size: 14px; margin-bottom: 24px;">Please enter your new password below.</p>
          
          <!-- NEW PASSWORD -->
          <div class="input-group">
            <label class="input-label">NEW PASSWORD</label>
            <div class="input-wrapper">
              <ion-icon
                :icon="lockClosedOutline"
                class="input-icon left-icon"
              ></ion-icon>
              <input
                :type="showPassword ? 'text' : 'password'"
                v-model="newPassword"
                placeholder="••••••••"
                class="custom-input"
              />
              <ion-icon
                :icon="showPassword ? eyeOffOutline : eyeOutline"
                class="input-icon right-icon"
                @click="togglePassword"
              ></ion-icon>
            </div>
          </div>

          <!-- CONFIRM PASSWORD -->
          <div class="input-group">
            <label class="input-label">CONFIRM PASSWORD</label>
            <div class="input-wrapper">
              <ion-icon
                :icon="lockClosedOutline"
                class="input-icon left-icon"
              ></ion-icon>
              <input
                :type="showPassword ? 'text' : 'password'"
                v-model="confirmPassword"
                placeholder="••••••••"
                class="custom-input"
              />
            </div>
          </div>

          <!-- UPDATE BUTTON -->
          <button class="primary-btn" @click="handleUpdatePassword" :disabled="isLoading">
            {{ isLoading ? 'Updating...' : 'Update Password' }}
          </button>
        </div>
      </div>
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { ref } from "vue";
import { IonPage, IonContent, IonIcon, toastController, menuController, onIonViewWillEnter, onIonViewWillLeave } from "@ionic/vue";
import { lockClosedOutline, eyeOutline, eyeOffOutline } from "ionicons/icons";
import { useRouter, useRoute } from "vue-router";
import { supabase } from "../supabase";

const router = useRouter();
const route = useRoute();

onIonViewWillEnter(() => {
  menuController.enable(false);
});

onIonViewWillLeave(() => {
  menuController.enable(true);
});

const showPassword = ref(false);
const newPassword = ref("");
const confirmPassword = ref("");
const isLoading = ref(false);

const togglePassword = () => {
  showPassword.value = !showPassword.value;
};

const handleUpdatePassword = async () => {
  if (!newPassword.value) {
    const toast = await toastController.create({ message: 'Password is required', duration: 2000, color: 'danger' });
    toast.present();
    return;
  }

  if (!confirmPassword.value) {
    const toast = await toastController.create({ message: 'Confirm password is required', duration: 2000, color: 'danger' });
    toast.present();
    return;
  }
  
  if (newPassword.value !== confirmPassword.value) {
    const toast = await toastController.create({ message: 'Passwords do not match', duration: 2000, color: 'danger' });
    toast.present();
    return;
  }
  
  if (newPassword.value.length < 6) {
    const toast = await toastController.create({ message: 'Password must be at least 6 characters', duration: 2000, color: 'danger' });
    toast.present();
    return;
  }

  isLoading.value = true;
  try {
    const payload: any = { password: newPassword.value };
    if (route.query.currentPassword) {
      payload.current_password = route.query.currentPassword;
    }
    const { error } = await supabase.auth.updateUser(payload);
    
    if (error) throw error;
    
    const toast = await toastController.create({
      message: 'Password updated successfully! You can now use your new password.',
      duration: 3000,
      color: 'success'
    });
    toast.present();
    
    // Redirect to home/profile after successful update
    router.replace('/tabs/home');
  } catch (error: any) {
    const toast = await toastController.create({
      message: error.message || 'Failed to update password',
      duration: 3000,
      color: 'danger'
    });
    toast.present();
  } finally {
    isLoading.value = false;
  }
};
</script>


