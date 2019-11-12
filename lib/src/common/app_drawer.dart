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
            child: CircleAvatar(),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      available ? "DISPONIBLE" : "NO DISPONIBLE",
                      style: TextStyle(
                          color: available ? Colors.green : Colors.red,
                          fontSize: 18),
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
                DrawerListTile(
                  title: "Home",
                  onTap: () {},
                  activeRoute: "/",
                  icon: Icons.add,
                  route: "/",
                )
              ],
            ),
          )
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
            this.title,
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
        Divider(
          color: Colors.grey,
        )
      ],
    );
  }
}
