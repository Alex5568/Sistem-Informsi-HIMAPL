<template>
  <ion-page>
    <CustomHeader title="Manage News" />
    <ion-content class="ion-padding app-background">
      <div class="manage-container">
        <h2>News Management</h2>
        
        <ion-button expand="block" class="create-btn" @click="createNews">
          Create News
        </ion-button>

        <ion-accordion-group>
          <ion-accordion v-for="news in newsList" :key="news.id" :value="news.id">
            <ion-item slot="header" color="light">
              <ion-label>
                <h2 style="font-weight: 600;">{{ news.title }}</h2>
                <p>{{ news.category || 'Uncategorized' }} • {{ new Date(news.created_at).toLocaleDateString() }}</p>
              </ion-label>
            </ion-item>
            
            <div class="accordion-content" slot="content">
              <div v-if="news.image_url" style="width: 100%; margin-bottom: 12px; border-radius: 8px; overflow: hidden;">
                <img :src="news.image_url" style="width: 100%; max-height: 200px; object-fit: cover;" />
              </div>
              <p style="margin-bottom: 16px; font-size: 14px; color: #475569; white-space: pre-wrap;">{{ news.content }}</p>
              
              <div style="display: flex; justify-content: flex-end; gap: 8px; border-top: 1px solid #e2e8f0; padding-top: 12px;">
                <ion-button fill="clear" @click="editNews(news)">
                  <ion-icon slot="start" :icon="createOutline"></ion-icon>
                  Edit
                </ion-button>
                <ion-button fill="clear" color="danger" @click="deleteNews(news.id)">
                  <ion-icon slot="start" :icon="trashOutline"></ion-icon>
                  Delete
                </ion-button>
              </div>
            </div>
          </ion-accordion>
        </ion-accordion-group>
      </div>

      <!-- Create/Edit News Modal -->
      <ion-modal :is-open="isCreateModalOpen" @didDismiss="isCreateModalOpen = false">
        <ion-header>
          <ion-toolbar>
            <ion-title>{{ isEditing ? 'Edit News' : 'Create News' }}</ion-title>
            <ion-buttons slot="end">
              <ion-button @click="isCreateModalOpen = false">Cancel</ion-button>
            </ion-buttons>
          </ion-toolbar>
        </ion-header>
        <ion-content class="ion-padding">
          <ion-list>
            <ion-item>
              <ion-input label="News Title" label-placement="floating" v-model="newNews.title" placeholder="Enter title"></ion-input>
            </ion-item>
            
            <ion-item>
              <ion-select label="Category" label-placement="floating" v-model="newNews.category">
                <ion-select-option value="ANNOUNCEMENT">Announcement</ion-select-option>
                <ion-select-option value="ACHIEVEMENT">Achievement</ion-select-option>
                <ion-select-option value="GENERAL">General</ion-select-option>
              </ion-select>
            </ion-item>

            <ion-item>
              <div style="width: 100%; margin: 8px 0;">
                <ion-label position="stacked" style="font-size: 14px; color: #64748b; margin-bottom: 8px; display: block;">News Image (URL or Upload)</ion-label>
                <ion-input type="text" placeholder="Paste image URL here" v-model="newNews.image_url" style="margin-bottom: 8px; --background: #f8fafc; border-radius: 8px;"></ion-input>
                <div style="display: flex; gap: 8px; align-items: center; margin-bottom: 8px;">
                  <span style="font-size: 12px; color: #64748b;">OR</span>
                  <input type="file" accept="image/*" @change="handleImageUpload" style="font-size: 12px;" />
                </div>
                <div v-if="isUploadingImage" style="font-size: 12px; color: #2563eb; margin-top: 4px;">Uploading and compressing...</div>
                <div v-if="newNews.image_url" style="margin-top: 8px;">
                  <img :src="newNews.image_url" style="max-height: 150px; border-radius: 8px; object-fit: cover; border: 1px solid #e2e8f0;" />
                  <div style="margin-top: 4px;">
                    <ion-button fill="clear" color="danger" size="small" @click="newNews.image_url = ''">Remove Image</ion-button>
                  </div>
                </div>
              </div>
            </ion-item>
          
            <ion-item>
              <ion-textarea label="Content" label-placement="floating" v-model="newNews.content" placeholder="Enter full news content..." :auto-grow="true" :rows="6"></ion-textarea>
            </ion-item>
          </ion-list>
          
          <ion-button expand="block" class="save-btn" @click="saveNews" :disabled="isSaving">
            {{ isSaving ? 'Saving...' : (isEditing ? 'Update News' : 'Save News') }}
          </ion-button>
        </ion-content>
      </ion-modal>

    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { 
  IonPage, IonContent, IonButton, 
  IonAccordionGroup, IonAccordion, IonItem, IonLabel, IonIcon, toastController, alertController,
  IonModal, IonHeader, IonToolbar, IonTitle, IonButtons, IonList, IonInput, IonTextarea, IonSelect, IonSelectOption
} from '@ionic/vue';
import { createOutline, trashOutline } from 'ionicons/icons';
import { ref, onMounted } from 'vue';
import CustomHeader from '../components/CustomHeader.vue';
import { supabase } from '../supabase';

const newsList = ref<any[]>([]);
const isCreateModalOpen = ref(false);
const isSaving = ref(false);
const isUploadingImage = ref(false);
const isEditing = ref(false);
const editingNewsId = ref<string | null>(null);

const newNews = ref({
  title: '',
  content: '',
  category: 'GENERAL',
  image_url: ''
});

