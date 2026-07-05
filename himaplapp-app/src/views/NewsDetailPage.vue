<template>
  <ion-page>
    <ion-header class="ion-no-border custom-header-solid">
      <ion-toolbar>
        <ion-buttons slot="start">
          <ion-back-button default-href="/tabs/home" class="menu-btn"></ion-back-button>
        </ion-buttons>
        <ion-title class="header-title">News Detail</ion-title>
      </ion-toolbar>
    </ion-header>

    <ion-content :fullscreen="true" class="app-background">
      <div v-if="isLoading" class="loading-state" style="text-align: center; margin-top: 50px; color: #424750;">
        Loading news...
      </div>
      
      <div v-else-if="news" class="event-detail-container">
        <!-- Hero Section -->
        <div class="hero-section">
          <img :src="news.image_url || 'https://ionicframework.com/docs/img/demos/card-media.png'" alt="News Image" class="hero-image"/>
          <div class="hero-overlay">
            <ion-badge class="status-badge" :class="getBadgeClass(news.category)">{{ news.category || 'NEWS' }}</ion-badge>
            <h1 class="event-title">{{ news.title }}</h1>
          </div>
        </div>

        <!-- Details Section -->
        <div class="details-section">
          <ion-card class="detail-card">
            <ion-card-content>
              <div class="info-row">
                <ion-icon :icon="calendarOutline" class="info-icon"></ion-icon>
                <div class="info-text">
                  <strong>Published Date</strong>
                  <p>{{ formatDate(news.created_at) }}</p>
                </div>
              </div>

              <div class="info-row" style="margin-top: 16px;">
                <ion-icon :icon="personOutline" class="info-icon"></ion-icon>
                <div class="info-text">
                  <strong>Published By</strong>
                  <p>{{ news.users?.nama || 'Admin' }}</p>
                </div>
              </div>

              <div class="description-section" style="margin-top: 24px;">
                <p class="news-content-text">{{ news.content }}</p>
              </div>
            </ion-card-content>
          </ion-card>
        </div>
      </div>
      
      <div v-else class="loading-state" style="text-align: center; margin-top: 50px; color: #424750;">
        News not found.
      </div>
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { 
  IonPage, IonHeader, IonToolbar, IonTitle, IonButtons, IonBackButton, 
  IonContent, IonCard, IonCardContent, IonBadge, IonIcon
} from '@ionic/vue';
import { calendarOutline, personOutline } from 'ionicons/icons';
import { ref, onMounted } from 'vue';
import { useRoute } from 'vue-router';
import { supabase } from '../supabase';

const route = useRoute();
const news = ref<any>(null);
const isLoading = ref(true);

const fetchNewsDetail = async () => {
  const rawId = route.params.id;
  const newsId = Array.isArray(rawId) ? rawId[0] : rawId;
  if (!newsId) return;

  try {
    const { data, error } = await supabase
      .from('news')
      .select('*, users(nama)')
      .eq('id', newsId)
      .single();

    if (error) throw error;
    news.value = data;
  } catch (error) {
    console.error('Error fetching news details:', error);
  } finally {
    isLoading.value = false;
  }
};

onMounted(() => {
  fetchNewsDetail();
});

const formatDate = (dateString: string) => {
  if (!dateString) return '';
  const date = new Date(dateString);
  return date.toLocaleDateString('id-ID', { 
    weekday: 'long', 
    year: 'numeric', 
    month: 'long', 
    day: 'numeric' 
  });
};

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

<style scoped>
.loading-state {
  font-family: "Inter", sans-serif;
  font-size: 16px;
}

.event-detail-container {
  display: flex;
  flex-direction: column;
}

.hero-section {
  position: relative;
  width: 100%;
  height: 280px;
  background-color: #dbe8fe;
}

.hero-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.hero-overlay {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  background: linear-gradient(to top, rgba(0,0,0,0.8) 0%, rgba(0,0,0,0) 100%);
  padding: 24px;
  display: flex;
  flex-direction: column;
  justify-content: flex-end;
  height: 100%;
}

.status-badge {
  align-self: flex-start;
  margin-bottom: 8px;
  font-size: 12px;
  padding: 6px 12px;
  border-radius: 6px;
  letter-spacing: 0.5px;
}

.event-title {
  color: white;
  font-family: "Manrope", sans-serif;
  font-weight: 800;
  font-size: 24px;
  line-height: 1.3;
  margin: 0;
}

.details-section {
  margin-top: -20px;
  padding: 0 16px 32px 16px;
  position: relative;
  z-index: 10;
}

.detail-card {
  margin: 0;
  border-radius: 20px;
  background: white;
  box-shadow: 0 12px 30px rgba(0, 0, 0, 0.05);
}

.info-row {
  display: flex;
  align-items: flex-start;
  gap: 16px;
}

.info-icon {
  font-size: 24px;
  color: #36629f;
  margin-top: 2px;
}

.info-text strong {
  display: block;
  font-size: 14px;
  color: #1e293b;
  margin-bottom: 4px;
  font-family: "Inter", sans-serif;
}

.info-text p {
  margin: 0;
  font-size: 14px;
  color: #475569;
  line-height: 1.5;
}

.description-section h3 {
  font-family: "Manrope", sans-serif;
  font-weight: 700;
  font-size: 18px;
  color: #184a85;
  margin: 0 0 12px 0;
}

.news-content-text {
  font-size: 14px;
  color: #334155;
  line-height: 1.7;
  margin: 0;
  white-space: pre-wrap; /* To preserve line breaks */
}

/* Badge colors reused from global.css */
.badge-announcement {
  --background: #a5c8fe;
  --color: #2f5482;
}

.badge-achievement {
  --background: #ffddb3;
  --color: #624000;
}
</style>
