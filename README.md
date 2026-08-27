# Flutter Flavors: gestión de estado e inyección de dependencias

Aplicación Flutter creada para estudiar la configuración de **flavors** (sabores) y, al mismo tiempo, mostrar una estructura básica con BLoC, repositorios, cliente HTTP e inyección de dependencias.

La aplicación consulta información de una raza de perro en [The Dog API](https://thedogapi.com/) y presenta el resultado en la pantalla principal. El flavor seleccionado determina el nombre de la aplicación, el identificador del paquete y el endpoint consultado.

## Funcionalidad

Al iniciar la aplicación:

1. Se detecta el flavor usado por Flutter (`dev` o `prod`).
2. Se inicializa Flutter dentro de una zona protegida para registrar errores no controlados.
3. Se configura `Dio` con un interceptor común y se registran las dependencias con `GetIt`.
4. Se crea `HomeBloc`, que solicita los datos de la raza configurada para el flavor.
5. `HomeView` muestra un indicador de carga, el error correspondiente o los datos recibidos: nombre, temperamento, origen, URL consultada e imagen.

La vista tiene una única ruta (`/`). En caso de error de red se muestra un mensaje de solicitud fallida; si la respuesta no puede convertirse al modelo de dominio, se muestra un mensaje de procesamiento de datos.

## Flavors

| Flavor | Nombre visible | Identificador Android | Bundle ID iOS | Endpoint |
| --- | --- | --- | --- | --- |
| `dev` | Dev App | `com.example.dev` | `com.example.dev` | `/v1/breeds/1` |
| `prod` | Prod App | `br.com.rafael.gerencia_estado_injecao_dependencia` | `br.com.rafael.gerencia_estado_injecao_dependencia` | `/v1/breeds/2` |

La URL base completa es `https://api.thedogapi.com`. Cada flavor tiene además sus propios recursos de icono en `assets/icon/dev` y `assets/icon/prod`. En Android esos recursos se generan dentro de `android/app/src/dev` y `android/app/src/prod`; en iOS se seleccionan mediante los esquemas y configuraciones de Xcode.

## Requisitos

- Flutter compatible con Dart `3.12.2` o superior.
- Android Studio y/o Xcode según la plataforma que se quiera ejecutar.
- Para iOS, macOS con Xcode. La configuración de iOS no puede compilarse desde Linux.
- Una clave válida de The Dog API.

Comprueba la instalación con:

```bash
flutter doctor
```

## Instalación

Desde la raíz del proyecto:

```bash
flutter pub get
```

Si se modifican los flavors o sus iconos, regenera la configuración nativa con:

```bash
dart run flutter_flavorizr
```

## Ejecución

Ejecutar el flavor de desarrollo:

```bash
flutter run --flavor dev
```

Ejecutar el flavor de producción:

```bash
flutter run --flavor prod
```

También se pueden generar builds específicos:

```bash
flutter build apk --flavor dev
flutter build apk --flavor prod
flutter build appbundle --flavor prod
flutter build ios --flavor dev
flutter build ios --flavor prod
```

En modo debug, el nombre del flavor puede comprobarse en el título de la pantalla y en la configuración generada. Android crea variantes como `devDebug`, `devRelease`, `prodDebug` y `prodRelease`.

## Configuración de iOS

El proyecto ya contiene los esquemas compartidos `dev` y `prod` en `ios/Runner.xcodeproj/xcshareddata/xcschemes`. Si se añaden flavors nuevos, es necesario crear un esquema compartido de Xcode con el mismo nombre y asociarle sus configuraciones `Debug`, `Profile` y `Release`.

La guía específica para resolver problemas de esquemas y configuraciones de iOS está en [solucion_error_flavor_ios.md](solucion_error_flavor_ios.md).

## Arquitectura

El flujo de datos está separado en capas:

```text
HomeView
	-> HomeBloc
		-> IBreedRepository
			-> IBreedRemoteDatasource
				-> AppClientDioImpl
					-> Dio -> The Dog API
```

- `lib/main.dart`: punto de entrada; asigna el flavor y llama a `bootstrap()`.
- `lib/flavors.dart`: enum y configuración central de nombre, endpoint y flavor actual.
- `lib/core/app_bootstrap.dart`: inicialización de Flutter, `Dio`, interceptor, dependencias y aplicación.
- `lib/core/app_injection.dart`: registro de `AppClient`, datasource, repositorio y `HomeBloc` con `GetIt`.
- `lib/core/app_routes.dart`: definición de rutas de la aplicación.
- `lib/core/app_widget.dart`: `MaterialApp` activo y registro de rutas.
- `lib/src/view/home/home_view.dart`: pantalla principal y representación de estados.
- `lib/src/blocs/home`: evento, estados y lógica de carga de la raza.
- `lib/src/data/breed`: modelo, datasource remoto y repositorio.
- `lib/src/shared/app_client`: abstracción HTTP, implementación con `Dio` e interceptor.
- `lib/src/shared/app_exceptions.dart`: excepciones de red, token y conversión.

`lib/app.dart` y `lib/pages/my_home_page.dart` contienen una pantalla de ejemplo anterior con saludo por flavor, pero no forman parte del flujo activo: la aplicación actual se inicia con `AppWidget` y `HomeView`.

## Dependencias principales

- [`flutter_bloc`](https://pub.dev/packages/flutter_bloc): gestión de estados de la pantalla principal.
- [`get_it`](https://pub.dev/packages/get_it): localizador e inyección de dependencias.
- [`dio`](https://pub.dev/packages/dio): cliente HTTP e interceptores.
- [`flutter_flavorizr`](https://pub.dev/packages/flutter_flavorizr): generación de la configuración nativa de flavors.

## Seguridad

El proyecto incluye actualmente una clave de The Dog API en el datasource y en el interceptor HTTP para facilitar el estudio. No debe usarse este valor en una aplicación publicada: revoca la clave expuesta y muévela a una configuración segura por entorno, sin subir secretos al repositorio.
