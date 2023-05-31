<template>
  <ion-page>
    <ion-header :translucent="true">
      <ion-toolbar>
        <ion-title class="ion-text-center">Dividimos?</ion-title>
      </ion-toolbar>
    </ion-header>
    <ion-content :fullscreen="true">
      <ion-grid>
        <ion-row class="ion-justify-content-center">
          <ion-col size-xs=10 size-sm=5 class="ion-margin-top">
            <ion-input :clear-input="true" error-text="Importe incorrecto. Introduce uno válido" fill="outline"
              helper-text="*Importe total de la cuenta" inputmode="numeric" label="Importe" label-placement="stacked"
              placeholder="Introduce un importe válido" :required="true" type="number">
            </ion-input>
          </ion-col>
          <ion-col size-xs=10 size-sm=5 class="ion-margin-top">
            <ion-input :clear-input="true" error-text="Nº comensales incorrecto. Introduce uno válido" fill="outline"
              helper-text="*Número de personas a pagar la cuenta" inputmode="numeric" label="Nº Comensales"
              label-placement="stacked" placeholder="Introduce un número de personas válido" :required="true"
              type="number">
            </ion-input>
          </ion-col>
        </ion-row>
        <ion-row>
          <ion-col class="ion-text-center">
            <h5>¿Quieres dejar propina?</h5>
          </ion-col>
        </ion-row>
        <ion-row>
          <ion-col size=10 offset=1>
            <ion-radio-group class="ion-justify-text-center">
              <ion-row class="ion-justify-content-center">
                <ion-col size-xs=12 size-sm=4>
                  <ion-item>
                    <ion-radio color="danger" justify="start" label-placement="end" value="0">0 %</ion-radio>
                    <ion-icon :icon="sadOutline" size="large"></ion-icon>
                  </ion-item>
                </ion-col>
                <ion-col size-xs=12 size-sm=4>
                  <ion-item>
                    <ion-radio color="warning" justify="start" label-placement="end" value="10">10 %</ion-radio>
                    <ion-icon :icon="happySharp" size="large"></ion-icon>
                  </ion-item>
                </ion-col>
                <ion-col size-xs=12 size-sm=4>
                  <ion-item>
                    <ion-radio color="success" justify="start" label-placement="end" value="20">20 %</ion-radio>
                    <ion-icon :icon="happyOutline" size="large"></ion-icon>
                  </ion-item>
                </ion-col>
                <ion-col size-xs=12 size-sm=6>
                  <ion-item>
                    <ion-radio color="dark" justify="start" label-placement="end">x %</ion-radio>
                  </ion-item>
                  <ion-range :pin="true" :pin-formatter="pinFormatter" @ionChange="onIonChange"></ion-range>
                </ion-col>
              </ion-row>
            </ion-radio-group>
          </ion-col>
        </ion-row>
      </ion-grid>
    </ion-content>
    <ion-footer>
      <ion-toolbar>
        <ion-title class="ion-text-center">Ionic - Trabajo Final - Aplicaciones móviles (Híbridas) - UAH</ion-title>
      </ion-toolbar>
      <ion-toolbar>
        <ion-title class="ion-text-center">Jorge Romero - jorge.romeroc@edu.uah.es</ion-title>
      </ion-toolbar>
    </ion-footer>
  </ion-page>
</template>

<script setup lang="ts">
import { IonIcon } from '@ionic/vue';
import { happyOutline, happySharp, sadOutline } from 'ionicons/icons';
import { IonInput } from '@ionic/vue';
import { IonRadio, IonRadioGroup, IonItem } from '@ionic/vue';
import { IonRange, IonLabel } from '@ionic/vue';
import { IonContent, IonHeader, IonPage, IonTitle, IonToolbar } from '@ionic/vue';
import { IonGrid, IonCol, IonRow } from '@ionic/vue';
import { IonFooter } from '@ionic/vue';
// import InputComponent from '@/views/InputComponent.vue';

const pinFormatter = (value: number) => `${value}%`;

const onIonChange = (event: CustomEvent) => { };

</script>

<style scoped>
h1,
h3 {
  margin: 0;
  padding: 10px;
  color: #8c8c8c;
}
</style>