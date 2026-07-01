<template>
  <ion-page>
    <CustomHeader title="HIMAPL" />

    <ion-content :fullscreen="true" class="app-background">
      <div class="ion-padding">

        <ion-segment v-model="selectedTab" class="custom-segment" mode="ios">
          <ion-segment-button value="tersedia">
            <ion-label>Available</ion-label>
          </ion-segment-button>
          <ion-segment-button value="berlangsung">
            <ion-label>Upcoming</ion-label>
          </ion-segment-button>
          <ion-segment-button value="riwayat">
            <ion-label>Completed</ion-label>
          </ion-segment-button>
        </ion-segment>

        <div v-if="isLoading" class="empty-state" style="text-align: center; margin-top: 2rem;">
          <p>Memuat kegiatan...</p>
        </div>
        
        <div v-else-if="filteredEvents.length === 0" class="empty-state" style="text-align: center; margin-top: 2rem; color: #718096;">
          <p>Belum ada kegiatan untuk kategori ini.</p>
        </div>

        <div class="card-list" v-else>
          <ion-card class="news-card" v-for="event in filteredEvents" :key="event.id">
            <div class="news-card-content">
              <ion-thumbnail class="news-thumbnail">
                <img src="https://ionicframework.com/docs/img/demos/thumbnail.svg" alt="Thumbnail" />
              </ion-thumbnail>
              <div class="news-info">
                <div class="news-meta">
                  <div class="badge-group" v-if="event.kategori && event.kategori.length > 0">
                    <ion-badge 
                      class="badge-blue" 
                      v-for="(cat, index) in event.kategori.slice(0, 3)" 
                      :key="index"
                    >
                      {{ cat }}
                    </ion-badge>
                    <ion-badge class="badge-blue" v-if="event.kategori.length > 3">...</ion-badge>
                  </div>
                  <span class="news-time" style="margin-left: auto;">{{ formatDate(event.start_date) }}</span>
                </div>
                <h4 class="news-title">{{ event.nama_event }}</h4>
                <p class="news-desc">
                  {{ event.deskripsi }}
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

import { ref, computed, onMounted } from "vue";
import { supabase } from "../supabase";

const selectedTab = ref("tersedia");
const events = ref<any[]>([]);
const isLoading = ref(true);

const fetchEvents = async () => {
  isLoading.value = true;
  try {
    const { data, error } = await supabase
      .from('events')
      .select('*')
      .order('start_date', { ascending: true });
    
    if (error) throw error;
    events.value = data || [];
  } catch (error) {
    console.error("Error fetching events:", error);
  } finally {
    isLoading.value = false;
  }
};

onMounted(() => {
  fetchEvents();
});

const filteredEvents = computed(() => {
  const statusMap: Record<string, string> = {
    'tersedia': 'AVAILABLE',
    'berlangsung': 'UPCOMING',
    'riwayat': 'COMPLETED'
  };
  const targetStatus = statusMap[selectedTab.value];
  return events.value.filter(e => e.status === targetStatus);
});

const formatDate = (dateStr: string) => {
  if (!dateStr) return '';
  const date = new Date(dateStr);
  const day = String(date.getDate()).padStart(2, '0');
  const month = String(date.getMonth() + 1).padStart(2, '0');
  return `${day}/${month}`;
};
</script>
