import 'package:emporio/src/pages/categorias.dart';
import 'package:emporio/src/pages/productos.dart';
import 'package:emporio/src/pages/resumen.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  static Router router = Router();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Emporio',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/cover.jpg'))),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              print('Navegar');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Resumen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.collections_bookmark),
            title: Text('Categorias'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CategoriasPage()),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.adb),
            title: Text('Productos'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Productos()),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Feedback'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}
