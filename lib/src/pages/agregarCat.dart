import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:emporio/src/API/API.dart';
import 'package:flutter/material.dart';

class AgregarCategoria extends StatefulWidget {
  const AgregarCategoria({Key key}) : super(key: key);

  @override
  _AgregarCategoriaState createState() => _AgregarCategoriaState();
}

class _AgregarCategoriaState extends State<AgregarCategoria> {
  String nombre = '';
  String descripcion = '';
  String afiliado = '';
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar categoria'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: size / 20, right: size / 20),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        nombre = value;
                      });
                    },
                    decoration:
                        InputDecoration(labelText: 'Nombre de la categoria'),
                  ),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        descripcion = value;
                      });
                    },
                    decoration: InputDecoration(
                        labelText: 'Descripcion de la categoria'),
                  ),
                  FlatButton(
                      onPressed: () async {
                        try {
                          AlertDialog(
                            content: LinearProgressIndicator(),
                          );
                          await API.instance.categoria(nombre, descripcion,
                              'prueba/categorias/ensaladas.jpg', '1');
                          AwesomeDialog(
                              context: context,
                              animType: AnimType.BOTTOMSLIDE,
                              headerAnimationLoop: true,
                              dialogType: DialogType.SUCCES,
                              title: 'Listo',
                              btnOkText: 'Entendido',
                              dismissOnTouchOutside: true,
                              desc: 'Se ha guardado la categoria',
                              btnOkOnPress: () {
                                debugPrint('OnClcik');
                              },
                              btnOkIcon: Icons.check_circle,
                              onDissmissCallback: () {
                                debugPrint('Dialog Dissmiss from callback');
                              }).show();
                        } catch (e) {
                          AwesomeDialog(
                              context: context,
                              animType: AnimType.BOTTOMSLIDE,
                              headerAnimationLoop: true,
                              dialogType: DialogType.ERROR,
                              title: 'Error',
                              btnOkText: 'Entendido',
                              dismissOnTouchOutside: true,
                              desc: 'Hubo un error' + e.toString(),
                              btnOkOnPress: () {
                                debugPrint('OnClcik');
                              },
                              btnOkIcon: Icons.check_circle,
                              onDissmissCallback: () {
                                debugPrint('Dialog Dissmiss from callback');
                              }).show();
                        }
                      },
                      child: Text('Guardar categoria'))
                ],
              ))
        ],
      ),
    );
  }
}
