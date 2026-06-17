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

    <ion-footer class="ion-no-border">
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
    </ion-footer>
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

<style scoped>
/* App Background */
ion-content.app-background {
  --background: #f7f9fbcc;
}

/* Header */
.custom-header {
  background: rgba(255, 255, 255, 0.8);
  backdrop-filter: blur(12px);
}
.header-title {
  color: #184a85;
  font-family: "Manrope", sans-serif;
  font-weight: 700;
  font-size: 20px;
}
.menu-btn {
  color: #184a85;
}
.header-avatar {
  width: 40px;
  height: 40px;
  border: 2px solid rgba(54, 98, 159, 0.2);
  margin-right: 16px;
}

/* Urgent Card Section */
.urgent-card {
  background: linear-gradient(149deg, #184a85 0%, #36629f 100%);
  border-radius: 22px;
  padding: 24px;
  margin-top: 16px;
  box-shadow: 0px 25px 50px -12px rgba(24, 74, 133, 0.2);
  position: relative;
  overflow: hidden;
}
.urgent-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;
}
.urgent-badge {
  background: rgba(255, 255, 255, 0.2);
  backdrop-filter: blur(6px);
  color: #fff;
  font-size: 10px;
  letter-spacing: 1px;
  padding: 6px 12px;
  border-radius: 20px;
  border: 1px solid rgba(255,255,255,0.3);
}
.urgent-date {
  color: #cddeff;
  font-weight: 700;
  font-size: 12px;
  display: flex;
  align-items: center;
  gap: 4px;
}
.urgent-title {
  color: #ffffff;
  font-family: "Manrope", sans-serif;
  font-weight: 700;
  font-size: 24px;
  line-height: 32px;
  margin: 0 0 8px 0;
}
.urgent-subtitle {
  color: #cddeff;
  font-size: 14px;
  line-height: 22px;
  margin: 0 0 24px 0;
}
.urgent-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.urgent-time {
  display: flex;
  flex-direction: column;
}
.time-label {
  color: rgba(255, 255, 255, 0.6);
  font-size: 10px;
  font-weight: 700;
  letter-spacing: 1px;
}
.time-value {
  color: #ffffff;
  font-size: 14px;
  font-weight: 500;
  line-height: 20px;
}
.register-btn {
  --background: #ffffff;
  --color: #184a85;
  --border-radius: 12px;
  --box-shadow: 0px 8px 10px -6px rgba(0,0,0,0.1);
  font-weight: 700;
  text-transform: capitalize;
  height: 48px;
}

/* Latest News Section */
.news-section {
  margin-top: 32px;
}
.news-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 16px;
}
.news-header h3 {
  color: #184a85;
  font-family: "Manrope", sans-serif;
  font-weight: 700;
  font-size: 20px;
  margin: 0;
}
.see-all-btn {
  --color: #36629f;
  font-weight: 700;
  font-size: 12px;
  letter-spacing: 0.6px;
}

/* News Cards */
.news-card {
  background: #ffffff;
  border-radius: 24px;
  box-shadow: 0px 12px 24px -12px rgba(0, 0, 0, 0.05);
  margin: 0 0 16px 0;
}
.news-card-content {
  display: flex;
  padding: 16px;
  gap: 16px;
}
.news-thumbnail {
  --size: 96px;
  --border-radius: 16px;
}
.news-info {
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}
.news-meta {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 4px;
}
.badge-announcement {
  --background: #a5c8fe;
  --color: #2f5482;
  font-size: 9px;
  padding: 4px 8px;
}
.badge-achievement {
  --background: #ffddb3;
  --color: #624000;
  font-size: 9px;
  padding: 4px 8px;
}
.news-time {
  color: #424750;
  font-size: 10px;
  font-weight: 500;
}
.news-title {
  color: #191c1e;
  font-weight: 700;
  font-size: 14px;
  margin: 4px 0;
  line-height: 1.4;
}
.news-desc {
  color: #424750;
  font-size: 12px;
  line-height: 18px;
  margin: 0;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

/* Tab Bar Override */
.custom-tab-bar {
  --background: #ffffff;
  --border: none;
  box-shadow: 0px -4px 20px rgba(0, 0, 0, 0.05);
  height: 80px;
  padding-bottom: env(safe-area-inset-bottom);
}
.active-tab {
  --color-selected: #184a85;
  background: #eef4ff;
  border-radius: 12px;
  margin: 8px;
}
</style>