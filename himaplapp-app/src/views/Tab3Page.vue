<template>
  <ion-page>
    <CustomHeader title="HIMAPL" />

    <ion-content class="app-background">
      <div class="notification-container">
        <h2 class="section-title">Today</h2>

        <!-- Card 1 -->
        <div class="notif-card unread">
          <div class="notif-icon-box bg-blue">
            <ion-icon :icon="calculatorOutline" class="notif-icon color-blue"></ion-icon>
          </div>
          <div class="notif-content">
            <div class="notif-header">
              <h3 class="notif-title">Meeting reminder</h3>
              <span class="notif-time text-blue">10M AGO</span>
            </div>
            <p class="notif-desc">
              Pertemuan yang diadakan oleh ketua anggota organisasi untuk menentukan kegiatan selanjutnya.
            </p>
            <div class="notif-actions">
              <ion-button class="btn-primary" fill="solid">Join Now</ion-button>
              <ion-button class="btn-secondary" fill="solid">Dismiss</ion-button>
            </div>
          </div>
        </div>

        <!-- Card 2 -->
        <div class="notif-card">
          <div class="notif-icon-box bg-orange">
            <ion-icon :icon="megaphoneOutline" class="notif-icon color-orange"></ion-icon>
          </div>
          <div class="notif-content">
            <div class="notif-header">
              <h3 class="notif-title">New Announcement</h3>
              <span class="notif-time text-gray">2H AGO</span>
            </div>
            <p class="notif-desc">
              HIMAPL v2.0 update log is now available. Check out the new dashboard features.
            </p>
          </div>
        </div>

      </div>
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonButton, IonMenuButton, IonAvatar, IonIcon } from '@ionic/vue';
import { calculatorOutline, megaphoneOutline } from 'ionicons/icons';
import CustomHeader from "@/components/CustomHeader.vue";
</script>

<style scoped>
.notification-container {
  padding: 16px;
}

.section-title {
  font-family: "Inter", sans-serif;
  font-size: 14px;
  font-weight: 500;
  color: #424750;
  margin-top: 8px;
  margin-bottom: 16px;
}

.notif-card {
  background: #ffffff;
  border-radius: 16px;
  padding: 16px;
  display: flex;
  gap: 16px;
  margin-bottom: 16px;
  box-shadow: 0px 8px 16px -8px rgba(0, 0, 0, 0.05);
  position: relative;
  overflow: hidden;
}

.notif-card.unread::before {
  content: "";
  position: absolute;
  left: 0;
  top: 0;
  bottom: 0;
  width: 4px;
  background-color: #184a85;
}

.notif-icon-box {
  width: 48px;
  height: 48px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}

.bg-blue {
  background: #dbe8fe;
}

.bg-orange {
  background: #fde2ba;
}

.notif-icon {
  font-size: 24px;
}

.color-blue {
  color: #2b5a9b;
}

.color-orange {
  color: #624000;
}

.notif-content {
  flex: 1;
}

.notif-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 4px;
}

.notif-title {
  font-family: "Manrope", sans-serif;
  font-size: 16px;
  font-weight: 700;
  color: #191c1e;
  margin: 0;
}

.notif-time {
  font-size: 10px;
  font-weight: 700;
  letter-spacing: 0.5px;
}

.text-blue {
  color: #184a85;
}

.text-gray {
  color: #424750;
}

.notif-desc {
  font-family: "Inter", sans-serif;
  font-size: 14px;
  color: #424750;
  line-height: 1.5;
  margin: 0 0 12px 0;
}

.notif-actions {
  display: flex;
  gap: 8px;
}

.notif-actions ion-button {
  margin: 0;
  height: 32px;
  font-family: "Inter", sans-serif;
  font-weight: 600;
  font-size: 12px;
  text-transform: none;
  --border-radius: 8px;
  --box-shadow: none;
}

.btn-primary {
  --background: #184a85;
  --color: #ffffff;
}

.btn-secondary {
  --background: #f4f5f8;
  --color: #424750;
}
</style>
