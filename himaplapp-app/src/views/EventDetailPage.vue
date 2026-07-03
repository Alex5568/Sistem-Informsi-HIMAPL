<template>
  <ion-page>
    <ion-header class="ion-no-border custom-header-solid">
      <ion-toolbar>
        <ion-buttons slot="start">
          <ion-back-button default-href="/tabs/projects" class="menu-btn"></ion-back-button>
        </ion-buttons>
        <ion-title class="header-title">Event Detail</ion-title>
      </ion-toolbar>
    </ion-header>

    <ion-content :fullscreen="true" class="app-background">
      <div v-if="isLoading" class="loading-state" style="text-align: center; margin-top: 50px; color: white;">
        Loading...
      </div>
      
      <div v-else-if="event" class="event-detail-container">
        <!-- Hero Section -->
        <div class="hero-section">
          <!-- Placeholder image or event specific image if you have one in the future -->
          <img src="https://ionicframework.com/docs/img/demos/card-media.png" alt="Event Hero Image" class="hero-image"/>
          <div class="hero-overlay">
            <ion-badge class="status-badge" :class="getBadgeClass(computedStatus)">{{ computedStatus }}</ion-badge>
            <h1 class="event-title">{{ event.nama_event }}</h1>
          </div>
        </div>

        <!-- Details Section -->
        <div class="details-section">
          <ion-card class="detail-card">
            <ion-card-content>
              <div class="info-row">
                <ion-icon :icon="calendarOutline" class="info-icon"></ion-icon>
                <div class="info-text">
                  <strong>Date & Time</strong>
                  <p>{{ formatDate(event.start_date) }} • {{ formatTime(event.start_date) }}</p>
                </div>
              </div>
              
              <div class="info-row" style="margin-top: 16px;">
                <ion-icon :icon="locationOutline" class="info-icon"></ion-icon>
                <div class="info-text">
                  <strong>Location</strong>
                  <p>{{ event.location || 'TBA' }}</p>
                </div>
              </div>
              
              <div class="info-row" style="margin-top: 16px;" v-if="event.kuota">
                <ion-icon :icon="peopleOutline" class="info-icon"></ion-icon>
                <div class="info-text">
                  <strong>Capacity</strong>
                  <p>{{ participantsCount }} / {{ event.kuota }} Registered</p>
                </div>
              </div>

              <div class="description-section" style="margin-top: 24px;">
                <h3>About This Event</h3>
                <p class="event-desc">{{ event.deskripsi || 'No description provided.' }}</p>
              </div>
              
              <div class="tags-section" style="margin-top: 24px;" v-if="event.kategori && event.kategori.length">
                <h3>Tags</h3>
                <ion-badge class="badge-blue" v-for="cat in event.kategori" :key="cat" style="margin-right: 8px;">
                  {{ cat }}
                </ion-badge>
              </div>
            </ion-card-content>
          </ion-card>
        </div>
      </div>
      
      <div v-else class="loading-state" style="text-align: center; margin-top: 50px; color: white;">
        Event not found.
      </div>
    </ion-content>

    <!-- Footer with Action Button -->
    <ion-footer class="ion-no-border custom-footer" v-if="event && !isLoading && !isPastEvent">
      <ion-toolbar class="footer-toolbar">
        <ion-button 
          v-if="!isRegistered" 
          expand="block" 
          class="action-button primary-btn" 
          shape="round"
          @click="registerEvent"
          :disabled="isProcessing || (event.kuota && participantsCount >= event.kuota)"
        >
          {{ isProcessing ? 'Processing...' : (event.kuota && participantsCount >= event.kuota ? 'Event Full' : 'Register Now') }}
        </ion-button>
        
        <ion-button 
          v-else 
          expand="block" 
          class="action-button danger-btn" 
          shape="round"
          fill="outline"
          @click="cancelRegistration"
          :disabled="isProcessing"
        >
          {{ isProcessing ? 'Processing...' : 'Cancel Registration' }}
        </ion-button>
      </ion-toolbar>
    </ion-footer>
  </ion-page>
