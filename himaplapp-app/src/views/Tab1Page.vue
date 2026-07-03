<template>
  <ion-page>
    <CustomHeader title="HIMAPL" />

    <ion-content class="app-background">
      <div class="ion-padding">
        
        <div class="urgent-card" v-if="!isLoading">
          <template v-if="upcomingEvent">
            <div class="urgent-header">
              <div style="display: flex; gap: 8px; align-items: center;">
                <ion-badge class="urgent-badge">Upcoming</ion-badge>
                <ion-badge v-if="additionalEventsCount > 0" class="additional-badge">+{{ additionalEventsCount }} Events</ion-badge>
              </div>
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
              <!-- Optionally hide register button since they are already registered -->
              <!-- Or change it to 'View Details' -->
              <ion-button 
                class="register-btn" 
                fill="solid" 
                shape="round"
                @click="router.push(`/event/${upcomingEvent.id}`)"
              >
                View<br />Details
              </ion-button>
            </div>
          </template>
          
          <template v-else>
            <div style="text-align: center; color: white; padding: 24px 0;">
              <h2 class="urgent-title" style="margin-bottom: 8px;">No upcoming events registered</h2>
              <p class="urgent-subtitle" style="margin-bottom: 0;">Explore and register for available events in the Projects tab.</p>
            </div>
          </template>
        </div>
        <div v-else class="urgent-card" style="padding: 40px; text-align: center; color: white;">
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
            <ion-card class="news-card" v-for="(news, index) in newsList.slice(0, 7)" :key="news.id || index" button @click="router.push('/news/' + news.id)">
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
              No recent news.
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
import { ref } from "vue";
import { onIonViewWillEnter } from "@ionic/vue";
import { useRouter } from "vue-router";
import { supabase } from "../supabase";

const router = useRouter();
const upcomingEvent = ref<any>(null);
const newsList = ref<any[]>([]);
const isLoading = ref(true);
const additionalEventsCount = ref(0);

const fetchDashboardData = async () => {
    isLoading.value = true;
    try {
        const { data: { user } } = await supabase.auth.getUser();
        if (user) {
            const { data: participations, error: pError } = await supabase
                .from('event_participants')
                .select('event_id')
                .eq('user_id', user.id)
                .neq('status', 'CANCELLED');

            if (!pError && participations && participations.length > 0) {
                const eventIds = participations.map(p => p.event_id);
                const { data: eventsData, error: eError } = await supabase
                    .from('events')
                    .select('*')
                    .in('id', eventIds);

                if (!eError && eventsData) {
                    const now = new Date();
                    // Filter events that haven't ended yet
                    const futureEvents = eventsData.filter(e => {
                        const eventDateStr = e.end_date || e.start_date;
                        if (!eventDateStr) return false;
                        return new Date(eventDateStr) >= now;
                    });
                    
                    // Sort by start_date ascending (closest first)
                    futureEvents.sort((a, b) => {
                        const dateA = a.start_date ? new Date(a.start_date).getTime() : 0;
                        const dateB = b.start_date ? new Date(b.start_date).getTime() : 0;
                        return dateA - dateB;
                    });

                    if (futureEvents.length > 0) {
                        upcomingEvent.value = futureEvents[0];
                        additionalEventsCount.value = futureEvents.length - 1;
                    } else {
                        upcomingEvent.value = null;
                        additionalEventsCount.value = 0;
                    }
                }
            } else {
                upcomingEvent.value = null;
                additionalEventsCount.value = 0;
            }
        }

        // Fetch News (Mengurutkan dari yang terbaru)
        const { data: newsData, error: newsError } = await supabase
            .from('news')
            .select('id, title, content, image_url, created_at, category')
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

onIonViewWillEnter(() => {
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