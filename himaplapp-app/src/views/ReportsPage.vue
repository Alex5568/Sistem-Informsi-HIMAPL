<template>
  <ion-page>
    <ion-header class="ion-no-border">
      <ion-toolbar class="custom-toolbar">
        <ion-buttons slot="start">
          <ion-menu-button color="primary"></ion-menu-button>
        </ion-buttons>
        <ion-title>Reports</ion-title>
      </ion-toolbar>
    </ion-header>

    <ion-content class="ion-padding">
      <div class="page-header">
        <h1>Annual Reports</h1>
        <p>View reports related to activities and projects.</p>
      </div>

      <!-- Filters Section -->
      <div class="filters-container">
        <div class="search-row">
          <ion-searchbar 
            placeholder="Search reports..." 
            class="custom-searchbar"
            v-model="searchQuery"
            mode="ios">
          </ion-searchbar>
          <ion-button fill="clear" color="primary" class="filter-toggle-btn" @click="showFilters = !showFilters">
            <ion-icon slot="icon-only" :icon="optionsOutline"></ion-icon>
          </ion-button>
        </div>
        
        <div class="dropdown-filters" v-show="showFilters">
          <ion-item class="filter-item" lines="none">
            <ion-select placeholder="Year" interface="popover" v-model="selectedYear">
              <ion-select-option v-for="year in availableYears" :key="year" :value="year.toString()">{{ year }}</ion-select-option>
            </ion-select>
          </ion-item>
          
          <ion-item class="filter-item" lines="none">
            <ion-select placeholder="Category" interface="popover" :multiple="true" v-model="selectedCategory">
              <ion-select-option v-for="cat in categories" :key="cat" :value="cat">{{ cat }}</ion-select-option>
            </ion-select>
          </ion-item>

          <ion-button fill="clear" color="medium" class="reset-button" @click="resetFilters" v-if="hasActiveFilters">
            <ion-icon slot="icon-only" :icon="refreshOutline"></ion-icon>
          </ion-button>
        </div>
      </div>
      
      <!-- Reports Table -->
      <div v-if="filteredReports.length > 0" class="table-container">
        <table class="reports-table">
          <thead>
            <tr>
              <th>ID Event</th>
              <th>Event Name</th>
              <th>Participants</th>
              <th>Start Date</th>
              <th>Category</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="report in filteredReports" :key="report.id">
              <td>{{ report.id }}</td>
              <td>{{ report.nama_event }}</td>
              <td>{{ report.participantsCount }}</td>
              <td>{{ formatDate(report.start_date) }}</td>
              <td>{{ formatCategory(report.kategori) }}</td>
            </tr>
          </tbody>
        </table>
      </div>
      
      <!-- Empty State -->
      <div v-else class="empty-state">
        <ion-icon :icon="documentTextOutline" class="empty-icon"></ion-icon>
        <h2>No reports yet</h2>
        <p>Report data will appear here.</p>
      </div>
    </ion-content>

    <ion-footer class="ion-no-border">
      <ion-toolbar class="custom-toolbar">
        <ion-button expand="block" class="print-button" @click="printReport" :disabled="filteredReports.length === 0">
          <ion-icon slot="start" :icon="printOutline"></ion-icon>
          Print Report (PDF)
        </ion-button>
      </ion-toolbar>
    </ion-footer>
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
  IonIcon,
  IonSearchbar,
  IonSelect,
  IonSelectOption,
  IonItem,
  IonButton,
  IonFooter
} from '@ionic/vue';
import { documentTextOutline, refreshOutline, optionsOutline, printOutline } from 'ionicons/icons';
import { ref, computed, onMounted } from 'vue';
import { supabase } from '../supabase';

const categories = ref<string[]>([]);
const searchQuery = ref('');
const selectedYear = ref('');
const selectedCategory = ref<string[]>([]);
const showFilters = ref(false);

const currentYear = new Date().getFullYear();
const availableYears = Array.from({ length: currentYear - 2020 + 1 }, (_, i) => currentYear - i);

const reports = ref<any[]>([]);

const hasActiveFilters = computed(() => {
  return searchQuery.value !== '' || selectedYear.value !== '' || selectedCategory.value.length > 0;
});

const resetFilters = () => {
  searchQuery.value = '';
  selectedYear.value = '';
  selectedCategory.value = [];
};

const printReport = () => {
  const originalTitle = document.title;
  document.title = 'Annual Reports - HIMAPL';
  
  // A small delay to ensure the browser registers the title change before the print dialog opens
  setTimeout(() => {
    window.print();
    document.title = originalTitle;
  }, 100);
};

const formatDate = (dateString: string) => {
  if (!dateString) return '-';
  const d = new Date(dateString);
  return `${d.getDate().toString().padStart(2, '0')}/${(d.getMonth() + 1).toString().padStart(2, '0')}/${d.getFullYear()}`;
};

const formatCategory = (kategori: any) => {
  try {
    const parsed = typeof kategori === 'string' ? JSON.parse(kategori) : kategori;
    if (Array.isArray(parsed)) return parsed.join(', ');
    return parsed || '-';
  } catch {
    return kategori || '-';
  }
};