</template>

<script setup lang="ts">
import { 
  IonPage, IonHeader, IonToolbar, IonButtons, IonBackButton, IonTitle, 
  IonContent, IonIcon, IonBadge, IonFooter, IonButton, toastController,
  IonCard, IonCardContent 
} from '@ionic/vue';
import { calendarOutline, locationOutline, peopleOutline } from 'ionicons/icons';
import { ref, onMounted, computed } from 'vue';
import { useRoute } from 'vue-router';
import { supabase } from '../supabase';

const route = useRoute();
const eventId = Number(Array.isArray(route.params.id) ? route.params.id[0] : route.params.id);

const event = ref<any>(null);
const isLoading = ref(true);
const isProcessing = ref(false);
const isRegistered = ref(false);
const participantsCount = ref(0);
const currentUserId = ref<string | null>(null);

const fetchEventData = async () => {
  isLoading.value = true;
  try {
    const { data: { user } } = await supabase.auth.getUser();
    if (user) currentUserId.value = user.id;

    // Fetch Event Details
    const { data: eventData, error: eventError } = await supabase
      .from('events')
      .select('*')
      .eq('id', eventId)
      .single();
      
    if (eventError) throw eventError;
    event.value = eventData;

    // Fetch Registration count
    const { count, error: countError } = await supabase
      .from('event_participants')
      .select('*', { count: 'exact', head: true })
      .eq('event_id', eventId)
      .neq('status', 'CANCELLED');
      
    if (!countError) {
      participantsCount.value = count || 0;
    }

    // Check if user is registered
    if (currentUserId.value) {
      const { data: participationData, error: pError } = await supabase
        .from('event_participants')
        .select('status')
        .eq('event_id', eventId)
        .eq('user_id', currentUserId.value)
        .maybeSingle();
        
      if (!pError && participationData && participationData.status !== 'CANCELLED') {
        isRegistered.value = true;
      } else {
        isRegistered.value = false;
      }
    }
    
  } catch (err) {
    console.error("Error fetching event:", err);
    showToast("Failed to load event details.", "danger");
  } finally {
    isLoading.value = false;
  }
};

onMounted(() => {
  fetchEventData();
});

const isPastEvent = computed(() => {
  if (!event.value) return false;
  const eventDate = event.value.end_date ? new Date(event.value.end_date) : new Date(event.value.start_date);
  return eventDate < new Date();
});

const computedStatus = computed(() => {
  if (isPastEvent.value) return 'COMPLETED';
  if (isRegistered.value) return 'UPCOMING';
  return 'AVAILABLE';
});

const registerEvent = async () => {
  if (!currentUserId.value) return;
  isProcessing.value = true;
  
  try {
    // Check if there's a cancelled record to update, otherwise insert
    const { data: existingData } = await supabase
      .from('event_participants')
      .select('id')
      .eq('event_id', eventId)
      .eq('user_id', currentUserId.value)
      .maybeSingle();

    let error;
    if (existingData) {
      const res = await supabase
        .from('event_participants')
        .update({ status: 'REGISTERED' })
        .eq('id', existingData.id);
      error = res.error;
    } else {
      const res = await supabase
        .from('event_participants')
        .insert([{ 
          event_id: eventId, 
          user_id: currentUserId.value,
          status: 'REGISTERED' 
        }]);
      error = res.error;
    }

    if (error) {
       // Check for custom exception message if triggered by database limit
       if (error.message && error.message.includes('kuota')) {
           throw new Error(error.message);
       }
       throw error;
    }

    isRegistered.value = true;
    participantsCount.value += 1;
    showToast("Successfully registered for the event!", "success");
    
  } catch (err: any) {
    console.error("Registration error:", err);
    showToast(err.message || "Failed to register.", "danger");
  } finally {
    isProcessing.value = false;
  }
};

