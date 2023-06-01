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
          <ion-col size-xs="10" size-sm="5" class="ion-margin-top">
            <ion-input :clear-input="true" error-text="Importe incorrecto. Introduce uno válido" fill="outline"
              helper-text="*Importe total de la cuenta" inputmode="decimal" label="Importe" label-placement="stacked"
              pattern="^\d+(\.\d{1,2})?$" pattern-error-text="Importe incorrecto. Introduce uno válido"
              placeholder="Introduce un importe válido" type="number" :required="true" v-model="importeCuenta">
            </ion-input>
          </ion-col>
          <ion-col size-xs="10" size-sm="5" class="ion-margin-top">
            <ion-input :clear-input="true" error-text="Nº comensales incorrecto. Introduce uno válido" fill="outline"
              helper-text="*Número de personas a pagar la cuenta" inputmode="numeric" label="Nº Comensales"
              label-placement="stacked" placeholder="Introduce un número de personas válido" :required="true"
              type="number" v-model="comensales">
            </ion-input>
          </ion-col>
        </ion-row>
        <ion-row>
          <ion-col class="ion-text-center">
            <h5>¿Quieres dejar propina?</h5>
          </ion-col>
        </ion-row>
        <ion-row>
          <ion-col size="10" offset="1">
            <ion-radio-group v-model="selectedOption" class="ion-justify-text-center">
              <ion-row class="ion-justify-content-center">
                <ion-col size-xs="12" size-sm="4">
                  <ion-item>
                    <ion-radio id="radioButton1" color="danger" justify="start" label-placement="end"
                      :value="radioButton1Value">{{ radioButton1Value }} %</ion-radio>
                    <ion-icon :icon="sadOutline" size="large"></ion-icon>
                  </ion-item>
                </ion-col>
                <ion-col size-xs="12" size-sm="4">
                  <ion-item>
                    <ion-radio id="radioButton2" color="warning" justify="start" label-placement="end"
                      :value="radioButton2Value">{{ radioButton2Value }} %</ion-radio>
                    <ion-icon :icon="happySharp" size="large"></ion-icon>
                  </ion-item>
                </ion-col>
                <ion-col size-xs="12" size-sm="4">
                  <ion-item>
                    <ion-radio id="radioButton3" color="success" justify="start" label-placement="end"
                      :value="radioButton3Value">{{ radioButton3Value }} %</ion-radio>
                    <ion-icon :icon="happyOutline" size="large"></ion-icon>
                  </ion-item>
                </ion-col>
                <ion-col size-xs="12" size-sm="6">
                  <ion-item>
                    <ion-radio id="radioButton4" color="dark" justify="start" label-placement="end"
                      v-model="rangeValue">{{ rangeValue }} %</ion-radio>
                  </ion-item>
                  <ion-range id="rangeButton1" label-placement="start" :pin="true" v-model="rangeValue">
                    <div slot="label">Otro importe</div>
                  </ion-range>
                </ion-col>
              </ion-row>
            </ion-radio-group>
          </ion-col>
        </ion-row>
        <ion-row>
          <ion-col size="10" offset="1">
            <ion-row>
              <ion-col size-xs="12" size-md="4">
                <ion-item>
                  <h3><ion-text color="danger">Propina</ion-text>: {{ propina.toFixed(2) }} €
                  </h3>
                </ion-item>
              </ion-col>
              <ion-col size-xs="12" size-md="4">
                <ion-item>
                  <h3><ion-text color="danger">Por persona</ion-text>: {{ importePersona.toFixed(2) }} €</h3>
                </ion-item>
              </ion-col>
              <ion-col size-xs="12" size-md="4">
                <ion-item>
                  <h3><ion-text color="danger">Total</ion-text>: {{ importeTotal.toFixed(2) }} €</h3>
                </ion-item>
              </ion-col>
            </ion-row>
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
import { IonText } from '@ionic/vue';
import { happyOutline, happySharp, sadOutline } from 'ionicons/icons';
import { IonInput } from '@ionic/vue';
import { IonRadio, IonRadioGroup, IonItem } from '@ionic/vue';
import { IonRange, IonLabel } from '@ionic/vue';
import { IonContent, IonHeader, IonPage, IonTitle, IonToolbar } from '@ionic/vue';
import { IonGrid, IonCol, IonRow } from '@ionic/vue';
import { IonFooter } from '@ionic/vue';
import { ref, watch, computed } from 'vue';

let importeCuenta = ref(0);
let comensales = ref(1);

const radioButton1Value = "0";
const radioButton2Value = "10";
const radioButton3Value = "20";

const selectedOption = ref<number | null>(null);
const rangeValue = ref(0);

const propina = computed(() => {
  if (selectedOption.value === null) {
    return 0;
  } else if (typeof selectedOption.value === 'number') {
    return (importeCuenta.value * (selectedOption.value / 100));
  } else {
    return (importeCuenta.value * (parseInt(selectedOption.value) / 100));
  }
});

const importePersona = computed(() => {
  if (comensales.value === null || 0) {
    return 0;
  } else if (typeof importeCuenta.value === 'number') {
    return ((importeCuenta.value + propina.value) / comensales.value);
  } else {
    return ((parseInt(importeCuenta.value) + propina.value) / comensales.value);
  }
});

const importeTotal = computed(() => {
  if (importeCuenta.value === null || 0) {
    return 0;
  } else if (typeof importeCuenta.value === 'number') {
    return (importeCuenta.value + propina.value);
  } else {
    return (parseInt(importeCuenta.value) + propina.value);
  }
});

watch(rangeValue, () => {
  selectedOption.value = rangeValue.value;
});
</script>

<style scoped>
h1,
h3 {
  margin: 0;
  padding: 10px;
  color: #8c8c8c;
}
</style>