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
              <a href="#" class="forgot-link">FORGOT?</a>
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
            {{ isLoading ? 'Memproses...' : 'Login' }} <ion-icon v-if="!isLoading" :icon="arrowForward" class="btn-icon"></ion-icon>
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
import { IonPage, IonContent, IonIcon, toastController } from "@ionic/vue";
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

const handleLogin = async () => {
  if (!email.value || !password.value) {
    const toast = await toastController.create({
      message: 'Email dan password tidak boleh kosong.',
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
  const { error } = await supabase.auth.signInWithOAuth({
    provider: 'google',
    options: {
      redirectTo: window.location.origin + '/tabs/home'
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