const cancelRegistration = async () => {
  if (!currentUserId.value) return;
  isProcessing.value = true;
  
  try {
    const { error } = await supabase
      .from('event_participants')
      .update({ status: 'CANCELLED' })
      .eq('event_id', eventId)
      .eq('user_id', currentUserId.value);

    if (error) throw error;

    isRegistered.value = false;
    participantsCount.value = Math.max(0, participantsCount.value - 1);
    showToast("Registration cancelled.", "warning");
    
  } catch (err) {
    console.error("Cancellation error:", err);
    showToast("Failed to cancel registration.", "danger");
  } finally {
    isProcessing.value = false;
  }
};

const showToast = async (message: string, color: string) => {
  const toast = await toastController.create({
    message,
    duration: 3000,
    color,
    position: 'bottom'
  });
  await toast.present();
};

const getBadgeClass = (status: string) => {
  if (status === 'COMPLETED') return 'badge-completed';
  if (status === 'UPCOMING') return 'badge-upcoming';
  return 'badge-available';
};

const formatDate = (dateStr: string) => {
  if (!dateStr) return 'TBD';
  const date = new Date(dateStr);
  return date.toLocaleDateString('en-US', { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' });
};

const formatTime = (dateStr: string) => {
  if (!dateStr) return 'TBD';
  const date = new Date(dateStr);
  return date.toLocaleTimeString('en-US', { hour: '2-digit', minute: '2-digit' }) + ' WIB';
};
</script>

<style scoped>
.custom-title {
  color: white;
  font-weight: 600;
  font-family: 'Inter', sans-serif;
}
.hero-section {
  position: relative;
  width: 100%;
  height: 250px;
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
  width: 100%;
  padding: 24px 16px;
  background: linear-gradient(to top, rgba(11, 17, 32, 1) 0%, rgba(11, 17, 32, 0) 100%);
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  gap: 8px;
}
.event-title {
  color: white;
  font-size: 24px;
  font-weight: 700;
  margin: 0;
  line-height: 1.2;
}
.status-badge {
  padding: 6px 12px;
  border-radius: 8px;
  font-size: 12px;
  font-weight: 600;
  letter-spacing: 0.5px;
}
.badge-available { background: rgba(59, 130, 246, 0.2); color: #60a5fa; }
.badge-upcoming { background: rgba(16, 185, 129, 0.2); color: #34d399; }
.badge-completed { background: rgba(107, 114, 128, 0.2); color: #9ca3af; }

.detail-card {
  margin: 16px;
  border-radius: 16px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
  background: white;
}
.details-section {
  color: #1e293b;
  margin-top: -24px; /* Pull it slightly over the hero image overlay if desired, or keep 0 */
  position: relative;
  z-index: 10;
}
.info-row {
  display: flex;
  align-items: flex-start;
  gap: 16px;
}
.info-icon {
  font-size: 24px;
  color: #2563eb;
  margin-top: 2px;
}
.info-text strong {
  display: block;
  font-size: 14px;
  color: #64748b;
  margin-bottom: 4px;
}
.info-text p {
  margin: 0;
  font-size: 16px;
  font-weight: 500;
  color: #0f172a;
}

.description-section h3, .tags-section h3 {
  font-size: 18px;
  color: #0f172a;
  margin-bottom: 12px;
  font-weight: 700;
}
.event-desc {
  color: #475569;
  font-size: 15px;
  line-height: 1.6;
}

.custom-footer {
  background: #ffffff;
  border-top: 1px solid #e2e8f0;
}
.footer-toolbar {
  --background: #ffffff;
  padding: 12px 16px 24px;
}
.action-button {
  --border-radius: 12px;
  height: 48px;
  font-weight: 600;
  margin: 0;
}
.primary-btn {
  --background: #3b82f6;
  --background-hover: #2563eb;
  --background-activated: #1d4ed8;
}
.danger-btn {
  --border-color: #ef4444;
  --color: #ef4444;
}
</style>
