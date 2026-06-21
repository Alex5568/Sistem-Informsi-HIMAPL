<template>
  <ion-page>
    <ion-header class="ion-no-border custom-header">
      <ion-toolbar color="transparent">
        <ion-buttons slot="start">
          <ion-button class="menu-btn">
            <ion-icon :icon="menuOutline"></ion-icon>
          </ion-button>
        </ion-buttons>
        <ion-title class="header-title">{{ headerLabel }}</ion-title>
        <ion-avatar slot="end" class="header-avatar">
          <!-- <img alt="Profile" :src="image1" /> -->
        </ion-avatar>
      </ion-toolbar>
    </ion-header>

    <ion-content class="app-background">
      <div class="ion-padding">
        
        <ion-segment v-model="selectedTab" class="custom-segment" mode="ios">
          <ion-segment-button value="tersedia">
            <ion-label>Tersedia</ion-label>
          </ion-segment-button>
          <ion-segment-button value="berlangsung">
            <ion-label>Berlangsung</ion-label>
          </ion-segment-button>
          <ion-segment-button value="riwayat">
            <ion-label>Riwayat</ion-label>
          </ion-segment-button>
        </ion-segment>

        <div class="card-list" v-if="selectedTab === 'tersedia'">
          
          <ion-card class="news-card">
            <div class="news-card-content">
              <ion-thumbnail class="news-thumbnail">
                <!-- <img :src="image" alt="Thumbnail" /> -->
              </ion-thumbnail>
              <div class="news-info">
                <div class="news-meta">
                  <div class="badge-group">
                    <ion-badge class="badge-blue">SEMINAR</ion-badge>
                    <ion-badge class="badge-blue">SERTIFIKAT</ion-badge>
                  </div>
                  <span class="news-time">18/04</span>
                </div>
                <h4 class="news-title">Seminar: Advanced UI/UX Design</h4>
                <p class="news-desc">
                  Kembangkan skill desain antarmuka modern bersama praktisi industri.
                </p>
              </div>
            </div>
          </ion-card>

          <ion-card class="news-card">
            <div class="news-card-content">
              <ion-thumbnail class="news-thumbnail">
                <!-- <img :src="image2" alt="Thumbnail" /> -->
              </ion-thumbnail>
              <div class="news-info">
                <div class="news-meta">
                  <div class="badge-group">
                    <ion-badge class="badge-blue">KURSUS</ion-badge>
                    <ion-badge class="badge-blue">SERTIFIKAT</ion-badge>
                  </div>
                  <span class="news-time">Yesterday</span>
                </div>
                <h4 class="news-title">Kursus UNITY Engine Dari Alumi UVERS</h4>
                <p class="news-desc">
                  Kursus UNITY Engine yang dibawakan oleh Yuriko Asinselo
                </p>
              </div>
            </div>
          </ion-card>

        </div>

        <div v-if="selectedTab === 'berlangsung'" class="empty-state">
          <p>Belum ada kegiatan yang berlangsung.</p>
        </div>
        <!-- <div v-if="selectedTab === 'riwayat'" class="empty-state"> -->
        <div v-if="selectedTab === 'riwayat'">

          <ion-card class="news-card">
            <div class="news-card-content">
              <ion-thumbnail class="news-thumbnail">
                <!-- <img :src="image" alt="Thumbnail" /> -->
              </ion-thumbnail>
              <div class="news-info">
                <div class="news-meta">
                  <div class="badge-group">
                    <ion-badge class="badge-blue">SEMINAR</ion-badge>
                    <ion-badge class="badge-blue">SERTIFIKAT</ion-badge>
                  </div>
                  <span class="news-time">18/04</span>
                </div>
                <h4 class="news-title">Seminar: Personal Branding</h4>
                <p class="news-desc">
                  Kembangkan skill personal branding.
                </p>
              </div>
            </div>
          </ion-card>
        </div>

      </div>
    </ion-content>

    <ion-footer class="ion-no-border">
      <ion-tab-bar slot="bottom" class="custom-tab-bar">
        <ion-tab-button tab="home">
          <ion-icon :icon="homeOutline"></ion-icon>
        </ion-tab-button>
        <ion-tab-button tab="projects" class="active-tab">
          <ion-icon :icon="barChart"></ion-icon>
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
import { defineComponent, ref } from "vue";
import {
  IonPage, IonHeader, IonToolbar, IonTitle, IonButtons, IonButton,
  IonIcon, IonAvatar, IonContent, IonSegment, IonSegmentButton, IonLabel,
  IonCard, IonBadge, IonThumbnail, IonFooter, IonTabBar, IonTabButton
} from "@ionic/vue";
import {
  menuOutline, homeOutline, albumsOutline,
  notificationsOutline, personOutline,
  barChart
} from "ionicons/icons";

