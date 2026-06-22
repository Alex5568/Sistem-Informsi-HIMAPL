<template>
  <ion-page>
    <CustomHeader title="HIMAPL" />

    <ion-content :fullscreen="true">
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
  </ion-page>
</template>

<script setup lang="ts">
import { IonPage, IonContent, IonSegment, IonSegmentButton, IonLabel,
  IonCard, IonBadge, IonThumbnail 
} from '@ionic/vue';
import CustomHeader from "@/components/CustomHeader.vue";

import { ref } from "vue";

const selectedTab = ref("tersedia");
</script>
