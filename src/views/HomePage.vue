<!-- Template: Page completa de Ionic donde se muestra de forma estructurada en header, content, grids y un footer la interfaz de la aplicación. -->

<template>
  <ion-page>
    <ion-header :translucent="true">
      <ion-toolbar>
        <ion-title class="ion-text-center">¿Dividimos?</ion-title>
      </ion-toolbar>
    </ion-header>
    <ion-content :fullscreen="true">
      <ion-grid>
        <ion-row class="ion-justify-content-center">
          <ion-col size-xs="10" size-sm="5" class="ion-margin-top">
            <ion-input ref="inputImporte" :clear-input="true" error-text="Importe incorrecto. Introduce uno válido"
              fill="outline" helper-text="*Importe total de la cuenta" inputmode="numeric" label="Importe"
              label-placement="stacked" pattern="^(?!0\d)\d+(\.\d{1,2})?$"
              pattern-error-text="Importe incorrecto. Introduce uno válido" placeholder="Introduce un importe válido"
              type="number" :required="true" :value="importeCuenta" @ionInput="manejarImporteInput" @ionBlur="manejarBlur"
              @ionFocus="manejarFoco">
            </ion-input>
          </ion-col>
          <ion-col size-xs="10" size-sm="5" class="ion-margin-top">
            <ion-input ref="inputComensales" :clear-input="true"
              error-text="Nº comensales incorrecto. Introduce uno válido" fill="outline"
              helper-text="*Número de personas a pagar la cuenta" inputmode="numeric" label="Nº Comensales"
              label-placement="stacked" placeholder="Introduce un número de personas válido" :required="true"
              type="number" :value="comensales" @ionInput="manejarComensalesInput" @ionBlur="manejarBlur"
              @ionFocus="manejarFoco">
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
                    <ion-icon :icon="sadOutline" size="large" color="danger"></ion-icon>
                  </ion-item>
                </ion-col>
                <ion-col size-xs="12" size-sm="4">
                  <ion-item>
                    <ion-radio id="radioButton2" color="warning" justify="start" label-placement="end"
                      :value="radioButton2Value">{{ radioButton2Value }} %</ion-radio>
                    <ion-icon :icon="happySharp" size="large" color="warning"></ion-icon>
                  </ion-item>
                </ion-col>
                <ion-col size-xs="12" size-sm="4">
                  <ion-item>
                    <ion-radio id="radioButton3" color="success" justify="start" label-placement="end"
                      :value="radioButton3Value">{{ radioButton3Value }} %</ion-radio>
                    <ion-icon :icon="happyOutline" size="large" color="success"></ion-icon>
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
                  <h3><ion-text :color="colorCambio">Propina</ion-text>: {{ propina.toFixed(2) }} €</h3>
                </ion-item>
              </ion-col>
              <ion-col size-xs="12" size-md="4">
                <ion-item>
                  <h3><ion-text :color="colorCambio">Por persona</ion-text>: {{ importePersona.toFixed(2) }} €</h3>
                </ion-item>
              </ion-col>
              <ion-col size-xs="12" size-md="4">
                <ion-item>
                  <h3><ion-text :color="colorCambio">Total</ion-text>: {{ importeTotal.toFixed(2) }} €</h3>
                </ion-item>
              </ion-col>
            </ion-row>
          </ion-col>
        </ion-row>
      </ion-grid>
    </ion-content>
    <ion-footer>
      <ion-toolbar :color="colorCambio">
        <ion-title size="small" class="ion-text-center">Ionic - Trabajo Final - Aplicaciones móviles (Híbridas) - UAH |
          Jorge Romero -
          jorge.romeroc@edu.uah.es</ion-title>
      </ion-toolbar>
    </ion-footer>
  </ion-page>
</template>

<!-- Script: Elemento script (de tipo Composition API en Vue 3) que importa los componentes de Ionic, Vue e ionicons necesarios. -->

<script setup lang="ts">
import { IonCol, IonContent, IonFooter, IonGrid, IonHeader, IonIcon, IonInput, IonItem, IonPage, IonRadio, IonRadioGroup, IonRange, IonRow, IonText, IonTitle, IonToolbar } from '@ionic/vue';
import { IonInputCustomEvent, InputInputEventDetail } from '@ionic/core';
import { happyOutline, happySharp, sadOutline } from 'ionicons/icons';
import { Ref, ref, watch, computed } from 'vue';

/********************************
 * Variables
 ********************************/

const importeCuenta: Ref<number> = ref(NaN);
const comensales: Ref<number> = ref(1);
const opcionSeleccionada: Ref<number | null> = ref(null);
const rangoSeleccionadoValue: Ref<number> = ref(25);
const regexImporte: RegExp = /^(?!0\d)\d+(\.\d{1,2})?$/;
const regexComensales: RegExp = /^[1-9]\d*$/;
const colorCambio: Ref<string> = ref("tertiary");
const hasImporteValidClass: Ref<boolean> = ref(false);
const hasImporteInvalidClass: Ref<boolean> = ref(false);
const hasComensalesValidClass: Ref<boolean> = ref(false);
const hasComensalesInvalidClass: Ref<boolean> = ref(false);

const radioButton1Value: string = "0";
const radioButton2Value: string = "10";
const radioButton3Value: string = "20";

/********************************
 * Gestión de eventos
 ********************************/

/**
 * Función para manejar el evento de input de importeCuenta
 *
 * @param {IonInputCustomEvent<InputInputEventDetail>} event - Evento de input.
 * @returns {void}
 */
