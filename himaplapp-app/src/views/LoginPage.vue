<template>
  <ion-page>
    <ion-content class="login-content" :fullscreen="true">
      <div class="login-container">
        <h1 class="logo-title">HIMAPL</h1>

        <div class="login-card">
          <!-- EMAIL -->
          <div class="input-group">
            <label class="input-label">UNIVERSITY EMAIL</label>
            <div class="input-wrapper">
              <ion-icon
                :icon="atOutline"
                class="input-icon left-icon"
              ></ion-icon>
              <input
                type="email"
                v-model="email"
                placeholder="username@example.com"
                class="custom-input"
              />
            </div>
          </div>

          <!-- PASSWORD -->
          <div class="input-group">
            <div class="label-row">
              <label class="input-label">PASSWORD</label>
              <a href="#" class="forgot-link" @click.prevent="handleForgotPassword">FORGOT?</a>
            </div>
            <div class="input-wrapper">
              <ion-icon
                :icon="lockClosedOutline"
                class="input-icon left-icon"
              ></ion-icon>
              <input
                :type="showPassword ? 'text' : 'password'"
                v-model="password"
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

          <!-- LOGIN BUTTON -->
          <button class="primary-btn" @click="handleLogin" :disabled="isLoading">
            {{ isLoading ? 'Processing...' : 'Login' }} <ion-icon v-if="!isLoading" :icon="arrowForward" class="btn-icon"></ion-icon>
          </button>

          <!-- GOOGLE LOGIN BUTTON -->
          <button class="google-btn" @click="handleGoogleLogin">
            <!-- <ion-icon :icon="logoGoogle" class="google-icon"></ion-icon> -->
            <img src="../assets/shapes/google-logo.svg" alt="Google Logo" style="width: 20px; height: 20px; margin-right: 12px;">
            Sign in with Google
          </button>

          <!-- DIVIDER -->
          <div class="divider">
            <span>NEW HERE?</span>
          </div>

          <!-- REGISTER BUTTON -->
          <button class="secondary-btn" @click="goToRegister">
            Register/Sign Up
          </button>
        </div>
      </div>
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { ref } from "vue";
import { Capacitor } from '@capacitor/core';
import { IonPage, IonContent, IonIcon, toastController, alertController } from "@ionic/vue";
import {
  atOutline,
  lockClosedOutline,
  eyeOutline,
  eyeOffOutline,
  arrowForward,
  logoGoogle,
} from "ionicons/icons";
import { useRouter } from "vue-router";
import { supabase } from "../supabase";

const router = useRouter();

const showPassword = ref(false);
const email = ref("");
const password = ref("");
const isLoading = ref(false);

const togglePassword = () => {
  showPassword.value = !showPassword.value;
};

const handleForgotPassword = async () => {
  const alert = await alertController.create({
    header: 'Reset Password',
    message: 'Enter your email address to receive a password reset link.',
    inputs: [
      {
        name: 'email',
        type: 'email',
        placeholder: 'username@example.com',
        value: email.value // Pre-fill if already typed
      }
    ],
    buttons: [
      {
        text: 'Cancel',
        role: 'cancel'
      },
      {
        text: 'Send Link',
        handler: async (data) => {
          if (!data.email) {
            const toast = await toastController.create({ message: 'Email is required', duration: 2000, color: 'danger' });
            toast.present();
            return false;
          }
          
          try {
            // Arahkan native app ke halaman penengah Vercel untuk mem-bypass pemblokiran Chrome
            const isNative = Capacitor.isNativePlatform();
            const redirectUrl = isNative ? 'https://himapl-redirect.vercel.app' : window.location.origin + '/update-password';
            
            const { error } = await supabase.auth.resetPasswordForEmail(data.email, {
              redirectTo: redirectUrl
            });
            
            if (error) throw error;
            
            const toast = await toastController.create({ message: 'Password reset link sent to your email', duration: 3000, color: 'success' });
            toast.present();
          } catch (e: any) {
            const toast = await toastController.create({ message: e.message || 'Failed to send reset link', duration: 3000, color: 'danger' });
            toast.present();
          }
        }
      }
    ]
  });
  
  await alert.present();
};

const handleLogin = async () => {
  if (!email.value || !password.value) {
    const toast = await toastController.create({
      message: 'Email and password cannot be empty.',
      duration: 2000,
      color: 'warning'
    });
    return toast.present();
  }

  isLoading.value = true;
  
  const { data, error } = await supabase.auth.signInWithPassword({
    email: email.value,
    password: password.value,
  });

  isLoading.value = false;

  if (error) {
    const toast = await toastController.create({
      message: error.message,
      duration: 3000,
      color: 'danger'
    });
    return toast.present();
  }

  console.log("Login sukses:", data);
  router.push("/tabs/home");
};

const handleGoogleLogin = async () => {
  // Deteksi apakah sedang berjalan di Android/iOS (Native) atau Web Browser
  const isNative = (window as any).Capacitor?.isNativePlatform?.();
  
  const { error } = await supabase.auth.signInWithOAuth({
    provider: 'google',
    options: {
      redirectTo: isNative 
        ? 'himaplapp://tabs/home' 
        : window.location.origin + '/tabs/home',
      queryParams: {
        prompt: 'select_account'
      }
    }
  });
  
  if (error) {
    const toast = await toastController.create({
      message: error.message,
      duration: 3000,
      color: 'danger'
    });
    return toast.present();
  }
};

const goToRegister = () => {
  router.push("/register");
};
</script>


