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
  router.push("/home");
};

const goToRegister = () => {
  console.log("Navigasi ke halaman register ...");
  router.push("/register");
};
</script>

<style scoped>
.login-content {
  --background: #f7f9fbcc;
}

.login-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  min-height: 100vh;
  padding: 24px;
}

.logo-title {
  font-size: 2.4rem;
  font-weight: 600;
  color: #184a85;
  margin-top: 0;
  margin-bottom: 32px;
  letter-spacing: 0.5px;
  text-align: center;
}

.login-card {
  background: white;
  width: 100%;
  max-width: 380px;
  border-radius: 28px;
  padding: 32px 28px;
  box-shadow: 0 10px 40px rgba(0, 0, 0, 0.05);
}

.input-group {
  margin-bottom: 24px;
}

.input-label {
  display: block;
  font-size: 0.75rem;
  font-weight: 700;
  color: #4a5568;
  margin-bottom: 8px;
  letter-spacing: 0.5px;
}

.label-row {
  display: flex;
  justify-content: space-between;
  align-items: flex-end;
  margin-bottom: 8px;
}

.label-row .input-label {
  margin-bottom: 0;
}

.forgot-link {
  font-size: 0.75rem;
  font-weight: 700;
  color: #1a4985;
  text-decoration: none;
}

.input-wrapper {
  position: relative;
  display: flex;
  align-items: center;
  background-color: #f3f4f6;
  border-radius: 14px;
  padding: 0 16px;
  height: 54px;
  transition: box-shadow 0.2s ease;
}

.input-wrapper:focus-within {
  box-shadow: 0 0 0 2px rgba(26, 73, 133, 0.2);
}

.input-icon {
  font-size: 1.25rem;
  color: #718096;
}

.left-icon {
  margin-right: 12px;
}

.right-icon {
  margin-left: 12px;
  cursor: pointer;
  color: #718096;
}

.right-icon:hover {
  color: #4a5568;
}

.custom-input {
  flex: 1;
  background: transparent;
  border: none;
  height: 100%;
  font-size: 0.95rem;
  color: #2d3748;
  outline: none;
  width: 100%;
}

.custom-input::placeholder {
  color: #a0aec0;
}

.primary-btn {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  height: 54px;
  background-color: #2b5a9b;
  color: white;
  font-size: 1rem;
  font-weight: 600;
  border: none;
  border-radius: 14px;
  cursor: pointer;
  margin-top: 8px;
  transition: all 0.2s ease;
}

.primary-btn:active {
  background-color: #1e457a;
  transform: scale(0.98);
}

.btn-icon {
  margin-left: 8px;
  font-size: 1.2rem;
}

.divider {
  display: flex;
  align-items: center;
  text-align: center;
  margin: 28px 0;
}

.divider::before,
.divider::after {
  content: "";
  flex: 1;
  border-bottom: 1px solid #e2e8f0;
}

.divider span {
  padding: 0 16px;
  font-size: 0.75rem;
  font-weight: 600;
  color: #718096;
  letter-spacing: 0.5px;
}

.secondary-btn {
  width: 100%;
  height: 54px;
  background-color: #e6ebf1;
  color: #1a4985;
  font-size: 1rem;
  font-weight: 600;
  border: none;
  border-radius: 14px;
  cursor: pointer;
  transition: all 0.2s ease;
}

.secondary-btn:active {
  background-color: #d2dbe5;
  transform: scale(0.98);
}
</style>