const showToast = async (msg: string, color: string) => {
  const toast = await toastController.create({
    message: msg,
    duration: 2000,
    color: color
  });
  toast.present();
};

const fetchNews = async () => {
  try {
    const { data, error } = await supabase
      .from('news')
      .select('*')
      .order('created_at', { ascending: false });
      
    if (error) throw error;
    if (data) newsList.value = data;
  } catch (error) {
    console.error('Error fetching news:', error);
  }
};

onMounted(() => {
  fetchNews();
});

const createNews = () => {
  isEditing.value = false;
  editingNewsId.value = null;
  newNews.value = {
    title: '',
    content: '',
    category: 'GENERAL',
    image_url: ''
  };
  isCreateModalOpen.value = true;
};

const compressImage = (file: File, maxWidth = 1000, maxHeight = 1000, quality = 0.7): Promise<File> => {
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

        if (width > height) {
          if (width > maxWidth) {
            height = Math.round((height * maxWidth) / width);
            width = maxWidth;
          }
        } else {
          if (height > maxHeight) {
            width = Math.round((width * maxHeight) / height);
            height = maxHeight;
          }
        }

        canvas.width = width;
        canvas.height = height;

        const ctx = canvas.getContext('2d');
        if (!ctx) return reject(new Error('No canvas context'));
        ctx.drawImage(img, 0, 0, width, height);

        canvas.toBlob((blob) => {
          if (!blob) return reject(new Error('Canvas to Blob failed'));
          const compressedFile = new File([blob], file.name.replace(/\.[^/.]+$/, "") + ".jpg", {
            type: 'image/jpeg',
            lastModified: Date.now(),
          });
          resolve(compressedFile);
        }, 'image/jpeg', quality);
      };
      img.onerror = (error) => reject(error);
    };
    reader.onerror = (error) => reject(error);
  });
};

const handleImageUpload = async (event: Event) => {
  const target = event.target as HTMLInputElement;
  const file = target.files?.[0];
  if (!file) return;

  isUploadingImage.value = true;
  try {
    // Compress the image before uploading
    const compressedFile = await compressImage(file, 800, 800, 0.7);

    const fileExt = 'jpg';
    const fileName = `${Math.random()}.${fileExt}`;
    const filePath = `news/${fileName}`;

    const { error: uploadError } = await supabase.storage
      .from('DOKUMENTASI-EVENT') 
      .upload(filePath, compressedFile);

    if (uploadError) throw uploadError;

    const { data: { publicUrl } } = supabase.storage
      .from('DOKUMENTASI-EVENT')
      .getPublicUrl(filePath);

    newNews.value.image_url = publicUrl;
    showToast('Image uploaded & compressed', 'success');
  } catch (error: any) {
    console.error('Upload error:', error);
    showToast('Failed to upload image', 'danger');
  } finally {
    isUploadingImage.value = false;
  }
};

const saveNews = async () => {
  if (!newNews.value.title) {
    showToast('Title is required', 'warning');
    return;
  }
  if (!newNews.value.content) {
    showToast('Content is required', 'warning');
    return;
  }

  isSaving.value = true;
  try {
    const payload = {
      title: newNews.value.title,
      content: newNews.value.content,
      category: newNews.value.category as any,
      image_url: newNews.value.image_url || null
    };

    if (isEditing.value && editingNewsId.value) {
      const { error: updateError } = await supabase
        .from('news')
        .update(payload)
        .eq('id', editingNewsId.value);
        
      if (updateError) throw updateError;
      showToast('News updated successfully', 'success');
    } else {
      const { error: insertError } = await supabase
        .from('news')
        .insert([payload]);
        
      if (insertError) throw insertError;
      showToast('News created successfully', 'success');
    }
    
    isCreateModalOpen.value = false;
    fetchNews();
  } catch (error: any) {
    console.error('Error saving news:', error);
    showToast(error.message || 'Failed to save news', 'danger');
  } finally {
    isSaving.value = false;
  }
};

const editNews = (news: any) => {
  isEditing.value = true;
  editingNewsId.value = news.id;
  newNews.value = {
    title: news.title,
    content: news.content || '',
    category: news.category || 'GENERAL',
    image_url: news.image_url || ''
  };
  isCreateModalOpen.value = true;
};

const deleteNews = async (id: string) => {
  const alert = await alertController.create({
    header: 'Confirm Delete',
    message: 'Are you sure you want to delete this news article?',
    buttons: [
      { text: 'Cancel', role: 'cancel' },
      {
        text: 'Delete',
        role: 'confirm',
        handler: async () => {
          try {
            const { error } = await supabase.from('news').delete().eq('id', id);
            if (error) throw error;
            newsList.value = newsList.value.filter(n => n.id !== id);
            showToast('News deleted successfully', 'success');
          } catch (err: any) {
            console.error('Error deleting news:', err);
            showToast('Failed to delete news', 'danger');
          }
        }
      }
    ]
  });
  await alert.present();
};
</script>

<style scoped>
.manage-container {
  background: white;
  padding: 24px;
  border-radius: 12px;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
  margin-top: 16px;
}
.manage-container h2 {
  margin-top: 0;
  margin-bottom: 16px;
  color: #1e293b;
  font-weight: 700;
}
.create-btn {
  margin-bottom: 24px;
  --background: #2563eb;
  font-weight: 600;
}
.accordion-content {
  padding: 16px;
  background: white;
}
.save-btn {
  margin-top: 24px;
  --background: #2563eb;
  font-weight: 600;
}
</style>
