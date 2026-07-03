<template>
  <ion-page>
    <CustomHeader title="Events" />

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
          <p>Loading events...</p>
        </div>
        
        <div v-if="selectedTab === 'riwayat'">
          <div v-if="attendedEvents.length === 0 && missedEvents.length === 0" class="empty-state" style="text-align: center; margin-top: 2rem; color: #718096;">
            <p>No events in this category yet.</p>
          </div>
          <div v-else>
            <div v-for="section in [{ title: 'Attended', list: attendedEvents }, { title: 'Missed', list: missedEvents }]" :key="section.title">
              <div v-if="section.list.length > 0">
                <h3 class="app-section-title" style="margin-top: 24px;">{{ section.title }}</h3>
                <div class="card-list">
                  <ion-card 
                    class="news-card" 
                    v-for="event in section.list" 
                    :key="event.id"
                    button
                    @click="router.push(`/event/${event.id}`)"
                  >
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
            </div>
          </div>
        </div>

        <div v-else>
          <div v-if="filteredEvents.length === 0" class="empty-state" style="text-align: center; margin-top: 2rem; color: #718096;">
            <p>No events in this category yet.</p>
          </div>
          <div class="card-list" v-else>
            <ion-card 
              class="news-card" 
              v-for="event in filteredEvents" 
              :key="event.id"
              button
              @click="router.push(`/event/${event.id}`)"
            >
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

      </div>
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { IonPage, IonContent, IonSegment, IonSegmentButton, IonLabel,
  IonCard, IonBadge, IonThumbnail 
} from '@ionic/vue';
import CustomHeader from "@/components/CustomHeader.vue";

import { ref, computed } from "vue";
import { onIonViewWillEnter } from "@ionic/vue";
import { useRouter } from "vue-router";
import { supabase } from "../supabase";

const router = useRouter();
const selectedTab = ref("tersedia");
const events = ref<any[]>([]);
const userParticipations = ref<any[]>([]);
const isLoading = ref(true);

const fetchEvents = async () => {
  isLoading.value = true;
  try {
    // 1. Dapatkan user yang sedang login
    const { data: { user } } = await supabase.auth.getUser();

    // 2. Ambil data events yang bukan draft/cancelled
    const { data: eventsData, error: eventsError } = await supabase
      .from('events')
      .select('*')
      .in('status', ['PUBLISHED', 'AVAILABLE', 'UPCOMING', 'COMPLETED']) // Mengecualikan DRAFT, CANCELLED, CLOSED
      .order('start_date', { ascending: true });
    
    if (eventsError) throw eventsError;

    // 3. Ambil data partisipasi jika user sudah login
    let participationsData: any[] = [];
    if (user) {
      const { data: pData, error: pError } = await supabase
        .from('event_participants')
        .select('event_id, status')
        .eq('user_id', user.id);
        
      if (!pError && pData) {
        participationsData = pData;
      }
    }
    userParticipations.value = participationsData;

    // 4. Hitung 'computedStatus' untuk setiap event
    const now = new Date();
    
    events.value = (eventsData || []).map((e: any) => {
      const eventDateStr = e.end_date || e.start_date;
      const eventDate = eventDateStr ? new Date(eventDateStr) : null;
      
      let computedStatus = 'AVAILABLE';
      const isRegistered = participationsData.some(p => p.event_id === e.id && p.status !== 'CANCELLED');
      
      // Jika waktu event sudah lewat
      if (eventDate && eventDate < now) {
        computedStatus = 'COMPLETED';
      } else {
        // Cek apakah user mendaftar di event ini (dan tidak batal)
        if (isRegistered) {
          computedStatus = 'UPCOMING';
        } else {
          computedStatus = 'AVAILABLE';
        }
      }
      
      return { ...e, computedStatus, isRegistered };
    });

  } catch (error) {
    console.error("Error fetching events:", error);
  } finally {
    isLoading.value = false;
  }
};

onIonViewWillEnter(() => {
  fetchEvents();
});

const filteredEvents = computed(() => {
  const statusMap: Record<string, string> = {
    'tersedia': 'AVAILABLE',
    'berlangsung': 'UPCOMING',
    'riwayat': 'COMPLETED'
  };
  const targetStatus = statusMap[selectedTab.value];
  return events.value.filter(e => e.computedStatus === targetStatus);
});

const attendedEvents = computed(() => {
  return events.value.filter(e => e.computedStatus === 'COMPLETED' && e.isRegistered);
});

const missedEvents = computed(() => {
  return events.value.filter(e => e.computedStatus === 'COMPLETED' && !e.isRegistered);
});

const formatDate = (dateStr: string) => {
  if (!dateStr) return '';
  const date = new Date(dateStr);
  const day = String(date.getDate()).padStart(2, '0');
  const month = String(date.getMonth() + 1).padStart(2, '0');
  return `${day}/${month}`;
};
</script>
