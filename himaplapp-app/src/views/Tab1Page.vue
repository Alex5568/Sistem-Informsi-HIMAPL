<template>
  <ion-page>
    <CustomHeader title="HIMAPL" />

    <ion-content class="app-background">
      <div class="ion-padding">
        
        <div class="urgent-card">
          <div class="urgent-header">
            <ion-badge class="urgent-badge">URGENT</ion-badge>
            <div class="urgent-date">
              <ion-icon :icon="calendarOutline"></ion-icon>
              <span>TOMORROW</span>
            </div>
          </div>
          
          <h2 class="urgent-title">
            Seminar: Advanced<br />UI/UX Design
          </h2>
          <p class="urgent-subtitle">
            Kembangkan skill desain antarmuka<br />modern bersama praktisi industri.
          </p>

          <div class="urgent-footer">
            <div class="urgent-time">
              <span class="time-label">TIME & LOCATION</span>
              <span class="time-value">09:00 WIB • Ruang<br />500</span>
            </div>
            <ion-button class="register-btn" fill="solid" shape="round">
              Daftar<br />Sekarang
            </ion-button>
          </div>
        </div>

        <div class="news-section">
          <div class="news-header">
            <h3>Kabar Terbaru</h3>
            <ion-button fill="clear" class="see-all-btn">SEE ALL</ion-button>
          </div>

          <ion-card class="news-card">
            <div class="news-card-content">
              <ion-thumbnail class="news-thumbnail">
                <!-- <img :src="image" alt="News Image" /> -->
              </ion-thumbnail>
              <div class="news-info">
                <div class="news-meta">
                  <ion-badge class="badge-announcement">ANNOUNCEMENT</ion-badge>
                  <span class="news-time">2h ago</span>
                </div>
                <h4 class="news-title">Perwaliaan TPL Sebelum UAS</h4>
                <p class="news-desc">
                  Perwalian akan diadakan di ruang 315 pukul 19:00 WIB, pada tanggal 1 Juli 2026.
                </p>
              </div>
            </div>
          </ion-card>

          <ion-card class="news-card">
            <div class="news-card-content">
              <ion-thumbnail class="news-thumbnail">
                <!-- <img :src="image2" alt="News Image" /> -->
              </ion-thumbnail>
              <div class="news-info">
                <div class="news-meta">
                  <ion-badge class="badge-achievement">PRESTASI</ion-badge>
                  <span class="news-time">Yesterday</span>
                </div>
                <h4 class="news-title">Tim HIMAPL Raih Juara 1 di Game Jam UVERS</h4>
                <p class="news-desc">
                  Tim TPL yang terdiri dari beberapa angkatan berhasil menjuarai Game Jam UVERS.
                </p>
              </div>
            </div>
          </ion-card>
          
        </div>
      </div>
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import {
  IonPage, IonHeader, IonToolbar, IonTitle, IonButtons, IonButton,
  IonIcon, IonAvatar, IonContent, IonCard, IonBadge, IonThumbnail,
  IonMenuButton
} from "@ionic/vue";
import CustomHeader from "@/components/CustomHeader.vue";
import { calendarOutline } from "ionicons/icons";
</script>


