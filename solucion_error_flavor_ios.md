<!-- # Guía de Solución: Error de Flavors en iOS (Flutter)

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

### Paso 3: Asignar las Configuraciones al Esquema
1. Regresa a **Product** > **Scheme** > **Manage Schemes...**
2. Selecciona tu esquema personalizado recién creado (ej. `dev`) y haz clic en **Edit...**
3. En el menú de la izquierda, selecciona cada sección y cambia el menú desplegable **Build Configuration** para que coincida con tu flavor:
   * **Run**: Cambia a `Debug-dev`
   * **Test**: Cambia a `Debug-dev`
   * **Profile**: Cambia a `Profile-dev`
   * **Analyze**: Cambia a `Debug-dev`
   * **Archive**: Cambia a `Release-dev`
4. Haz clic en **Close**.

### Paso 4: Limpiar y Ejecutar el Proyecto
Cierra Xcode por completo, regresa a la terminal de tu proyecto y ejecuta los siguientes comandos para limpiar la caché de compilación y probar la configuración:

```bash
flutter clean
flutter pub get
flutter run --flavor dev
```
*(Reemplaza `dev` por el nombre de tu sabor si configuraste uno diferente).* -->


# Configuración Completa de Flavors en Flutter (iOS)
## Entornos: Dev y Prod

Este documento guía el proceso paso a paso para configurar correctamente sabores (*flavors*) en un proyecto de Flutter para la plataforma iOS, solucionando errores de esquemas, iconos desactualizados, nombres de aplicación dinámicos e identificadores de paquete (*Bundle IDs*) únicos.

---

## 1. Solución al Error de Esquemas (`--flavor`)

iOS no reconoce de forma nativa los *flavors* de Flutter; requiere **Xcode Schemes** compartidos.

### Paso A: Crear Esquemas Personalizados
1. Abre tu proyecto en Xcode (`ios/Runner.xcworkspace`).
2. En el menú superior, ve a **Product** > **Scheme** > **Manage Schemes...**
3. Selecciona **Runner**, haz clic en el icono del **engranaje** (abajo a la izquierda) y elige **Duplicate**.
4. Cambia el nombre del esquema duplicado a `dev`.
5. Repite el proceso para crear otro esquema duplicado llamado `prod`.
6. **MUY IMPORTANTE:** Asegúrate de marcar la casilla **Shared** (Compartido) al lado de ambos esquemas (`dev` y `prod`). Si no lo haces, la CLI de Flutter no los detectará.

### Paso B: Configurar Build Configurations
1. En el navegador izquierdo de Xcode, haz clic en la raíz del proyecto **Runner** (icono azul).
2. Selecciona **Runner** bajo la sección **PROJECT** (no TARGETS).
3. Entra a la pestaña **Info**.
4. En la sección **Configurations**, haz clic en el botón **+** al final de la lista para duplicar los entornos existentes según tus sabores:

*   Duplica "Debug" ➡️ Nómbralos `Debug-dev` y `Debug-prod`
*   Duplica "Release" ➡️ Nómbralos `Release-dev` y `Release-prod`
*   Duplica "Profile" ➡️ Nómbralos `Profile-dev` y `Profile-prod`

### Paso C: Mapear el Esquema a sus Configuraciones
1. Regresa a **Product** > **Scheme** > **Manage Schemes...**
2. Selecciona el esquema `dev`, haz clic en **Edit...** y mapea su menú izquierdo así:
   *   **Run**: `Debug-dev`
   *   **Test**: `Debug-dev`
   *   **Profile**: `Profile-dev`
   *   **Analyze**: `Debug-dev`
   *   **Archive**: `Release-dev`
3. Selecciona el esquema `prod`, haz clic en **Edit...** y configúralo de la misma manera:
   *   **Run**: `Debug-prod` | **Archive**: `Release-prod`, etc.

---

## 2. Configuración Dinámica de Identificador y Nombre de la App

Para permitir instalar las versiones `dev` y `prod` simultáneamente en el mismo dispositivo y asignarles nombres diferentes.

### Paso A: Configurar el Bundle Identifier único
1. Haz clic en la raíz del proyecto **Runner** (icono azul).
2. Selecciona **Runner** bajo la sección **TARGETS**.
3. Ve a la pestaña **Build Settings** y busca `Product Bundle Identifier`.
4. Despliega la flecha y edita los valores de tus configuraciones:
   *   `Debug-dev`, `Profile-dev`, `Release-dev` ➡️ `com.tuempresa.tuapp.dev`
   *   `Debug-prod`, `Profile-prod`, `Release-prod` ➡️ `com.tuempresa.tuapp`

### Paso B: Configurar el Nombre de la App (Display Name)
1. En el mismo menú de **TARGETS** > **Build Settings**, haz clic en el botón **+** (arriba a la izquierda, debajo de las pestañas) y selecciona **Add User-Defined Setting**.
2. Nombra esta nueva variable como `APP_DISPLAY_NAME`.
3. Despliega la flecha y define los nombres visibles en el teléfono:
   *   Configuraciones `-dev` ➡️ `Mi App Dev`
   *   Configuraciones `-prod` ➡️ `Mi App`
4. Abre el archivo `ios/Runner/Info.plist`.
5. Busca la clave `<key>CFBundleDisplayName</key>` y cambia su valor de texto por la variable:
   ```xml
   <key>CFBundleDisplayName</key>
   <string>\$(APP_DISPLAY_NAME)</string>
   ```

---

## 3. Configuración de Iconos por Flavor

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

---

## 4. Automatización con `flutter_launcher_icons`

Si prefieres no arrastrar imágenes manualmente en Xcode, puedes usar este paquete agregando la configuración a tu `pubspec.yaml` (o creando archivos separados como `flutter_launcher_icons-dev.yaml`).

Ejemplo de estructura en archivos independientes para evitar saturar el `pubspec.yaml`:

### Archivo: `flutter_launcher_icons-dev.yaml`
```yaml
flutter_launcher_icons:
  android: false # Configura en true si también usas flavors en Android
  ios: true
  image_path: "assets/images/icon-dev.png"
  ios_icon_name: "AppIcon-dev"
```

### Archivo: `flutter_launcher_icons-prod.yaml`
```yaml
flutter_launcher_icons:
  android: false
  ios: true
  image_path: "assets/images/icon-prod.png"
  ios_icon_name: "AppIcon-prod"
```

### Comando para generar los iconos automáticamente:
```bash
flutter pub run flutter_launcher_icons:main -f flutter_launcher_icons-dev.yaml
flutter pub run flutter_launcher_icons:main -f flutter_launcher_icons-prod.yaml
```

---

## 5. Compilación y Limpieza de Caché (Obligatorio)

iOS almacena los iconos y nombres en caché de forma muy agresiva. Si no realizas una limpieza profunda, los cambios no se verán reflejados.

1. **Desinstala la app anterior** por completo del simulador o dispositivo físico.
2. Ejecuta los comandos de limpieza en la terminal:
```bash
flutter clean
flutter pub get
```
3. Ejecuta el entorno deseado:
```bash
# Para entorno de Desarrollo
flutter run --flavor dev

# Para entorno de Producción
flutter run --flavor prod
```
