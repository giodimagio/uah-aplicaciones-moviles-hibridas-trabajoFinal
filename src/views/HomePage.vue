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
            <ion-input ref="inputImporte" :clear-input="true" error-text="Importe incorrecto. Introduce uno válido"
              fill="outline" helper-text="*Importe total de la cuenta" inputmode="decimal" label="Importe"
              label-placement="stacked" pattern="^\d+(\.\d{1,2})?$"
              pattern-error-text="Importe incorrecto. Introduce uno válido" placeholder="Introduce un importe válido"
              type="number" :required="true" :value="importeCuenta" @ionInput="manejarInput">
            </ion-input>
          </ion-col>
          <ion-col size-xs="10" size-sm="5" class="ion-margin-top">
            <ion-input ref="inputComensales" :clear-input="true"
              error-text="Nº comensales incorrecto. Introduce uno válido" fill="outline"
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
            <ion-radio-group v-model="opcionSeleccionada" class="ion-justify-text-center">
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
                      v-model="rangoSeleccionadoValue">{{ rangoSeleccionadoValue }} %</ion-radio>
                  </ion-item>
                  <ion-range id="rangeButton1" label-placement="start" :pin="true" v-model="rangoSeleccionadoValue">
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
import { IonCol, IonContent, IonFooter, IonGrid, IonHeader, IonIcon, IonInput, IonItem, IonPage, IonRadio, IonRadioGroup, IonRange, IonRow, IonText, IonTitle, IonToolbar, } from '@ionic/vue';
import { IonInputCustomEvent, InputInputEventDetail } from '@ionic/core';
import { happyOutline, happySharp, sadOutline } from 'ionicons/icons';
import { ref, watch, computed } from 'vue';

// Variables
const importeCuenta = ref<number>(NaN);
const comensales = ref<number>(1);
const opcionSeleccionada = ref<number | null>(null);
const rangoSeleccionadoValue = ref<number>(25);

const radioButton1Value = "0";
const radioButton2Value = "10";
const radioButton3Value = "20";

// Gestión de eventos
const manejarInput = (event: IonInputCustomEvent<InputInputEventDetail>) => {

  const valorInput = parseInt(event.detail.value || '', 10);
  importeCuenta.value = isNaN(valorInput) ? NaN : valorInput;

  console.log('Input event. Valor: ' + importeCuenta.value);
}

// Propiedades computadas
const propina = computed(() => {
  if (opcionSeleccionada.value === null) {
    return 0;
  } else if (typeof opcionSeleccionada.value === 'number') {
    return (importeCuenta.value * (opcionSeleccionada.value / 100));
  } else {
    return (importeCuenta.value * (parseInt(opcionSeleccionada.value) / 100));
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

// Watchers
watch(rangoSeleccionadoValue, () => {
  opcionSeleccionada.value = rangoSeleccionadoValue.value;
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