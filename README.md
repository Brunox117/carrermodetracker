# ⚽ Career Mode Tracker

**Tu compañero definitivo para dominar el modo carrera de FIFA**

Una aplicación móvil desarrollada en Flutter que te permite rastrear y analizar todas las estadísticas de tu modo carrera en FIFA, desde el rendimiento de jugadores hasta el progreso de torneos.

## 🚀 Características Principales

### 📊 Estadísticas Detalladas
- **Registro completo de estadísticas**: Goles, asistencias, partidos jugados, tarjetas, porterías a cero
- **Análisis de rendimiento**: Promedio de calificación por jugador
- **Seguimiento por temporada**: Estadísticas organizadas por temporadas
- **Estadísticas de torneos**: Rendimiento específico en diferentes competiciones

### 👥 Gestión de Jugadores
- **Perfiles individuales**: Información completa de cada jugador
- **Posiciones y números**: Organización por posición y dorsal
- **Fotos personalizadas**: Imágenes de jugadores con `image_picker`
- **Estadísticas individuales**: Seguimiento detallado del rendimiento

### 🏆 Seguimiento de Torneos
- **Múltiples competiciones**: Liga, copas, competiciones internacionales
- **Estadísticas específicas**: Rendimiento diferenciado por torneo
- **Progreso detallado**: Seguimiento completo de cada competición

### 🎯 Gestión de Equipos
- **Múltiples equipos**: Administra varios equipos simultáneamente
- **Logos personalizados**: Imágenes de equipos con acrónimos
- **Plantillas completas**: Gestión integral de jugadores por equipo

### 👨‍💼 Estadísticas de Manager
- **Rendimiento general**: Partidos jugados, victorias, derrotas, empates
- **Análisis ofensivo/defensivo**: Goles a favor y en contra
- **Estadísticas por temporada**: Evolución del rendimiento
- **Estadísticas por torneo**: Rendimiento específico en competiciones

## 🛠️ Tecnologías Utilizadas

- **Flutter 3.5.2+**: Framework principal de desarrollo
- **Riverpod**: Gestión de estado reactiva
- **Isar**: Base de datos local NoSQL
- **Go Router**: Navegación declarativa
- **Google Mobile Ads**: Monetización con anuncios
- **Shared Preferences**: Almacenamiento de configuraciones
- **Image Picker**: Selección de imágenes
- **Flutter Localizations**: Soporte multiidioma (ES/EN)

## 📱 Capturas de Pantalla

La aplicación incluye:
- **Pantalla de bienvenida** con onboarding interactivo
- **Vista principal** con grid de equipos
- **Gestión de jugadores** con estadísticas detalladas
- **Seguimiento de torneos** y temporadas
- **Estadísticas de manager** con análisis completo

## 🚀 Instalación y Configuración

### Prerrequisitos
- Flutter SDK 3.5.2 o superior
- Dart SDK
- Android Studio / Xcode (para desarrollo móvil)

### Pasos de instalación

1. **Clona el repositorio**
   ```bash
   git clone https://github.com/tu-usuario/carrermodetracker.git
   cd carrermodetracker
   ```

2. **Instala las dependencias**
   ```bash
   flutter pub get
   ```

3. **Genera los archivos de Isar**
   ```bash
   flutter packages pub run build_runner build
   ```

4. **Ejecuta la aplicación**
   ```bash
   flutter run
   ```

## 📁 Estructura del Proyecto

```
lib/
├── config/                 # Configuración de la app
│   ├── helpers/           # Utilidades y helpers
│   ├── router/            # Configuración de rutas
│   └── theme/             # Temas y estilos
├── domain/                # Capa de dominio (Clean Architecture)
│   ├── datasources/       # Interfaces de fuentes de datos
│   ├── entities/          # Modelos de datos
│   ├── enums/             # Enumeraciones
│   └── repositories/      # Interfaces de repositorios
├── infrastructure/        # Capa de infraestructura
│   ├── datasources/       # Implementaciones de fuentes de datos
│   └── repositories/      # Implementaciones de repositorios
├── presentation/          # Capa de presentación
│   ├── providers/         # Providers de Riverpod
│   ├── screens/           # Pantallas principales
│   ├── views/             # Vistas específicas
│   └── widgets/           # Widgets reutilizables
├── plugins/               # Plugins personalizados
└── l10n/                  # Archivos de localización
```

## 🎮 Cómo Usar la Aplicación

1. **Primera vez**: Completa el onboarding para conocer las características
2. **Crear equipo**: Añade tu primer equipo con logo y acrónimo
3. **Agregar jugadores**: Registra los jugadores de tu plantilla
4. **Iniciar temporada**: Crea una nueva temporada para comenzar
5. **Registrar estadísticas**: Añade estadísticas después de cada partido
6. **Crear torneos**: Organiza diferentes competiciones
7. **Analizar rendimiento**: Revisa estadísticas detalladas

## 🔧 Configuración de Anuncios

La aplicación incluye integración con Google Mobile Ads. Para configurar:

1. Obtén tu App ID de AdMob
2. Configura los IDs de anuncios en `lib/plugins/admob_plugin.dart`
3. Añade los IDs en los archivos de configuración de Android/iOS

## 🌐 Localización

La aplicación soporta múltiples idiomas:
- **Español** (predeterminado)
- **Inglés**

Los archivos de localización se encuentran en `lib/l10n/`.

## 📊 Base de Datos

La aplicación utiliza **Isar** como base de datos local, que permite:
- Almacenamiento rápido y eficiente
- Consultas complejas
- Relaciones entre entidades
- Sincronización automática

### Entidades principales:
- `Team`: Equipos
- `Player`: Jugadores
- `Manager`: Managers
- `Season`: Temporadas
- `Tournament`: Torneos
- `Stats`: Estadísticas de jugadores
- `Managerstat`: Estadísticas de manager
- `ManagerTournamentStat`: Estadísticas de manager por torneo

## 🤝 Contribuir

¡Las contribuciones son bienvenidas! Para contribuir:

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📝 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo `LICENSE` para más detalles.

## 👨‍💻 Autor

**Bruno Jiménez Mancilla**
- GitHub: [@tu-usuario](https://github.com/tu-usuario)

## 🙏 Agradecimientos

- Flutter team por el increíble framework
- Comunidad de Isar por la excelente base de datos
- Riverpod por la gestión de estado reactiva
- Todos los contribuidores del proyecto

---

**¡Disfruta rastreando tu modo carrera de FIFA! ⚽🏆**

