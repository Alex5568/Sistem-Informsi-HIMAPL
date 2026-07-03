<template>
  <ion-page>
    <CustomHeader title="Notifications" />

    <ion-content class="app-background">
      <div class="notification-container">
        <h2 class="app-section-title" style="margin-top: 24px;">Recent</h2>
        
        <div v-if="isLoading" class="ion-text-center" style="margin-top: 20px;">
          <ion-spinner></ion-spinner>
        </div>

        <div v-else-if="notifications.length === 0" class="ion-text-center" style="margin-top: 40px; color: #666;">
          <p>No notifications yet.</p>
        </div>

        <div v-else>
          <!-- Notification Cards -->
          <div 
            class="notif-card" 
            :class="{ unread: !isNotificationRead(notif) }"
            v-for="notif in notifications" 
            :key="notif.id"
            @click="openNotification(notif)"
          >
            <div class="notif-icon-box bg-blue">
              <ion-icon :icon="notificationsOutline" class="notif-icon color-blue"></ion-icon>
            </div>
            <div class="notif-content">
              <div class="notif-header">
                <h3 class="notif-title">{{ notif.judul }}</h3>
                <span class="notif-time" :class="{ 'text-blue': !isNotificationRead(notif), 'text-gray': isNotificationRead(notif) }">
                  {{ formatTime(notif.created_at) }}
                </span>
              </div>
              <p class="notif-desc">
                {{ notif.pesan }}
              </p>
            </div>
          </div>
        </div>

        <ion-infinite-scroll @ionInfinite="loadMore">
          <ion-infinite-scroll-content loading-spinner="bubbles" loading-text="Loading more notifications..."></ion-infinite-scroll-content>
        </ion-infinite-scroll>
      </div>
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { IonPage, IonContent, IonIcon, IonSpinner, onIonViewWillEnter, IonInfiniteScroll, IonInfiniteScrollContent } from '@ionic/vue';
import { useRouter } from 'vue-router';
import { notificationsOutline } from 'ionicons/icons';
import CustomHeader from "@/components/CustomHeader.vue";
import { supabase } from "../supabase";

const router = useRouter();
const notifications = ref<any[]>([]);
const isLoading = ref(true);
const page = ref(0);
const pageSize = 8;

const fetchNotifications = async (isFirstLoad = true, event?: any) => {
  if (isFirstLoad) {
    isLoading.value = true;
    page.value = 0;
  }
  
  try {
    const { data: { user } } = await supabase.auth.getUser();
    
    if (user) {
      const from = page.value * pageSize;
      const to = from + pageSize - 1;
      
      const { data, error } = await supabase
        .from('notifikasi')
        .select('*, read_notifications(id)')
        .or(`user_id.eq.${user.id},user_id.is.null`)
        .order('created_at', { ascending: false })
        .range(from, to);
        
      if (error) throw error;
      
      if (isFirstLoad) {
        notifications.value = data || [];
      } else {
        notifications.value = [...notifications.value, ...(data || [])];
      }

      if (event) {
        event.target.complete();
        if (!data || data.length < pageSize) {
          event.target.disabled = true;
        }
      }
    }
  } catch (error) {
    console.error('Failed to fetch notifications:', error);
    if (event) event.target.complete();
  } finally {
    if (isFirstLoad) isLoading.value = false;
  }
};

const loadMore = (event: any) => {
  page.value++;
  fetchNotifications(false, event);
};

const isNotificationRead = (notif: any) => {
  if (notif.user_id !== null) {
    return notif.is_read;
  }
  return notif.read_notifications && notif.read_notifications.length > 0;
};

const openNotification = (notif: any) => {
  if (notif.user_id !== null) {
    notif.is_read = true;
  } else {
    notif.read_notifications = [{ id: -1 }]; // Optimistic update
  }
  router.push('/notification/' + notif.id);
};

