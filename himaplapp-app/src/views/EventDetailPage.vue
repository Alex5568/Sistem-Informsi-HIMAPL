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
          <img :src="docs.length > 0 ? docs[docs.length - 1].url_foto : 'https://ionicframework.com/docs/img/demos/card-media.png'" alt="Event Hero Image" class="hero-image"/>
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
                  <p>{{ event.lokasi ? event.lokasi.nama_ruangan : 'TBA' }}</p>
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
              
              <div class="tags-section" style="margin-top: 24px;" v-if="event.event_kategori_mapping && event.event_kategori_mapping.length">
                <h3>Tags</h3>
                <ion-badge class="badge-blue" v-for="mapping in event.event_kategori_mapping" :key="mapping.kategori_event?.nama_kategori" style="margin-right: 8px;">
                  {{ mapping.kategori_event?.nama_kategori }}
                </ion-badge>
              </div>

              <div class="links-section" style="margin-top: 24px;" v-if="event.event_links && event.event_links.length">
                <h3>Event Links</h3>
                <ion-list lines="none" style="padding: 0;">
                  <ion-item v-for="link in event.event_links" :key="link.url" style="--padding-start: 0; --inner-padding-end: 0;" button @click="openLink(link.url)">
                    <ion-icon :icon="linkOutline" slot="start" color="primary"></ion-icon>
                    <ion-label color="primary">{{ link.nama_tautan }}</ion-label>
                  </ion-item>
                </ion-list>
              </div>
            </ion-card-content>
          </ion-card>

          <!-- Task Section -->
          <ion-card class="task-card">
            <ion-card-content>
              <h3>Task</h3>
              <div v-if="tasks && tasks.length > 0" class="task-detail">
                <ion-list lines="none" class="task-list">
                  <ion-item v-for="task in tasks" :key="task.id" class="task-item">
                    <ion-checkbox 
                      slot="start" 
                      :checked="task.status_selesai" 
                      :disabled="!isRegistered"
                      @ionChange="toggleTaskStatus(task)"
                    ></ion-checkbox>
                    <ion-label :class="{ 'completed-task': task.status_selesai }" class="event-desc" style="white-space: normal;">
                      {{ task.nama_tugas }}
                    </ion-label>
                  </ion-item>
                </ion-list>
              </div>
              <div v-else class="no-task">
                <p class="event-desc">No task available.</p>
              </div>
            </ion-card-content>
          </ion-card>

          <!-- Documentation Upload Button -->
          <div style="margin: 0 16px;">
            <ion-button expand="block" class="upload-btn" @click="triggerUpload" :disabled="isUploading">
              {{ isUploading ? 'Uploading...' : 'Upload Photo' }}
            </ion-button>
            <input type="file" ref="fileInputGallery" accept="image/*" style="display: none;" @change="handleFileUpload" />
            <input type="file" ref="fileInputCamera" accept="image/*" capture="environment" style="display: none;" @change="handleFileUpload" />
          </div>

          <!-- Dokumentasi Section -->
          <div class="dokumentasi-section">
            <div class="doc-header">
              <h3>Documentation</h3>
              <a href="#" class="view-all" @click.prevent="isDocsModalOpen = true">View All</a>
            </div>
            
            <div class="doc-grid" v-if="docs.length > 0">
              <div class="doc-main">
                <img :src="docs[0].url_foto" alt="Doc 1" />
              </div>
              <div class="doc-side" v-if="docs.length > 1">
                <img :src="docs[1].url_foto" alt="Doc 2" class="side-img" />
                <div class="side-img-wrapper" v-if="docs.length > 2">
                  <img :src="docs[2].url_foto" alt="Doc 3" class="side-img" />
                  <div class="more-overlay" v-if="docs.length > 3">
                    +{{ docs.length - 3 }}
                  </div>
                </div>
              </div>
            </div>
            <div v-else class="no-doc">
              <p>No documentation available.</p>
            </div>
          </div>
        </div>
      </div>
      
      <div v-else class="loading-state" style="text-align: center; margin-top: 50px; color: white;">
        Event not found.
      </div>

      <!-- Documentation Modal -->
      <ion-modal :is-open="isDocsModalOpen" @didDismiss="isDocsModalOpen = false">
        <ion-header>
          <ion-toolbar>
            <ion-title>All Documentation</ion-title>
            <ion-buttons slot="end">
              <ion-button @click="isDocsModalOpen = false">Close</ion-button>
            </ion-buttons>
          </ion-toolbar>
        </ion-header>
        <ion-content class="ion-padding">
          <div class="scroll-container">
            <div class="scroll-item" v-for="doc in docs" :key="doc.id">
              <img :src="doc.url_foto" alt="Documentation Image" />
              <ion-button expand="block" fill="clear" @click="downloadImage(doc.url_foto, doc.id)">
                <ion-icon :icon="downloadOutline" slot="start"></ion-icon>
                Download
              </ion-button>
              <ion-button expand="block" fill="clear" color="danger" v-if="['Ketua', 'Wakil Ketua', 'Dosen'].includes(currentUserRole)" @click="deleteDoc(doc.id, doc.url_foto)">
                <ion-icon :icon="trashOutline" slot="start"></ion-icon>
                Delete
              </ion-button>
            </div>
          </div>
        </ion-content>
      </ion-modal>
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
  IonCard, IonCardContent, IonList, IonItem, IonCheckbox, IonLabel,
  actionSheetController, alertController, IonModal
} from '@ionic/vue';
import { calendarOutline, locationOutline, peopleOutline, cameraOutline, imageOutline, linkOutline, closeOutline, downloadOutline, trashOutline } from 'ionicons/icons';
import { ref, onMounted, computed } from 'vue';
import { useRoute } from 'vue-router';
import { supabase } from '../supabase';

