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
          <button class="primary-btn" @click="handleLogin">
            Login <ion-icon :icon="arrowForward" class="btn-icon"></ion-icon>
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
import { IonPage, IonContent, IonIcon } from "@ionic/vue";
import {
  atOutline,
  lockClosedOutline,
  eyeOutline,
  eyeOffOutline,
  arrowForward,
} from "ionicons/icons";
import { useRouter } from "vue-router";

const router = useRouter();
const showPassword = ref(false);

const togglePassword = () => {
  showPassword.value = !showPassword.value;
};

const handleLogin = () => {
  console.log("Proses login berjalan ...");
  router.push("/tabs/home");
};

const goToRegister = () => {
  console.log("Navigasi ke halaman register ...");
  router.push("/register");
};
</script>


