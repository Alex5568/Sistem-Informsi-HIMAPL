<template>
  <ion-page>
    <ion-content class="login-content">
      <div class= "flex-center">

        <ion-card class="horizontal-margin" style="width: 100%; max-width: 400px;">
            <ion-card-header>
                <ion-card-title color="primary" class="ion-text-center">HIMAPL</ion-card-title>
            </ion-card-header>
            <br>
            <ion-card-content>
                <ion-item>
                    <ion-input
                    label="Email"
                    label-placement="floating"
                    type="email"
                    placeholder="Masukkan email">
                    </ion-input>
                </ion-item>

                <ion-item>
                    <ion-input
                    label="Password"
                    label-placement="floating"
                    type="password"
                    placeholder="Masukkan password">
                    </ion-input>
                </ion-item>

                <br>
                <div class="align-center">
                <ion-button color="primary" size="default" class="ion-margin-top" @click="handleLogin">
                  Login
                </ion-button>

                <ion-button fill="clear" color="primary" size="default" class="ion-margin-top" @click="goToRegister">
                  Register
                </ion-button>
                </div>
                
                <div class="align-center">
                <ion-button fill="clear" color="dark" size="small" class="forgot-btn">
                  lupa password?
                </ion-button>
                </div>
            </ion-card-content>
        </ion-card>
      </div>
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { IonPage, IonContent, IonItem, IonLabel, IonInput, IonButton, IonCard, IonCardHeader, IonCardTitle, IonCardContent } from '@ionic/vue';
import { useRouter } from 'vue-router';

const router = useRouter();

const handleLogin = () => {
  console.log('Proses login berjalan ...');
  router.push('/home');
};

const goToRegister = () => {
  console.log('Navigasi ke halaman register ...');
  router.push('/register');
};
</script>

<style scoped>
.login-content{
  --background: var(--ion-color-light);
}

.flex-center {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100%;
}

.align-center {
  text-align: center;
  align-items: center;
}

.horizontal-margin {
  margin-left: 20px;
  margin-right: 20px;
}

.forgot-btn {
  text-transform: initial;
  margin-top: 10px;
}
</style>