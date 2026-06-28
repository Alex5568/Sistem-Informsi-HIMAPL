<template>
  <ion-page>
    <CustomHeader title="HIMAPL" />

    <ion-content class="app-background">
      <div class="ion-padding">
        
        <div class="urgent-card" v-if="upcomingEvent && !isLoading">
          <div class="urgent-header">
            <ion-badge class="urgent-badge">Upcoming</ion-badge>
            <div class="urgent-date">
              <ion-icon :icon="calendarOutline"></ion-icon>
              <span>{{ upcomingEvent.start_date ? new Date(upcomingEvent.start_date).toLocaleDateString('id-ID', { year: 'numeric', month: 'short', day: 'numeric' }).toUpperCase() : 'TBD' }}</span>
            </div>
          </div>
          
          <h2 class="urgent-title">
            {{ upcomingEvent.nama_event }}
          </h2>
          <p class="urgent-subtitle">
            {{ upcomingEvent.deskripsi }}
          </p>

          <div class="urgent-footer">
            <div class="urgent-time">
              <span class="time-label">TIME & LOCATION</span>
              <span class="time-value">
                {{ upcomingEvent.start_date ? new Date(upcomingEvent.start_date).toLocaleTimeString('id-ID', {hour: '2-digit', minute:'2-digit'}) : 'TBD' }} WIB • {{ upcomingEvent.location || 'TBA' }}
              </span>
            </div>
            <ion-button class="register-btn" fill="solid" shape="round">
              Daftar<br />Sekarang
            </ion-button>
          </div>
        </div>
        <div v-else-if="isLoading" class="urgent-card" style="padding: 24px; text-align: center;">
          Loading Event...
        </div>

        <div class="news-section">
          <div class="news-header">
            <h3>News</h3>
            <ion-button fill="clear" class="see-all-btn">SEE ALL</ion-button>
          </div>

          <div v-if="isLoading" style="text-align: center; padding: 20px;">
            Loading news...
          </div>
          <div v-else>
            <ion-card class="news-card" v-for="(news, index) in newsList" :key="index">
              <div class="news-card-content">
                <ion-thumbnail class="news-thumbnail">
                  <img v-if="news.image_url" :src="news.image_url" alt="News Image" />
                </ion-thumbnail>
                <div class="news-info">
                  <div class="news-meta">
                    <ion-badge :class="getBadgeClass(news.category)">
                      {{ news.category || 'NEWS' }}
                    </ion-badge>
                    <span class="news-time">{{ new Date(news.created_at).toLocaleDateString('id-ID', { month: 'short', day: 'numeric' }) }}</span>
                  </div>
                  <h4 class="news-title">{{ news.title }}</h4>
                  <p class="news-desc">
                    {{ news.content }}
                  </p>
                </div>
              </div>
            </ion-card>
            
            <div v-if="newsList.length === 0" style="text-align: center; color: gray;">
              Tidak ada berita terbaru.
            </div>
          </div>
          
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
import { ref, onMounted } from "vue";
import { supabase } from "../supabase";

const upcomingEvent = ref<any>(null);
const newsList = ref<any[]>([]);
const isLoading = ref(true);

const fetchDashboardData = async () => {
    isLoading.value = true;
    try {
        // Fetch 1 Upcoming Event (Terdekat)
        const { data: eventData, error: eventError } = await supabase
            .from('events')
            .select('*')
            .eq('status', 'UPCOMING')
            .order('start_date', { ascending: true })
            .limit(1)
            .single();
            
        if (!eventError && eventData) {
            upcomingEvent.value = eventData;
        }

        // Fetch News (Mengurutkan dari yang terbaru)
        const { data: newsData, error: newsError } = await supabase
            .from('news')
            .select('title, content, image_url, created_at, category')
            .order('created_at', { ascending: false });

        if (!newsError && newsData) {
            newsList.value = newsData;
        }

    } catch (e) {
        console.error("Error fetching dashboard data:", e);
    } finally {
        isLoading.value = false;
    }
};

onMounted(() => {
    fetchDashboardData();
});

const getBadgeClass = (category: string) => {
  switch (category) {
    case 'ACHIEVEMENT':
      return 'badge-achievement';
    case 'GENERAL':
      return 'badge-announcement';
    case 'ANNOUNCEMENT':
    default:
      return 'badge-announcement';
  }
};
</script>