<template>
  <ion-header class="ion-no-border custom-header-solid">
    <ion-toolbar>
      <ion-buttons slot="start">
        <ion-button class="menu-btn">
          <ion-menu-button></ion-menu-button>
        </ion-button>
      </ion-buttons>
      <ion-title class="header-title">{{ title }}</ion-title>
      <ion-avatar slot="end" class="header-avatar">
        <!-- <img alt="Profile" :src="image1" /> -->
      </ion-avatar>
    </ion-toolbar>
  </ion-header>
</template>

<script setup lang="ts">
import { 
  IonHeader, IonToolbar, IonButtons, IonButton, 
  IonMenuButton, IonTitle, IonAvatar 
} from "@ionic/vue";

// Mengatur properti judul agar bisa diubah di tiap halaman
defineProps({
  title: {
    type: String,
    default: "HIMAPL",
  },
});
</script>