const route = useRoute();
const eventId = Number(Array.isArray(route.params.id) ? route.params.id[0] : route.params.id);

const event = ref<any>(null);
const tasks = ref<any[]>([]);
const docs = ref<any[]>([]);
const fileInputGallery = ref<HTMLInputElement | null>(null);
const fileInputCamera = ref<HTMLInputElement | null>(null);
const isUploading = ref(false);
const isDocsModalOpen = ref(false);
const isLoading = ref(true);
const isProcessing = ref(false);
const isRegistered = ref(false);
const participantsCount = ref(0);
const currentUserId = ref<string | null>(null);
const currentUserRole = ref<string>('Anggota');

const openLink = (url: string) => {
  window.open(url, '_blank');
};

const fetchEventData = async () => {
  isLoading.value = true;
  try {
    const { data: { user } } = await supabase.auth.getUser();
    if (user) {
      currentUserId.value = user.id;
      const { data: userData } = await supabase.from('users').select('role').eq('id', user.id).single();
      if (userData) {
        currentUserRole.value = userData.role || 'Anggota';
      }
    }

    // Fetch Event Details
    const { data: eventData, error: eventError } = await supabase
      .from('events')
      .select('*, lokasi(nama_ruangan), event_kategori_mapping(kategori_event(nama_kategori)), event_links(nama_tautan, url)')
      .eq('id', eventId)
      .single();
      
    if (eventError) throw eventError;
    event.value = eventData;

    // Fetch Tasks via tugas_assignments
    if (currentUserId.value) {
      const { data: assignments, error: tasksError } = await supabase
        .from('tugas_assignments')
        .select('id, status_selesai, tugas!inner(*)')
        .eq('user_id', currentUserId.value)
        .eq('tugas.event_id', eventId);
        
      if (!tasksError && assignments) {
        tasks.value = assignments.map(a => ({
          ...a.tugas,
          assignment_id: a.id,
          status_selesai: a.status_selesai
        }));
      } else {
        tasks.value = [];
      }
    } else {
      // If not logged in, we could still fetch event tasks without status
      const { data: tasksData } = await supabase
        .from('tugas')
        .select('*')
        .eq('event_id', eventId);
      if (tasksData) {
        tasks.value = tasksData.map(t => ({ ...t, status_selesai: false }));
      } else {
        tasks.value = [];
      }
    }

    // Fetch Dokumentasi
    const { data: docsData } = await supabase
      .from('dokumentasi')
      .select('*')
      .eq('event_id', eventId)
      .order('created_at', { ascending: false });
    
    if (docsData) {
      docs.value = docsData;
    }

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

const handleLinkUpload = async (url: string) => {
  if (!url || !currentUserId.value) return;
  isUploading.value = true;
  try {
    const { error: insertError } = await supabase
      .from('dokumentasi')
      .insert({
        event_id: eventId,
        uploader_id: currentUserId.value,
        url_foto: url
      });
    if (insertError) throw insertError;
    showToast("Link uploaded successfully!", "success");
    fetchEventData();
  } catch (err: any) {
    console.error("Link upload error:", err);
    showToast(err.message || "Failed to upload link.", "danger");
  } finally {
    isUploading.value = false;
  }
};

const showLinkPrompt = async () => {
  const alert = await alertController.create({
    header: 'Paste Image Link',
    inputs: [
      {
        name: 'imageUrl',
        type: 'url',
        placeholder: 'https://example.com/image.jpg'
      }
    ],
    buttons: [
      {
        text: 'Cancel',
        role: 'cancel'
      },
      {
        text: 'Upload',
        handler: (data) => {
          if (data.imageUrl) {
            handleLinkUpload(data.imageUrl);
          }
        }
      }
    ]
  });
  await alert.present();
};

const triggerUpload = async () => {
  if (!currentUserId.value) {
    showToast("Please login first", "warning");
    return;
  }
  
  const actionSheet = await actionSheetController.create({
    header: 'Select Upload Method',
    buttons: [
      {
        text: 'Camera',
        icon: cameraOutline,
        handler: () => {
          fileInputCamera.value?.click();
        }
      },
      {
        text: 'Gallery',
        icon: imageOutline,
        handler: () => {
          fileInputGallery.value?.click();
        }
      },
      {
        text: 'Paste Image Link',
        icon: linkOutline,
        handler: () => {
          showLinkPrompt();
        }
      },
      {
        text: 'Cancel',
        icon: closeOutline,
        role: 'cancel'
      }
    ]
  });
  await actionSheet.present();
};

const compressImage = (file: File, maxWidth = 1024, quality = 0.8): Promise<Blob> => {
  return new Promise((resolve, reject) => {
    const reader = new FileReader();
    reader.readAsDataURL(file);
    reader.onload = (event) => {
      const img = new Image();
      img.src = event.target?.result as string;
      img.onload = () => {
        const canvas = document.createElement('canvas');
        let width = img.width;
        let height = img.height;

        if (width > maxWidth) {
          height = Math.round((height * maxWidth) / width);
          width = maxWidth;
        }

        canvas.width = width;
        canvas.height = height;

        const ctx = canvas.getContext('2d');
        if (!ctx) {
          reject(new Error("Canvas context is not available."));
          return;
        }
        
        ctx.drawImage(img, 0, 0, width, height);
        
        canvas.toBlob((blob) => {
          if (blob) resolve(blob);
          else reject(new Error("Canvas to Blob failed."));
        }, 'image/jpeg', quality);
      };
      img.onerror = (error) => reject(error);
    };
    reader.onerror = (error) => reject(error);
  });
};

const handleFileUpload = async (event: Event) => {
  const target = event.target as HTMLInputElement;
  const file = target.files?.[0];
  if (!file) return;

  isUploading.value = true;
  try {
    // Compress the image before uploading
    const compressedBlob = await compressImage(file, 1024, 0.7);
    const fileName = `${Math.random()}.jpg`;
    const filePath = `event_${eventId}/${fileName}`;

    // Upload to Supabase Storage bucket 'dokumentasi-event'
    const { error: uploadError, data } = await supabase.storage
      .from('dokumentasi-event')
      .upload(filePath, compressedBlob, {
        contentType: 'image/jpeg'
      });

    if (uploadError) throw uploadError;

    // Get public URL
    const { data: { publicUrl } } = supabase.storage
      .from('dokumentasi-event')
      .getPublicUrl(filePath);

    // Insert to table
    const { error: insertError } = await supabase
      .from('dokumentasi')
      .insert({
        event_id: eventId,
        uploader_id: currentUserId.value,
        url_foto: publicUrl
      });

    if (insertError) throw insertError;

    showToast("Photo uploaded successfully!", "success");
    fetchEventData(); // Refresh list

  } catch (err: any) {
    console.error("Upload error:", err);
    showToast(err.message || "Failed to upload photo.", "danger");
  } finally {
    isUploading.value = false;
    if (fileInputGallery.value) fileInputGallery.value.value = '';
    if (fileInputCamera.value) fileInputCamera.value.value = '';
  }
};

const downloadImage = async (url: string, id: number) => {
  try {
    const response = await fetch(url);
    const blob = await response.blob();
    const objectUrl = URL.createObjectURL(blob);
    const link = document.createElement('a');
    link.href = objectUrl;
    link.download = `dokumentasi_${eventId}_${id}.jpg`;
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
    URL.revokeObjectURL(objectUrl);
  } catch (err) {
    console.error("Failed to download", err);
    showToast("Failed to download image. CORS might be blocking it.", "danger");
  }
};

const deleteDoc = async (id: number, url: string) => {
  const alert = await alertController.create({
    header: 'Hapus Dokumentasi',
    message: 'Apakah Anda yakin ingin menghapus dokumentasi ini?',
    buttons: [
      {
        text: 'Batal',
        role: 'cancel'
      },
      {
        text: 'Hapus',
        role: 'destructive',
        handler: async () => {
          try {
            // Delete record from database
            const { error: dbError } = await supabase
              .from('dokumentasi')
              .delete()
              .eq('id', id);
            
            if (dbError) throw dbError;

            // Optionally, delete from storage bucket if it's stored in our bucket
            if (url.includes('dokumentasi-event')) {
              try {
                // Extract the path after the bucket name
                const urlObj = new URL(url);
                const pathParts = urlObj.pathname.split('dokumentasi-event/');
                if (pathParts.length > 1) {
                  const filePath = pathParts[1];
                  // Delete file from storage array
                  await supabase.storage.from('dokumentasi-event').remove([filePath]);
                }
              } catch (storageError) {
                console.error('Failed to delete file from storage', storageError);
                // We don't throw because the db record deletion is the main concern
              }
            } else if (url.includes('DOKUMENTASI-EVENT')) {
              try {
                const urlObj = new URL(url);
                const pathParts = urlObj.pathname.split('DOKUMENTASI-EVENT/');
                if (pathParts.length > 1) {
                  const filePath = pathParts[1];
                  await supabase.storage.from('DOKUMENTASI-EVENT').remove([filePath]);
                }
              } catch (storageError) {
                console.error('Failed to delete file from storage', storageError);
              }
            }

            // Remove from local list
            docs.value = docs.value.filter(d => d.id !== id);
            showToast('Dokumentasi berhasil dihapus', 'success');

          } catch (err: any) {
            console.error('Deletion error:', err);
            showToast(err.message || 'Gagal menghapus dokumentasi', 'danger');
          }
        }
      }
    ]
  });
  await alert.present();
};

const toggleTaskStatus = async (task: any) => {
  if (!currentUserId.value) {
    showToast("Silakan login terlebih dahulu", "warning");
    return;
  }
  if (!isRegistered.value) {
    showToast("Anda harus melakukan registrasi event terlebih dahulu untuk menyelesaikan tugas.", "warning");
    return;
  }

  const newStatus = !task.status_selesai;
  // Optimistic UI update
  task.status_selesai = newStatus;
  
  try {
    const { error } = await supabase
      .from('tugas_assignments')
      .update({ status_selesai: newStatus })
      .eq('id', task.assignment_id);

    if (error) throw error;
    
    showToast(newStatus ? 'Tugas diselesaikan' : 'Status tugas dibatalkan', 'success');
  } catch (err: any) {
    // Revert on error
    task.status_selesai = !newStatus;
    console.error("Error updating task status:", err);
    showToast("Gagal memperbarui status tugas.", "danger");
  }
};

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

    // Auto-assign tasks to newly registered user
    try {
      const { data: eventTasks } = await supabase.from('tugas').select('id, assign_type').eq('event_id', eventId);
      if (eventTasks && eventTasks.length > 0) {
        let tasksToAssign: any[] = [];
        
        for (const t of eventTasks) {
          if (t.assign_type === 'global') {
            tasksToAssign.push({ tugas_id: t.id, user_id: currentUserId.value, status_selesai: false });
          }
        }
        
        if (tasksToAssign.length > 0) {
          // insert with onConflict ignore in case they already have it
          await supabase.from('tugas_assignments').upsert(tasksToAssign, { onConflict: 'tugas_id, user_id', ignoreDuplicates: true });
        }
      }
      
      // Refresh tasks
      fetchEventData();
    } catch (e) {
      console.error("Auto assign error", e);
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
.task-card {
  margin: 16px;
  border-radius: 16px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
  background: white;
  border: 1.5px solid #3b82f6;
}
.task-card h3 {
  font-size: 18px;
  color: #0f172a;
  margin-bottom: 12px;
  font-weight: 700;
  margin-top: 0;
}
.task-list {
  background: transparent;
  padding: 0;
}
.task-item {
  --background: transparent;
  --padding-start: 0;
  --inner-padding-end: 0;
}
.completed-task {
  text-decoration: line-through;
  color: #94a3b8;
}

/* Dokumentasi CSS */
.dokumentasi-section {
  margin: 16px;
}
.doc-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 12px;
}
.doc-header h3 {
  font-size: 18px;
  font-weight: 700;
  color: #0f172a;
  margin: 0;
}
.view-all {
  color: #2563eb;
  font-size: 14px;
  text-decoration: none;
  font-weight: 600;
}
.doc-grid {
  display: grid;
  grid-template-columns: 2fr 1fr;
  gap: 8px;
  height: 200px;
}
.doc-main {
  width: 100%;
  height: 100%;
  border-radius: 12px;
  overflow: hidden;
  background: #e2e8f0;
}
.doc-main img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}
.doc-side {
  display: grid;
  grid-template-rows: 1fr 1fr;
  gap: 8px;
  height: 100%;
}
.side-img-wrapper {
  position: relative;
  width: 100%;
  height: 100%;
  border-radius: 12px;
  overflow: hidden;
  background: #e2e8f0;
}
.side-img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  border-radius: 12px;
}
.more-overlay {
  position: absolute;
  top: 0; left: 0; width: 100%; height: 100%;
  background: rgba(0,0,0,0.5);
  color: white;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 18px;
  font-weight: bold;
}
.no-doc {
  text-align: center;
  padding: 20px;
  background: white;
  border-radius: 12px;
}
.no-doc p {
  color: #64748b;
  margin: 0;
}
.upload-btn {
  margin-top: 16px;
  --background: #eff6ff;
  --color: #2563eb;
  --box-shadow: none;
  font-weight: 600;
}

/* Modal Scroll Container */
.scroll-container {
  display: flex;
  flex-direction: column;
  gap: 16px;
  padding-bottom: 16px;
}
.scroll-item {
  border-radius: 12px;
  background: #f8fafc;
  overflow: hidden;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
  display: flex;
  flex-direction: column;
}
.scroll-item img {
  width: 100%;
  height: 300px;
  object-fit: contain;
  background: #000;
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
