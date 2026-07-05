<template>
  <ion-page>
    <ion-header class="ion-no-border custom-header-solid">
      <ion-toolbar>
        <ion-buttons slot="start">
          <ion-back-button default-href="/tabs/notifications" class="menu-btn"></ion-back-button>
        </ion-buttons>
        <ion-title class="header-title">Notification Detail</ion-title>
      </ion-toolbar>
    </ion-header>

    <ion-content :fullscreen="true" class="app-background">
      <div v-if="isLoading" class="loading-state" style="text-align: center; margin-top: 50px; color: #424750;">
        Loading notification...
      </div>
      
      <div v-else-if="notification" class="event-detail-container">
        <!-- Hero Section -->
        <div class="hero-section">
          <!-- We use a subtle pattern or simple gradient since notifications rarely have images -->
          <div class="hero-image placeholder-bg"></div>
          <div class="hero-overlay">
            <ion-badge class="status-badge badge-blue">NOTIFICATION</ion-badge>
            <h1 class="event-title">{{ notification.judul }}</h1>
          </div>
        </div>

        <!-- Details Section -->
        <div class="details-section">
          <ion-card class="detail-card">
            <ion-card-content>
              <div class="info-row">
                <ion-icon :icon="timeOutline" class="info-icon"></ion-icon>
                <div class="info-text">
                  <strong>Received On</strong>
                  <p>{{ formatDate(notification.created_at) }}</p>
                </div>
              </div>

              <div class="description-section" style="margin-top: 24px;">
                <p class="news-content-text">{{ notification.pesan }}</p>
              </div>
            </ion-card-content>
          </ion-card>
        </div>
      </div>
      
      <div v-else class="loading-state" style="text-align: center; margin-top: 50px; color: #424750;">
        Notification not found.
      </div>
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { 
  IonPage, IonHeader, IonToolbar, IonTitle, IonButtons, IonBackButton, 
  IonContent, IonCard, IonCardContent, IonBadge, IonIcon
} from '@ionic/vue';
import { timeOutline } from 'ionicons/icons';
import { ref, onMounted } from 'vue';
import { useRoute } from 'vue-router';
import { supabase } from '../supabase';

const route = useRoute();
const notification = ref<any>(null);
const isLoading = ref(true);

const fetchNotificationDetail = async () => {
  const rawId = route.params.id;
  const notifId = Array.isArray(rawId) ? rawId[0] : rawId;
  if (!notifId) return;

  const numericId = parseInt(notifId, 10);
  if (isNaN(numericId)) return;

  try {
    const { data, error } = await supabase
      .from('notifikasi')
      .select('*')
      .eq('id', numericId)
      .single();

    if (error) throw error;
    notification.value = data;
    
    // Handle reading status via penerima_notifikasi
    if (data) {
      const { data: { user } } = await supabase.auth.getUser();
      if (user) {
        const { error: updateError } = await supabase
          .from('penerima_notifikasi')
          .update({ is_read: true })
          .match({ notif_id: numericId, user_id: user.id });
          
        if (updateError) {
          console.error('Failed to update is_read status:', updateError);
        }
      }
    }
  } catch (error) {
    console.error('Error fetching notification details:', error);
  } finally {
    isLoading.value = false;
  }
};

onMounted(() => {
  fetchNotificationDetail();
});

const formatDate = (dateString: string) => {
  if (!dateString) return '';
  const date = new Date(dateString);
  return date.toLocaleDateString('id-ID', { 
    weekday: 'long', 
    year: 'numeric', 
    month: 'long', 
    day: 'numeric',
    hour: '2-digit',
    minute: '2-digit'
  });
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
  height: 240px;
  background-color: #dbe8fe;
}

.placeholder-bg {
  background: linear-gradient(135deg, #2b5a9b 0%, #184a85 100%);
  width: 100%;
  height: 100%;
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
.badge-blue {
  --background: #a5c8fe;
  --color: #2f5482;
}
</style>
