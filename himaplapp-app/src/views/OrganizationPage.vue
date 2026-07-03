<template>
  <ion-page>
    <ion-header class="ion-no-border">
      <ion-toolbar class="custom-toolbar">
        <ion-buttons slot="start">
          <ion-menu-button color="primary"></ion-menu-button>
        </ion-buttons>
        <ion-title>Organizational Structure</ion-title>
      </ion-toolbar>
    </ion-header>

    <ion-content class="ion-padding app-background">
      <div class="page-header">
        <h1>Organizational Structure</h1>
        <p>HIMAPL Core Team & Divisions</p>
      </div>

      <!-- Loading State -->
      <div v-if="isLoading" class="loading-state">
        <ion-spinner name="crescent" color="primary"></ion-spinner>
        <p>Loading structure...</p>
      </div>

      <div v-else class="structure-container">
        
        <!-- Advisors / Dosen -->
        <section v-if="dosens.length > 0" class="org-section">
          <h2 class="section-title">Pembina (Advisors)</h2>
          <div class="card-grid">
            <div v-for="dosen in dosens" :key="dosen.id" class="org-card advisor-card">
              <ion-avatar>
                <img :src="dosen.avatar_url || defaultAvatar" />
              </ion-avatar>
              <h3>{{ dosen.nama }}</h3>
              <p v-if="dosen.nim" class="nim-text">{{ dosen.nim }}</p>
              <ion-badge color="danger">Dosen</ion-badge>
            </div>
          </div>
        </section>

        <!-- Executive / Ketua -->
        <section v-if="ketuaUtama || wakilKetuas.length > 0" class="org-section">
          <h2 class="section-title">Executive Board</h2>
          
          <div v-if="ketuaUtama" class="card-grid single-top">
            <div class="org-card executive-card primary-executive">
              <ion-avatar>
                <img :src="ketuaUtama.avatar_url || defaultAvatar" />
              </ion-avatar>
              <h3>{{ ketuaUtama.nama }}</h3>
              <p v-if="ketuaUtama.nim" class="nim-text">{{ ketuaUtama.nim }}</p>
              <ion-badge color="primary">Ketua Himpunan</ion-badge>
            </div>
          </div>

          <div v-if="wakilKetuas.length > 0" class="card-grid">
            <div v-for="wakil in wakilKetuas" :key="wakil.id" class="org-card executive-card secondary-executive">
              <ion-avatar>
                <img :src="wakil.avatar_url || defaultAvatar" />
              </ion-avatar>
              <h3>{{ wakil.nama }}</h3>
              <p v-if="wakil.nim" class="nim-text">{{ wakil.nim }}</p>
              <ion-badge color="tertiary">Wakil Ketua</ion-badge>
            </div>
          </div>
        </section>

        <!-- Divisions -->
        <section v-if="divisions.length > 0" class="org-section">
          <h2 class="section-title">Divisions</h2>
          
          <div v-for="div in divisions" :key="div.id" class="division-section">
            <h3 class="div-title">{{ div.nama_divisi }}</h3>
            
            <!-- Ketua Divisi -->
            <div v-if="div.ketua" class="card-grid single-top">
              <div class="org-card div-head-card">
                <ion-avatar>
                  <img :src="div.ketua.avatar_url || defaultAvatar" />
                </ion-avatar>
                <h3>{{ div.ketua.nama }}</h3>
                <p v-if="div.ketua.nim" class="nim-text">{{ div.ketua.nim }}</p>
                <ion-badge color="warning">Ketua Divisi</ion-badge>
              </div>
            </div>
            <div v-else class="empty-role">
              <p>Ketua Divisi belum ditugaskan</p>
            </div>

            <!-- Anggota Divisi -->
            <h4 class="anggota-title" v-if="div.anggotas.length > 0">Anggota</h4>
            <div v-if="div.anggotas.length > 0" class="card-grid anggota-grid">
              <div v-for="anggota in div.anggotas" :key="anggota.id" class="org-card anggota-card">
                <ion-avatar>
                  <img :src="anggota.avatar_url || defaultAvatar" />
                </ion-avatar>
                <h3>{{ anggota.nama }}</h3>
                <p v-if="anggota.nim" class="nim-text">{{ anggota.nim }}</p>
                <ion-badge color="medium">Anggota</ion-badge>
              </div>
            </div>
            <div v-else class="empty-role">
              <p>Belum ada anggota</p>
            </div>
          </div>
        </section>

      </div>
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import {
  IonPage,
  IonHeader,
  IonToolbar,
  IonTitle,
  IonContent,
  IonButtons,
  IonMenuButton,
  IonAvatar,
  IonBadge,
  IonSpinner
} from '@ionic/vue';
import { ref, onMounted } from 'vue';
import { supabase } from '../supabase';

const isLoading = ref(true);
const defaultAvatar = 'https://ionicframework.com/docs/img/demos/avatar.svg';

const dosens = ref<any[]>([]);
const ketuaUtama = ref<any>(null);
const wakilKetuas = ref<any[]>([]);
const divisions = ref<any[]>([]);

