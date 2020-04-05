# taxi

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Requisitos funcionales principales de DTaxi Chofer

X - Terminado
NP - No .probado
C - Haciendose

- [X] Autenticarse en el sistema, verificando que el rol del usuario sea DRIVER
- [X] Obtener las demandas PENDIENTES y listarlas (Almacenarlas en db local)
- [X] Pull to refresh en la pantalla de las demandas
- [X] Aceptar, Comenzar, Recoger cliente, Terminar demanda, Cancelar demanda aceptada
- [C] Permitir actualizar informacion del usuario autenticado (nombre, telefono, contraseña, foto de perfil)
- [C] Mostrar pagina de informacion de la app (about us)
- [C] Enviar localizacion del chofer en tiempo real (lat, lng) (No tiene que ser un Service, puede ser mientras la app este abierta)
- [X] Permitir cambiar el estado del chofer entre DISPONIBLE y NO_DISPONIBLE
    (DISPONIBLE Solo si se tienen las coordenadas actuales)
- [ ] Subscribirse a la subscripcion de mqtt del chofer, la cual notificara cualquier eventualidad
    - [ ] Reaccionar a cada una de las notificaciones, en todos los casos actualizar la demanda en la db local
        - NEW_DEMAND: Cuando crean una demanda en el area donde esta el chofer. Levantar la pantalla de demanda urgente 
            durante 30 segs para aceptar/declinar la demanda. En caso de aceptar, llamar al comenzarDemanda.
        - DEMAND_UPDATED: Cuando una demanda que ya tiene el chofer se actualiza. Levantar un dialogo indicando cual fue
            la actualizacion 
        - DEMAND_ASSIGNED: Cuando asignan una demanda al chofer, demanda que no se puede declinar. Levantar la pantalla de demanda urgente para aceptarla demanda. Cuando acepte, llamar al comenzarDemanda.
        - DEMAND_CANCELED: Cuando una demanda que ya tiene el chofer se cancela. Levantar un dialogo indicando que la demanda fue cancelada 
        - DEMAND_LOST_FOUND: Cuando le asignan un objeto perdido al chofer. Levantar un dialogo indicando que tiene un objeto perdido, brindando la opcion de ir a la pantalla de objetos perdidos
- [ ] Enviar informacion de coordenadas de las demandas a las aplicaciones de mapas (Maps.Me y Osmand). En caso de que no la tenga instalada mostrar 
    un dialogo indicando que debe instalarsela
- [C] Cuando comienza una demanda poner automaticamente a NO_DISPONIBLE
- [C] Cuando termina una demanda poner automaticamente a DISPONIBLE
- [ ] Permitir en las demandas que esten en ACCEPTED, IN_COURSE y STARTED chatear con el cliente, a traves de mqtt
- [ ] Mandar una traza a la api cada vez que:
    - [C] Cambia de estado
    - [X] acepta, cancela, comienza y termina una demandas
    - [C] se actualiza cualquier dato del usuario
- [ ] Cuando levante la app, consultar si hay una actualizacion de apk; en caso de existir, indicar mediante un dialogo y mandar a descargarla
- [ ] Permitir Cerrar sesion

# Otros requisitos que surgieron
- [X] Tratamiento de errores en la autenticación
- [X] Guardar los datos de la información del usuario en la autenticación
- [X] Cargar las ultimas demandas obtenidas cuando se esta offline


