import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:emporio/src/API/API.dart';
import 'package:emporio/src/models/categoria.dart';
import 'package:flutter/material.dart';

class AgregarProducto extends StatefulWidget {
  AgregarProducto({Key key}) : super(key: key);

  @override
  _AgregarProductoState createState() => _AgregarProductoState();
}

class _AgregarProductoState extends State<AgregarProducto> {
  String nombre = '';
  String descripcion = '';
  String precio = '';
  String idCat = '';
  String cantidad = '';
  String afiliado = '';
  List<String> categorias = List<String>();
  List<Categoria> listArt = List();

  getCategorias() async {
    this.listArt = await API.instance.getCategorias();
    for (var i = 0; i < listArt.length; i++) {
      categorias.add(listArt[i].id.toString());
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategorias();
  }

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
                        InputDecoration(labelText: 'Nombre del producto'),
                  ),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        descripcion = value;
                      });
                    },
                    decoration:
                        InputDecoration(labelText: 'Descripcion del producto'),
                  ),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        cantidad = value;
                      });
                    },
                    decoration:
                        InputDecoration(labelText: 'Precio del producto'),
                  ),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        precio = value;
                      });
                    },
                    decoration:
                        InputDecoration(labelText: 'Cantidad del producto'),
                  ),
                  DropDownField(
                    onValueChanged: (dynamic value) {
                      setState(() {
                        idCat = value;
                      });
                    },
                    value: idCat,
                    required: true,
                    hintText: 'Id de la categoria',
                    items: categorias,
                  ),
                  FlatButton(
                      onPressed: () async {
                        try {
                          AlertDialog(
                            content: LinearProgressIndicator(),
                          );
                          await API.instance.producto(
                              nombre,
                              descripcion,
                              cantidad,
                              precio,
                              'prueba/categorias/ensaladas.jpg',
                              idCat,
                              '1');
                          AwesomeDialog(
                              context: context,
                              animType: AnimType.BOTTOMSLIDE,
                              headerAnimationLoop: true,
                              dialogType: DialogType.SUCCES,
                              title: 'Listo',
                              btnOkText: 'Entendido',
                              dismissOnTouchOutside: true,
                              desc: 'Se ha guardado el producto',
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
                      child: Text('Guardar producto'))
                ],
              ))
        ],
      ),
    );
  }
}