const formatTime = (dateString: string | null) => {
  if (!dateString) return '';
  const date = new Date(dateString);
  const now = new Date();
  const diffInMinutes = Math.floor((now.getTime() - date.getTime()) / 60000);
  
  if (diffInMinutes < 1) return 'JUST NOW';
  if (diffInMinutes < 60) return `${diffInMinutes}M AGO`;
  const diffInHours = Math.floor(diffInMinutes / 60);
  if (diffInHours < 24) return `${diffInHours}H AGO`;
  
  // Return date format (e.g., "2 JUL 2026") if older than 24 hours
  return date.toLocaleDateString('en-GB', { day: 'numeric', month: 'short', year: 'numeric' }).toUpperCase();
};

onIonViewWillEnter(() => {
  if (notifications.value.length === 0) {
    fetchNotifications();
  } else {
    // Refresh quietly without resetting page, or just rely on local state
    // We will just fetch silently to update any new notifications in the background
    // but not reset the whole list unless they pull-to-refresh
    const refreshData = async () => {
      try {
        const { data: { user } } = await supabase.auth.getUser();
        if (user) {
          const to = page.value * pageSize + pageSize - 1;
          const { data } = await supabase
            .from('notifikasi')
            .select('*, read_notifications(id)')
            .or(`user_id.eq.${user.id},user_id.is.null`)
            .order('created_at', { ascending: false })
            .range(0, to);
          
          if (data) {
            // Update items while preserving local optimistic state if possible
            // But since RLS might block, let's keep our optimistic state
            notifications.value.forEach(localNotif => {
              const remoteNotif = data.find(n => n.id === localNotif.id);
              if (remoteNotif) {
                // If local says read, keep it read (optimistic)
                if (localNotif.user_id !== null) {
                  if (localNotif.is_read) remoteNotif.is_read = true;
                } else {
                  if (localNotif.read_notifications && localNotif.read_notifications.length > 0) {
                    remoteNotif.read_notifications = [{ id: -1 }];
                  }
                }
              }
            });
            notifications.value = data;
          }
        }
      } catch (e) {}
    };
    refreshData();
  }
});
</script>

<style scoped>
.notification-container {
  padding: 16px;
}

.section-title {
  font-family: "Inter", sans-serif;
  font-size: 14px;
  font-weight: 500;
  color: #424750;
  margin-top: 8px;
  margin-bottom: 16px;
}

.notif-card {
  background: #ffffff;
  border-radius: 16px;
  padding: 16px;
  display: flex;
  gap: 16px;
  margin-bottom: 16px;
  box-shadow: 0px 8px 16px -8px rgba(0, 0, 0, 0.05);
  position: relative;
  overflow: hidden;
}

.notif-card.unread::before {
  content: "";
  position: absolute;
  left: 0;
  top: 0;
  bottom: 0;
  width: 4px;
  background-color: #184a85;
}

.notif-icon-box {
  width: 48px;
  height: 48px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}

.bg-blue {
  background: #dbe8fe;
}

.bg-orange {
  background: #fde2ba;
}

.notif-icon {
  font-size: 24px;
}

.color-blue {
  color: #2b5a9b;
}

.color-orange {
  color: #624000;
}

.notif-content {
  flex: 1;
}

.notif-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 4px;
}

.notif-title {
  font-family: "Manrope", sans-serif;
  font-size: 16px;
  font-weight: 700;
  color: #191c1e;
  margin: 0;
}

.notif-time {
  font-size: 10px;
  font-weight: 700;
  letter-spacing: 0.5px;
}

.text-blue {
  color: #184a85;
}

.text-gray {
  color: #424750;
}

.notif-desc {
  font-family: "Inter", sans-serif;
  font-size: 14px;
  color: #424750;
  line-height: 1.5;
  margin: 0 0 12px 0;
}

.notif-actions {
  display: flex;
  gap: 8px;
}

.notif-actions ion-button {
  margin: 0;
  height: 32px;
  font-family: "Inter", sans-serif;
  font-weight: 600;
  font-size: 12px;
  text-transform: none;
  --border-radius: 8px;
  --box-shadow: none;
}

.btn-primary {
  --background: #184a85;
  --color: #ffffff;
}

.btn-secondary {
  --background: #f4f5f8;
  --color: #424750;
}
</style>
