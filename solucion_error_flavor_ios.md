 # Guía de Solución: Error de Flavors en iOS (Flutter)

Este documento detalla los pasos necesarios para solucionar el siguiente error al compilar una aplicación Flutter con sabores (flavors) en iOS:

`Error: The Xcode project does not define custom schemes. You cannot use the --flavor option.`

---

## 📌 Causa del Problema
A diferencia de Android, **iOS no tiene un concepto nativo de sabores (product flavors)**. En su lugar, utiliza **Esquemas de Xcode (Xcode Schemes)**. Cuando ejecutas `flutter run --flavor <nombre>`, la CLI de Flutter busca un esquema que coincida exactamente con ese nombre dentro del proyecto de Xcode. Si no existe o no está compartido, el proceso falla.

---

## 🛠️ Procedimiento de Solución Paso a Paso

### Paso 1: Crear el Esquema Personalizado en Xcode
1. Abre el espacio de trabajo de iOS en Xcode desde la raíz de tu proyecto Flutter:
   ```bash
   open ios/Runner.xcworkspace
   ```
2. En el menú superior de Xcode, navega a **Product** > **Scheme** > **Manage Schemes...**
3. Selecciona **Runner** en la lista.
4. Haz clic en el icono del **engranaje** (abajo a la izquierda) y elige **Duplicate**.
5. Cambia el nombre del nuevo esquema para que coincida exactamente con tu flavor de Flutter (por ejemplo, si usas `--flavor dev`, el esquema debe llamarse `dev`).
6. **⚠️ Crucial:** Asegúrate de marcar la casilla **Shared** (Compartido) al lado de tu nuevo esquema. Si no está marcada, la CLI de Flutter no podrá detectarlo.
7. Haz clic en **Close**.

### Paso 2: Configurar los Build Configurations
Flutter necesita mapear tu flavor con los modos de compilación de Xcode (`Debug`, `Release` y `Profile`):
1. En el navegador de proyectos (columna izquierda de Xcode), haz clic en la raíz del proyecto **Runner** (icono azul).
2. Selecciona **Runner** bajo la sección **PROJECT** en la ventana principal (no bajo *TARGETS*).
3. Selecciona la pestaña **Info** en la parte superior.
4. Localiza la sección **Configurations**. Verás las opciones por defecto: `Debug`, `Release` y `Profile`.
5. Duplica estas configuraciones para tu nuevo flavor haciendo clic en el botón **+** ubicado debajo de la lista:
   * Selecciona **Duplicate "Debug" Configuration** y nómbrala `Debug-dev` (reemplaza `dev` por tu flavor exacto).
   * Selecciona **Duplicate "Release" Configuration** y nómbrala `Release-dev`.
   * Selecciona **Duplicate "Profile" Configuration** y nómbrala `Profile-dev`.
   * Repite con los demás flavors

### Paso 3: Asignar las Configuraciones al Esquema
1. Regresa a **Product** > **Scheme** > **Manage Schemes...**
2. Selecciona tu esquema personalizado recién creado (ej. `dev`) y haz clic en **Edit...**
3. En el menú de la izquierda, selecciona cada sección y cambia el menú desplegable **Build Configuration** para que coincida con tu flavor:
   * **Run**: Cambia a `Debug-dev`
   * **Test**: Cambia a `Debug-dev`
   * **Profile**: Cambia a `Profile-dev`
   * **Analyze**: Cambia a `Debug-dev`
   * **Archive**: Cambia a `Release-dev`
   * Repite con los demás flavors

1. Haz clic en **Close**.


## 4. Configuración de Iconos por Flavor

### Método Manual en Xcode
1. Abre `ios/Runner/Assets.xcassets`.
2. Haz clic derecho en la lista de recursos ➡️ **iOS** > **iOS App Icon**.
3. Crea dos sets independientes: `AppIcon-dev` y `AppIcon-prod`. Llena cada uno con sus imágenes correspondientes.
4. Ve a **Runner (TARGETS)** > **Build Settings** y busca `Primary App Icon Set Name`.
5. Despliega la flecha y asigna el asset exacto a cada configuración:

| Configuración | Valor (Asset Name) |
| :--- | :--- |
| **Debug-dev / Profile-dev / Release-dev** | `AppIcon-dev` |
| **Debug-prod / Profile-prod / Release-prod** | `AppIcon-prod` |

## 6. Configuración Dinámica de Identificador y Nombre de la App

Para permitir instalar las versiones `dev` y `prod` simultáneamente en el mismo dispositivo y asignarles nombres diferentes.

### Paso A: Configurar el Bundle Identifier único
1. Haz clic en la raíz del proyecto **Runner** (icono azul).
2. Selecciona **Runner** bajo la sección **TARGETS**.
3. Ve a la pestaña **Build Settings** y busca `Product Bundle Identifier`.
4. Despliega la flecha y edita los valores de tus configuraciones:
   *   `Debug-dev`, `Profile-dev`, `Release-dev` ➡️ `com.tuempresa.tuapp.dev`
   *   `Debug-prod`, `Profile-prod`, `Release-prod` ➡️ `com.tuempresa.tuapp`


### Paso 7: Limpiar y Ejecutar el Proyecto
Cierra Xcode por completo, regresa a la terminal de tu proyecto y ejecuta los siguientes comandos para limpiar la caché de compilación y probar la configuración:

```bash
flutter clean
flutter pub get
flutter pub run flutter_flavorizr
```
