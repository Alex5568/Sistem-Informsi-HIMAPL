<template>
  <ion-page>
    <ion-header class="ion-no-border custom-header">
      <ion-toolbar color="transparent">
        <ion-buttons slot="start">
          <ion-button class="menu-btn">
            <!-- <ion-icon :icon="menuHamburgerOutline"></ion-icon> -->
            <ion-menu-button></ion-menu-button>
          </ion-button>
        </ion-buttons>
        <ion-title class="header-title">HIMAPL</ion-title>
        <ion-avatar slot="end" class="header-avatar">
          <!-- <img alt="Profile" :src="image1" /> -->
        </ion-avatar>
      </ion-toolbar>
    </ion-header>

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

    <!-- <ion-footer class="ion-no-border">
      <ion-tab-bar slot="bottom" class="custom-tab-bar">
        <ion-tab-button tab="home" class="active-tab">
          <ion-icon :icon="home"></ion-icon>
        </ion-tab-button>
        <ion-tab-button tab="analytics">
          <ion-icon :icon="barChartOutline"></ion-icon>
        </ion-tab-button>
        <ion-tab-button tab="notifications">
          <ion-icon :icon="notificationsOutline"></ion-icon>
        </ion-tab-button>
        <ion-tab-button tab="profile">
          <ion-icon :icon="personOutline"></ion-icon>
        </ion-tab-button>
      </ion-tab-bar>
    </ion-footer> -->
  </ion-page>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import {
  IonPage, IonHeader, IonToolbar, IonTitle, IonButtons, IonButton,
  IonIcon, IonAvatar, IonContent, IonCard, IonBadge, IonThumbnail,
  IonFooter, IonTabBar, IonTabButton
} from "@ionic/vue";
import {
//   menuHamburgerOutline, 
  calendarOutline, home, barChartOutline,
  notificationsOutline, personOutline
} from "ionicons/icons";

// Hanya mengimpor gambar asli
// import image from "./image.png";
// import image1 from "./image-1.png";
// import image2 from "./image-2.png";

export default defineComponent({
  name: "IphoneHome",
  components: {
    IonPage, IonHeader, IonToolbar, IonTitle, IonButtons, IonButton,
    IonIcon, IonAvatar, IonContent, IonCard, IonBadge, IonThumbnail,
    IonFooter, IonTabBar, IonTabButton
  },
  setup() {
    return {
      // Icons yang digunakan
    //   menuHamburgerOutline, 
      calendarOutline, home, barChartOutline,
      notificationsOutline, personOutline,
      // Images yang digunakan
    //   image, image1, image2
    };
  },
});
</script>
