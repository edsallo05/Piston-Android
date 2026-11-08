# El Pistón — Gestión de taller automotriz

Aplicación móvil (Flutter) para llevar el trabajo diario de un taller mecánico de barrio.
Funciona **sin conexión** y **guarda los datos en el teléfono** usando [Drift](https://drift.simonbinder.eu/) (SQLite).

## Cómo ejecutarla

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # genera database.g.dart
flutter run
```

## Pantallas (las mínimas posibles)

| Pantalla | Para qué sirve |
|---|---|
| **Órdenes** (pestaña) | Lista de órdenes con filtros: Abiertas, Listas, Cerradas, Todas. Botón `+` para crear una. |
| **Nueva orden** | Se busca el vehículo por matrícula o cliente, se elige mecánico, kilometraje y problema reportado. |
| **Detalle de orden** | Cambiar estado, anotar trabajos (mano de obra), repuestos usados, ver total / pagado / pendiente y registrar pagos. |
| **Clientes** (pestaña) | Lista con buscador. Alta de clientes. |
| **Cliente** | Datos, saldo pendiente, vehículos (alta) e historial de servicios. |
| **Vehículo** | Historial de servicios de ese vehículo. |
| **Repuestos** (pestaña) | Inventario. Los que están por agotarse salen primero, en naranja, y la pestaña muestra un contador. |
| **Resumen** (pestaña) | Facturado y cobrado en un período, repuestos por agotarse, carga de cada mecánico y quién debe cuánto. |

## Arquitectura: MVVM

```
lib/
├── data/         Model: tablas de Drift (database.dart) y repositorio (workshop_repository.dart)
├── models/       Model: clases de apoyo (OrderOverview, UsedPart...) y extensiones
├── viewmodels/   ViewModel: lógica de cada pantalla, sin widgets
└── views/        View: pantallas y widgets; solo muestran datos y llaman al ViewModel
```

- La **View** nunca toca la base de datos: llama al **ViewModel**, y este al **repositorio**.
- Las listas usan `watch()` de Drift (streams), así la pantalla se actualiza sola cuando cambian los datos.
- Estado y navegación con `provider`.

## Base de datos (Drift)

`Clients` → `Vehicles` → `ServiceOrders` → (`OrderJobs`, `OrderParts`, `Payments`), más `Mechanics` y `Parts`.

## Decisiones de diseño

- **Estilo**: minimalista, inspirado en apps de tareas como *Things 3*: fondo gris muy claro, tarjetas blancas
  redondeadas, títulos grandes, un solo color de acento (azul) y color solo para lo que importa (estados, deudas, poco stock).
- **Navegación**: 4 pestañas abajo (lo que el dueño usa cada día) y pantallas de detalle solo cuando hacen falta.
- **Formularios**: diálogos cortos reutilizables para no crear una pantalla por cada alta.
- **Estados de la orden**: botón principal "Pasar a: …" para avanzar con un toque; el menú `⋮` permite saltar a cualquier estado (incluida *Cancelada*).
- **Mecánicos**: el taller tiene dos; se crean al iniciar ("Mecánico 1" y "Mecánico 2") y se renombran desde *Resumen*.
- **Precios congelados**: al usar un repuesto en una orden se copia su precio, para que cambiar el inventario no altere órdenes antiguas.
- **Existencias**: bajan al agregar el repuesto a una orden y suben si se quita. No se puede usar más de lo que hay.
- **Poco stock**: cada repuesto tiene su umbral de aviso (por defecto 3). Se avisa con contador en la pestaña, color naranja y sección en *Resumen*.
- **Pagos en partes**: se pueden registrar varios pagos; no se permite pagar más que el saldo.
- **Facturado**: suma de mano de obra + repuestos de las órdenes *no canceladas* cuya fecha de entrada cae en el período. *Cobrado* es lo ya pagado de esas mismas órdenes.
- **Órdenes cerradas** (entregadas o canceladas): no se pueden editar trabajos ni repuestos, pero sí registrar pagos pendientes de una entregada.
- **Kilometraje**: al crear la orden se actualiza el del vehículo.

## Capturas

Ver carpeta [`capturas/`](capturas/).
