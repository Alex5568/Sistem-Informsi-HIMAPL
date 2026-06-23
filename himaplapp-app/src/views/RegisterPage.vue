<template>
  <ion-page>
    <ion-content class="login-content" :fullscreen="true">
      <div class="login-container">
        <h1 class="logo-title">HIMAPL</h1>

        <div class="login-card">
          <div class="input-group">
            <label class="input-label">FULL NAME</label>
            <div class="input-wrapper">
              <ion-icon
                :icon="personOutline"
                class="input-icon left-icon"
              ></ion-icon>
              <input
                type="text"
                placeholder="John Doe"
                class="custom-input"
                v-model="fullName"
              />
            </div>
          </div>

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
                v-model="email"
              />
            </div>
          </div>

          <div class="input-group">
            <label class="input-label">PASSWORD</label>
            <div class="input-wrapper">
              <ion-icon
                :icon="lockClosedOutline"
                class="input-icon left-icon"
              ></ion-icon>
              <input
                :type="showPassword ? 'text' : 'password'"
                placeholder="••••••••"
                class="custom-input"
                v-model="password"
              />
              <ion-icon
                :icon="showPassword ? eyeOffOutline : eyeOutline"
                class="input-icon right-icon"
                @click="togglePassword"
              ></ion-icon>
            </div>
          </div>

          <button class="primary-btn" @click="handleRegister" :disabled="isLoading">
            {{ isLoading ? 'Processing...' : 'Create Account' }}
            <ion-icon v-if="!isLoading" :icon="arrowForward" class="btn-icon"></ion-icon>
          </button>

          <div class="divider">
            <span>ALREADY HAVE AN ACCOUNT?</span>
          </div>

          <button class="secondary-btn" @click="goToLogin" :disabled="isLoading">
            Login Now
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
  personOutline,
  atOutline,
  lockClosedOutline,
  eyeOutline,
  eyeOffOutline,
  arrowForward,
} from "ionicons/icons";
import { useRouter } from "vue-router";
import { supabase } from "../supabase"; // Pastikan path ini sesuai dengan lokasi file supabase Anda

const router = useRouter();

// State Form
const fullName = ref("");
const email = ref("");
const password = ref("");
const showPassword = ref(false);
const isLoading = ref(false);

const togglePassword = () => {
  showPassword.value = !showPassword.value;
};

// Fungsi bantuan untuk menampilkan Toast (Pesan Alert Bawah/Atas)
const showToast = async (message: string, color: 'success' | 'danger') => {
  const toast = await toastController.create({
    message: message,
    duration: 3000,
    color: color,
    position: 'top'
  });
  await toast.present();
};

const handleRegister = async () => {
  // 1. Validasi Input Dasar
  if (!fullName.value || !email.value || !password.value) {
    showToast("Mohon lengkapi semua data.", "danger");
    return;
  }

  try {
    isLoading.value = true;
    
    // 2. Proses Registrasi ke Supabase
    const { data, error } = await supabase.auth.signUp({
      email: email.value,
      password: password.value,
      options: {
        data: {
          full_name: fullName.value, // Menyimpan Full Name di user metadata Supabase
        }
      }
    });

    // 3. Tangani jika ada error dari Supabase
    if (error) throw error;

    // 4. Jika sukses
    showToast("Registrasi berhasil! Silakan cek email untuk verifikasi.", "success");
    
    // Opsional: Bersihkan form
    fullName.value = "";
    email.value = "";
    password.value = "";

    // Arahkan ke halaman login
    router.push("/login");

  } catch (error: any) {
    showToast(error.message || "Gagal melakukan registrasi.", "danger");
  } finally {
    isLoading.value = false;
  }
};

const goToLogin = () => {
  router.push("/login");
};
</script>