const filteredReports = computed(() => {
  return reports.value.filter(report => {
    // Search filter
    if (searchQuery.value && report.nama_event && !report.nama_event.toLowerCase().includes(searchQuery.value.toLowerCase())) {
      return false;
    }
    // Year filter
    if (selectedYear.value) {
      const reportYear = report.start_date ? new Date(report.start_date).getFullYear().toString() : '';
      if (reportYear !== selectedYear.value) return false;
    }
    // Category filter
    if (selectedCategory.value && selectedCategory.value.length > 0) {
      let cats: string[] = [];
      try {
        const parsed = typeof report.kategori === 'string' ? JSON.parse(report.kategori) : report.kategori;
        cats = Array.isArray(parsed) ? parsed : [parsed];
      } catch {
        cats = [report.kategori];
      }
      
      const hasMatch = selectedCategory.value.some(selected => cats.includes(selected));
      if (!hasMatch) return false;
    }
    return true;
  });
});

onMounted(async () => {
  try {
    const { data, error } = await supabase
      .from('events')
      .select('id, nama_event, start_date, kategori, event_participants(id)')
      .order('start_date', { ascending: false });
      
    if (data) {
      reports.value = data.map((item: any) => ({
        ...item,
        participantsCount: item.event_participants ? item.event_participants.length : 0
      }));

      let allCats: string[] = [];
      data.forEach((item: any) => {
        if (item.kategori) {
          try {
            // Parse if it's a stringified JSON array
            const parsed = typeof item.kategori === 'string' ? JSON.parse(item.kategori) : item.kategori;
            if (Array.isArray(parsed)) {
              allCats.push(...parsed);
            } else if (typeof parsed === 'string') {
              allCats.push(parsed);
            }
          } catch (e) {
            // If it's a raw string that isn't JSON
            allCats.push(item.kategori);
          }
        }
      });
      // Extract unique categories and filter out empty strings
      const uniqueCats = [...new Set(allCats)].filter(Boolean);
      categories.value = uniqueCats as string[];
    }
  } catch (err) {
    console.error("Error fetching data:", err);
  }
});
</script>

<style scoped>
.custom-toolbar {
  --background: #f8fafc;
  --border-width: 0;
}

ion-title {
  font-family: "Manrope", sans-serif;
  font-weight: 700;
  color: #1e293b;
}

ion-content {
  --background: #f8fafc;
}

.page-header {
  margin-bottom: 24px;
}

.page-header h1 {
  font-family: "Manrope", sans-serif;
  font-weight: 800;
  font-size: 28px;
  color: #0f172a;
  margin: 0 0 8px 0;
}

.page-header p {
  font-family: "Inter", sans-serif;
  font-size: 15px;
  color: #64748b;
  margin: 0;
}

/* Filters Section */
.filters-container {
  margin-bottom: 24px;
}

.search-row {
  display: flex;
  align-items: center;
  gap: 8px;
}

.custom-searchbar {
  --background: white;
  --box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
  --border-radius: 12px;
  padding: 0;
  flex: 1;
}

.filter-toggle-btn {
  margin: 0;
  height: 36px;
  --background: white;
  --border-radius: 12px;
  box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
}

.dropdown-filters {
  display: flex;
  gap: 12px;
  margin-top: 12px;
}

.filter-item {
  --background: white;
  --border-radius: 12px;
  --padding-start: 12px;
  box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
  flex: 1;
}

ion-select {
  width: 100%;
  font-family: "Inter", sans-serif;
  font-weight: 500;
  color: #334155;
  --placeholder-color: #64748b;
  --placeholder-opacity: 1;
}

.reset-button {
  --border-radius: 12px;
  margin: 0;
  height: auto;
}

.empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 48px 24px;
  text-align: center;
  background: white;
  border-radius: 16px;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -1px rgba(0, 0, 0, 0.03);
}

.empty-icon {
  font-size: 64px;
  color: #cbd5e1;
  margin-bottom: 16px;
}

.empty-state h2 {
  font-family: "Manrope", sans-serif;
  font-weight: 700;
  font-size: 20px;
  color: #334155;
  margin: 0 0 8px 0;
}

.empty-state p {
  font-family: "Inter", sans-serif;
  font-size: 14px;
  color: #94a3b8;
  margin: 0;
}

/* Table Section */
.table-container {
  background: white;
  border-radius: 12px;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -1px rgba(0, 0, 0, 0.03);
  overflow-x: auto;
}

.reports-table {
  width: 100%;
  border-collapse: collapse;
  text-align: left;
}

.reports-table th,
.reports-table td {
  padding: 16px;
  border-bottom: 1px solid #e2e8f0;
}

.reports-table th {
  background-color: #f8fafc;
  font-family: "Manrope", sans-serif;
  font-weight: 700;
  font-size: 14px;
  color: #475569;
}

.reports-table td {
  font-family: "Inter", sans-serif;
  font-size: 14px;
  color: #334155;
}

.reports-table tr:last-child td {
  border-bottom: none;
}

.print-button {
  margin: 16px;
  --border-radius: 12px;
  font-family: "Inter", sans-serif;
  font-weight: 600;
}

/* Print Styles */
@media print {
  /* Hide all Ionic UI shell elements */
  ion-header, ion-footer, .filters-container, ion-menu-button {
    display: none !important;
  }
  
  /* Reset background and padding for content */
  ion-content {
    --background: white !important;
  }
  
  /* Hide the description paragraph */
  .page-header p {
    display: none !important;
  }

  /* Make sure table container loses shadow for print */
  .table-container {
    box-shadow: none !important;
    border-radius: 0 !important;
  }

  /* Ensure table borders are printed clearly */
  .reports-table {
    border: 1px solid #e2e8f0;
  }
  
  .reports-table th, .reports-table td {
    border: 1px solid #e2e8f0;
    color: black !important;
  }
}
</style>