const fetchData = async () => {
  isLoading.value = true;
  try {
    const [usersRes, divRes] = await Promise.all([
      supabase.from('users').select('*').order('created_at', { ascending: true }),
      supabase.from('divisi').select('*').order('nama_divisi', { ascending: true })
    ]);

    if (usersRes.data && divRes.data) {
      const allUsers = usersRes.data;
      const allDivs = divRes.data;

      // Filter Dosen
      dosens.value = allUsers.filter(u => u.role === 'Dosen');

      // Filter Ketua / Wakil Ketua
      const allKetuas = allUsers.filter(u => u.role === 'Ketua');
      if (allKetuas.length > 0) {
        ketuaUtama.value = allKetuas[0];
        wakilKetuas.value = allKetuas.slice(1);
      }

      // Filter Divisi
      divisions.value = allDivs.map(div => {
        const divKetua = allUsers.find(u => u.role === 'Ketua Divisi' && u.divisi_id === div.id);
        const divAnggotas = allUsers.filter(u => u.role === 'Anggota' && u.divisi_id === div.id);
        
        return {
          ...div,
          ketua: divKetua || null,
          anggotas: divAnggotas
        };
      });
    }
  } catch (error) {
    console.error('Error fetching org data:', error);
  } finally {
    isLoading.value = false;
  }
};

onMounted(() => {
  fetchData();
});
</script>

<style scoped>
.app-background {
  --background: #f8fafc;
}

.custom-toolbar {
  --background: #f8fafc;
  --border-width: 0;
}

ion-title {
  font-family: "Manrope", sans-serif;
  font-weight: 700;
  color: #1e293b;
}

.page-header {
  margin-bottom: 24px;
  text-align: center;
}

.page-header h1 {
  font-family: "Manrope", sans-serif;
  font-weight: 800;
  font-size: 26px;
  color: #0f172a;
  margin: 0 0 8px 0;
}

.page-header p {
  font-family: "Inter", sans-serif;
  font-size: 15px;
  color: #64748b;
  margin: 0;
}

.loading-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 48px;
  color: #64748b;
}

.loading-state ion-spinner {
  margin-bottom: 16px;
}

.structure-container {
  display: flex;
  flex-direction: column;
  gap: 32px;
  padding-bottom: 40px;
}

.org-section {
  background: white;
  border-radius: 16px;
  padding: 24px 16px;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -1px rgba(0, 0, 0, 0.03);
}

.section-title {
  font-family: "Manrope", sans-serif;
  font-weight: 800;
  font-size: 20px;
  color: #1e293b;
  text-align: center;
  margin-bottom: 24px;
  margin-top: 0;
  padding-bottom: 12px;
  border-bottom: 2px solid #f1f5f9;
}

.card-grid {
  display: flex;
  flex-wrap: wrap;
  gap: 16px;
  justify-content: center;
}

.single-top {
  margin-bottom: 16px;
}

.org-card {
  display: flex;
  flex-direction: column;
  align-items: center;
  background: #f8fafc;
  padding: 20px 16px;
  border-radius: 12px;
  width: calc(50% - 8px);
  min-width: 140px;
  text-align: center;
  border: 1px solid #e2e8f0;
}

.org-card ion-avatar {
  width: 64px;
  height: 64px;
  margin-bottom: 12px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.org-card h3 {
  font-family: "Manrope", sans-serif;
  font-size: 15px;
  font-weight: 700;
  color: #334155;
  margin: 0 0 4px 0;
}

.nim-text {
  font-family: "Inter", sans-serif;
  font-size: 12px;
  color: #64748b;
  margin: 0 0 12px 0;
}

.advisor-card {
  background: #fef2f2;
  border-color: #fecaca;
  width: 100%;
  max-width: 250px;
}

.executive-card {
  width: 100%;
  max-width: 250px;
}

.primary-executive {
  background: #eff6ff;
  border-color: #bfdbfe;
}

.primary-executive ion-avatar {
  width: 80px;
  height: 80px;
}

.primary-executive h3 {
  font-size: 18px;
}

.secondary-executive {
  background: #f0fdfa;
  border-color: #ccfbf1;
  width: calc(50% - 8px);
}

.division-section {
  margin-bottom: 32px;
  padding: 16px;
  background: #f8fafc;
  border-radius: 12px;
  border: 1px solid #e2e8f0;
}

.division-section:last-child {
  margin-bottom: 0;
}

.div-title {
  font-family: "Manrope", sans-serif;
  font-size: 18px;
  font-weight: 800;
  color: #0f172a;
  text-align: center;
  margin-top: 0;
  margin-bottom: 16px;
}

.div-head-card {
  background: #fffbeb;
  border-color: #fde68a;
  width: 100%;
  max-width: 220px;
}

.anggota-title {
  font-family: "Inter", sans-serif;
  font-size: 14px;
  font-weight: 600;
  color: #64748b;
  text-align: center;
  margin-top: 16px;
  margin-bottom: 12px;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.anggota-card {
  background: white;
  width: calc(50% - 8px);
}

.anggota-card ion-avatar {
  width: 48px;
  height: 48px;
}

.anggota-card h3 {
  font-size: 14px;
}

.empty-role {
  text-align: center;
  padding: 12px;
  background: #f1f5f9;
  border-radius: 8px;
  color: #94a3b8;
  font-size: 13px;
  font-family: "Inter", sans-serif;
}
</style>
