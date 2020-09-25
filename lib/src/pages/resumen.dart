import 'package:emporio/src/API/API.dart';
import 'package:emporio/src/models/articulos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Resumen extends StatefulWidget {
  const Resumen({Key key}) : super(key: key);

  @override
  _ResumenState createState() => _ResumenState();
}

class _ResumenState extends State<Resumen> {
  ScrollController _scrollController = ScrollController();

  List<Articulo> listArt = List();

  getArticulos() async {
    this.listArt = await API.instance.getProductos();
    setState(() {});
    print(listArt.length);
    print(listArt[0].nombre);
    print(listArt);
  }

  @override
  void initState() {
    super.initState();
    getArticulos();
  }

  Widget cat(Articulo art, int index) {
    return Text(art.nombre);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ListView.builder(
          itemCount: listArt.length,
          itemBuilder: (BuildContext context, int index) {
            return cat(listArt[index], index);
          },
        ),
      ),
    );
  }
}
