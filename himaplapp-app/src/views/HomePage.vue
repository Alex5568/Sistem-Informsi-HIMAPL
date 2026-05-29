<template>
  <ion-page>
    <ion-header>
      <ion-toolbar mode="md">
        <ion-buttons slot="start" class="ion-padding-start">
          <ion-menu-toggle>
            <div class="avatar-button" button>
              <ion-avatar>
                <img src="https://ionicframework.com/docs/img/demos/avatar.svg" alt="Profile" />
              </ion-avatar>
            </div>
          </ion-menu-toggle>
        </ion-buttons>
        <ion-title color="primary">HIMAPL</ion-title>
      </ion-toolbar>
    </ion-header>

    <ion-content class="bg-light">
      
      <ion-card class="event-card">
        <div class="card-header-flex">
          <div class="date-section">
            <p class="subtitle">Highlight HIMAPL</p>
            <h2 class="title">Upcoming Event</h2>
          </div>
          
          <ion-button shape="round" class="event-btn" mode="ios">
            <ion-icon slot="start" :icon="listOutline"></ion-icon>
            All Events
          </ion-button>
        </div>

        <div class="divider"></div>

        <ion-card-content class="card-body">
          <div class="event-details">
            <h3 class="event-title">Workshop Game Development</h3>
            
            <div class="event-info-row">
              <ion-icon :icon="timeOutline" color="medium"></ion-icon>
              <span>Sat, 18 Apr • 10:00 AM - 14:00 PM</span>
            </div>
            
            <div class="event-info-row">
              <ion-icon :icon="locationOutline" color="medium"></ion-icon>
              <span>Lab Komputer Gedung B, UVERS</span>
            </div>
          </div>
        </ion-card-content>
      </ion-card>

    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { 
  IonPage, IonHeader, IonToolbar, IonTitle, 
  IonContent, IonButtons, IonAvatar, IonMenuToggle,
  IonCard, IonCardContent, IonButton, IonIcon, 
  alertController, onIonViewDidEnter 
} from '@ionic/vue';

// Import ikon yang relevan untuk acara
import { listOutline, timeOutline, locationOutline } from 'ionicons/icons';

// Logika Pop-Up Pengumuman (Sama seperti sebelumnya)
const tampilkanPengumuman = async () => {
  const sudahLihat = sessionStorage.getItem('sudahLihatPengumuman');
  if (sudahLihat === 'true') return; 

  const alert = await alertController.create({
    header: 'Pengumuman Penting!',
    subHeader: 'Rapat Evaluasi',
    message: 'Seluruh anggota HIMAPL diwajibkan hadir pada rapat evaluasi proyek yang akan diadakan besok di ruang lab komputer.',
    buttons: ['Saya Mengerti'],
  });

  await alert.present();
  sessionStorage.setItem('sudahLihatPengumuman', 'true');
};

onIonViewDidEnter(() => {
  tampilkanPengumuman();
});
</script>

<style scoped>
.bg-light {
  --background: var(--ion-color-light); 
}

.event-card {
  border-radius: 16px;
  margin: 16px;
  background: var(--ion-color-light);
  box-shadow: 0 4px 12px rgba(0,0,0,0.1);
}

.card-header-flex {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px 20px 12px 20px;
}

.date-section .subtitle {
  margin: 0;
  font-size: 14px;
  color: #666;
}

.date-section .title {
  margin: 4px 0 0 0;
  font-size: 20px;
  font-weight: 700;
  color: #222;
}

.event-btn {
  --background: #E8F5E9; 
  --color: #2E7D32;      
  --box-shadow: none;    
  font-weight: 600;
  height: 36px;
  text-transform: none;  
}

.divider {
  height: 1px;
  background-color: #E0E0E0;
  margin: 0 20px;
}

/* Gaya khusus untuk Detail Acara di bawah garis pembatas */
.card-body {
  padding: 16px 20px 24px 20px;
}

.event-details {
  display: flex;
  flex-direction: column;
  gap: 10px; /* Memberi jarak antar baris teks */
}

.event-title {
  font-size: 18px;
  font-weight: 600;
  color: #111;
  margin: 0 0 4px 0;
}

.event-info-row {
  display: flex;
  align-items: center;
  gap: 8px; /* Jarak antara Ikon dan Teks */
  color: #555;
  font-size: 14px;
}

.event-info-row ion-icon {
  font-size: 18px;
}

.avatar-button {
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
}
.avatar-button ion-avatar {
  width: 32px;
  height: 32px;
  border: 2px solid white;
}
</style>