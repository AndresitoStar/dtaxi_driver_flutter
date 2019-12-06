import 'package:dtaxi_driver/src/bloc/authentication/index.dart';
import 'package:dtaxi_driver/src/bloc/demands/index.dart';
import 'package:dtaxi_driver/src/ui/homepage.dart';
import 'package:dtaxi_driver/src/ui/lost_and_found.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  var available = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all()),
                  child: CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.grey,
                  ),
                ),
                Text(
                  "JIMMY EL META",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Divider(
              color: Colors.grey,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                available ? "DISPONIBLE" : "NO DISPONIBLE",
                style: TextStyle(
                    color: available ? Colors.green : Colors.red, fontSize: 18),
              ),
              Switch.adaptive(
                  value: available,
                  onChanged: (value) {
                    setState(() {
                      available = value;
                    });
                  })
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Divider(
              color: Colors.grey,
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                DrawerListTile(
                  title: "BANDEJA DE ENTRADA",
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Homepage(
                              title: "Bandeja de entrada",
                              tab: HomepageTab.INBOX,
                            )));
                  },
                  activeRoute: "/",
                  icon: Icons.inbox,
                  route: "/",
                ),
                DrawerListTile(
                  title: "BANDEJA DE ENTRADA SNOW",
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DemandsScreen(
                              demandsBloc: DemandsBloc(),
                            )));
                  },
                  activeRoute: "/",
                  icon: Icons.inbox,
                  route: "/",
                ),
                DrawerListTile(
                  title: "OBJETOS PERDIDOS",
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LostAndFound()));
                  },
                  activeRoute: "/",
                  icon: Icons.rv_hookup,
                  route: "/",
                ),
                DrawerListTile(
                  title: "AJUSTES",
                  onTap: () {},
                  activeRoute: "/",
                  icon: Icons.settings,
                  route: "/",
                ),
                DrawerListTile(
                  title: "CAMBIAR SESIÓN",
                  onTap: () => AuthenticationBloc()
                      .dispatch(LogoutAuthenticationEvent()),
                  activeRoute: "/",
                  icon: Icons.cancel,
                  route: "/",
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Divider(
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
            child: Text(
              "Desarrollado por Pyxel Solutions.",
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerLeadingIcon extends StatelessWidget {
  final icon;
  final activeRoute;
  final route;
  final color;

  const DrawerLeadingIcon(
      {Key key, @required this.icon, this.activeRoute, this.route, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Icon(
        this.icon,
        size: 30,
        color: this.color ?? Theme.of(context).accentColor,
      ),
    );
  }
}

_navigationDrawerTap(context, activeRoute, route) {
  activeRoute == route
      ? Navigator.pop(context)
      : Navigator.pushReplacementNamed(context, route);
}

class DrawerListTile extends StatelessWidget {
  final IconData icon;
  final String activeRoute;
  final String route;
  final String title;
  final VoidCallback onTap;

  const DrawerListTile(
      {Key key,
      this.icon,
      this.activeRoute,
      this.route,
      this.title,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: DrawerLeadingIcon(
            icon: this.icon,
            activeRoute: this.activeRoute,
            route: "/",
            color: this.activeRoute == this.route
                ? Theme.of(context).primaryColorDark
                : Theme.of(context).primaryColor,
          ),
          title: Text(
            this.title.toUpperCase(),
            style: this.activeRoute == this.route
                ? TextStyle(
                    color: Theme.of(context).primaryColorDark, fontSize: 18)
                : TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 18),
          ),
          selected: this.activeRoute == this.route,
          onTap: onTap ??
              () => _navigationDrawerTap(
                    context,
                    this.activeRoute,
                    this.route,
                  ),
        ),
      ],
    );
  }
}
