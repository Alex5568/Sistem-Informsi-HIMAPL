<template>
<ion-button fill="clear"> 
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
</ion-button>
</template>

<script setup lang="ts">
import { ref, onMounted } from "vue";
import { supabase } from "../supabase";

const newsList = ref<any[]>([]);
const isLoading = ref(true);

const fetchDashboardData = async () => {
    isLoading.value = true;
    try {
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
      return 'badge-general';
    case 'ANNOUNCEMENT':
    default:
      return 'badge-announcement';
  }
};
</script>