const manejarImporteInput = (event: IonInputCustomEvent<InputInputEventDetail>): void => {

  const valorImporteInput = parseFloat(event.detail.value || '');
  importeCuenta.value = isNaN(valorImporteInput) ? 0 : valorImporteInput;

  event.target.classList.remove("ion-valid", "ion-invalid");

  if (!regexImporte.test(valorImporteInput.toString())) {
    event.target.classList.add("ion-invalid");
    console.log(`[Evento][Input]: ${event.type} - Importe introducido = ${event.detail.value} | Es un importe INVÁLIDO`);
  } else {
    event.target.classList.add("ion-valid");
    console.log(`[Evento][Input]: ${event.type} - Importe introducido = ${event.detail.value} | Es un importe VÁLIDO`);
  }

  hasImporteValidClass.value = event.target.classList.contains('ion-valid');
  hasImporteInvalidClass.value = event.target.classList.contains('ion-invalid');
}

/**
 * Función para manejar el evento de input de comensales
 *
 * @param {IonInputCustomEvent<InputInputEventDetail>} event - Evento de input.
 * @returns {void}
 */
const manejarComensalesInput = (event: IonInputCustomEvent<InputInputEventDetail>): void => {

  const valorComensalesInput = parseFloat(event.detail.value || '');
  comensales.value = isNaN(valorComensalesInput) ? 0 : valorComensalesInput;

  event.target.classList.remove("ion-valid", "ion-invalid");

  if (!regexComensales.test(valorComensalesInput.toString())) {
    event.target.classList.add("ion-invalid");
    console.log(`[Evento][Input]: ${event.type} - Comensales introducidos = ${event.detail.value} | Es un importe INVÁLIDO`);
  } else {
    event.target.classList.add("ion-valid");
    console.log(`[Evento][Input]: ${event.type} - Comensales introducidos = ${event.detail.value} | Es un importe VÁLIDO`);
  }

  hasComensalesValidClass.value = event.target.classList.contains('ion-valid');
  hasComensalesInvalidClass.value = event.target.classList.contains('ion-invalid');
}

/**
 * Función para manejar el evento de hacer foco
 *
 * @param {IonInputCustomEvent<FocusEvent>} event - Evento de foco.
 * @returns {void}
 */
const manejarFoco = (event: IonInputCustomEvent<FocusEvent>): void => {
  console.log("[Evento][Foco][Hacer foco]: " + event.type);
  event.target.classList.add("ion-touched");
};

/**
 * Función para manejar el evento de devolver el foco
 *
 * @param {IonInputCustomEvent<FocusEvent>} event - Evento de blur.
 * @returns {void}
 */
const manejarBlur = (event: IonInputCustomEvent<FocusEvent>): void => {
  console.log("[Evento][Foco][Devolver foco]: " + event.type);
  event.target.classList.add("ion-untouched");
};

/********************************
 * Propiedades computadas
 ********************************/

/**
 * Calcula la propina.
 */
const propina = computed(() => {
  if (typeof opcionSeleccionada.value === "number") {
    return importeCuenta.value * (opcionSeleccionada.value / 100);
  } else if (typeof opcionSeleccionada.value === "string" && !isNaN(importeCuenta.value)) {
    return importeCuenta.value * (parseFloat(opcionSeleccionada.value) / 100);
  } else {
    return 0;
  }
});

/**
 * Calcula el importe por persona.
 */
const importePersona = computed(() => {
  if (isNaN(importeCuenta.value) || isNaN(comensales.value)) {
    return 0;
  } else if (typeof importeCuenta.value === "number") {
    return (importeCuenta.value + propina.value) / comensales.value;
  } else if (typeof importeCuenta.value === "string") {
    return (parseFloat(importeCuenta.value) + propina.value) / comensales.value;
  } else {
    return 0;
  }
});

/**
 * Calcula el importe total.
 */
const importeTotal = computed(() => {
  if (isNaN(importeCuenta.value)) {
    return 0;
  } else if (typeof importeCuenta.value === "number") {
    return importeCuenta.value + propina.value;
  } else {
    return parseFloat(importeCuenta.value) + propina.value;
  }
});

/********************************
 * Watchers
 ********************************/

/**
 * Observa el valor de las clases de los inputs y cambia el color del footer en consecuencia
 */
watch([hasImporteValidClass, hasImporteInvalidClass, hasComensalesValidClass, hasComensalesInvalidClass], () => {
  if (hasImporteValidClass.value && hasComensalesValidClass.value) {
    colorCambio.value = 'success';
  } else if (hasImporteInvalidClass.value || hasComensalesInvalidClass.value) {
    colorCambio.value = 'danger';
  } else {
    colorCambio.value = 'tertiary';
  }
  console.log("[Watcher]:" +
    ` hasImporteValidClass = ${hasImporteValidClass.value}` +
    ` | hasImporteInvalidClass = ${hasImporteInvalidClass.value}` +
    ` | hasComensalesValidClass = ${hasComensalesValidClass.value}` +
    ` | hasComensalesInvalidClass = ${hasComensalesInvalidClass.value}`);
});

/**
 * Observa el valor del rango seleccionado y lo asigna a la opción seleccionada.
 */
watch(rangoSeleccionadoValue, () => {
  opcionSeleccionada.value = rangoSeleccionadoValue.value;
});
</script>

<!-- Style: Estilos CSS3 del Single-File Component que solo aplican a los titulos h1 y h3 de este componente -->

<style scoped>
h1,
h3 {
  margin: 0;
  padding: 10px;
  color: #8c8c8c;
}
</style>