// Impor gambar asli
// import image from "./image.png";
// import image1 from "./image-1.png";
// import image2 from "./image-2.png";

export default defineComponent({
  name: "IphoneTab",
  components: {
    IonPage, IonHeader, IonToolbar, IonTitle, IonButtons, IonButton,
    IonIcon, IonAvatar, IonContent, IonSegment, IonSegmentButton, IonLabel,
    IonCard, IonBadge, IonThumbnail, IonFooter, IonTabBar, IonTabButton
  },
  props: {
    headerLabel: {
      type: String,
      default: "HIMAPL",
    },
  },
  setup(props) {
    // State untuk Segmented Control (default ke 'tersedia')
    const selectedTab = ref("tersedia");

    return {
      selectedTab,
      headerLabel: props.headerLabel,
      // Ikon
      menuOutline, homeOutline, barChart,
      notificationsOutline, personOutline,
      // Gambar
    //   image, image1, image2
    };
  },
});
</script>

<style scoped>
/* App Background */
ion-content.app-background {
  --background: #f7f9fb;
}

/* Header */
.custom-header {
  background: rgba(255, 255, 255, 0.8);
  backdrop-filter: blur(12px);
}
.header-title {
  color: #184a85;
  font-family: "Inter", sans-serif;
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

/* Segmented Control */
.custom-segment {
  background: #e6e8ea;
  border-radius: 16px;
  padding: 4px;
  margin-top: 8px;
  margin-bottom: 24px;
}
.custom-segment ion-segment-button {
  --color: #424750;
  --color-checked: #ffffff;
  --indicator-color: #36629f;
  font-family: "Inter", sans-serif;
  font-weight: 500;
  font-size: 14px;
  border-radius: 12px;
  text-transform: capitalize;
  min-height: 40px;
}

/* Cards Section */
.card-list {
  display: flex;
  flex-direction: column;
  gap: 16px;
}
.news-card {
  background: #ffffff;
  border-radius: 24px;
  box-shadow: 0px 12px 24px -12px rgba(0, 0, 0, 0.05);
  margin: 0; /* Reset margin bawaan Ionic */
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
  justify-content: flex-start;
  width: 100%;
}
.news-meta {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 8px;
}
.badge-group {
  display: flex;
  gap: 6px;
}
.badge-blue {
  --background: #a5c8fe;
  --color: #2f5482;
  font-size: 9px;
  padding: 4px 8px;
  font-weight: 700;
}
.news-time {
  color: #424750;
  font-size: 10px;
  font-weight: 500;
}
.news-title {
  color: #191c1e;
  font-family: "Manrope", sans-serif;
  font-weight: 700;
  font-size: 14px;
  margin: 0 0 6px 0;
  line-height: 1.4;
}
.news-desc {
  color: #424750;
  font-size: 12px;
  line-height: 18px;
  margin: 0;
}

/* Empty State untuk tab yang belum ada isinya */
.empty-state {
  text-align: center;
  color: #424750;
  margin-top: 40px;
  font-size: 14px;
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