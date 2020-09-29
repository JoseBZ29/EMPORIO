import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:emporio/src/models/categoria.dart';
import 'package:emporio/src/pages/agregarCat.dart';
import 'package:emporio/src/pages/editarCat.dart';
import 'package:flutter/material.dart';

import 'package:emporio/src/API/API.dart';
import 'package:flutter/cupertino.dart';
import 'package:universal_html/prefer_universal/html.dart' as html;
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:emporio/src/globals.dart' as globals;

class CategoriasPage extends StatefulWidget {
  const CategoriasPage({Key key}) : super(key: key);

  @override
  _CategoriasPageState createState() => _CategoriasPageState();
}

class _CategoriasPageState extends State<CategoriasPage> {
  ScrollController _scrollController = ScrollController();

  List<Categoria> listArt = List();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  String uploadURL;

  getCategoria() async {
    this.listArt = await API.instance.getCategorias();
    setState(() {});
    print(listArt.length);
    print(listArt[0].nombre);
    print(listArt);
  }

  @override
  void initState() {
    super.initState();
    getCategoria();
  }

  Widget cat(Categoria cat, int index, BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 50),
        child: Row(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width / 2.3,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Text(cat.nombre)),
                  ),
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          cat.descripcion,
                        )),
                  ),
                ],
              ),
            ),
            Container(
              height: 150,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child:
                  Image.network('https://airintelligencems.com/' + cat.imagen),
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 50),
                child: FlatButton(
                    onPressed: () {
                      setState(() {
                        globals.cat = cat;
                      });
                      print(globals.cat.id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditarCategoria()),
                      );
                    },
                    child: Icon(Icons.edit, color: Colors.blue)))
          ],
        ));
  }

  String name = '';
  String error;
  Uint8List data;

  pickImage() {
    final html.InputElement input = html.document.createElement('input');
    input
      ..type = 'file'
      ..accept = 'image/*';

    input.onChange.listen((e) {
      if (input.files.isEmpty) return;
      final reader = html.FileReader();
      reader.readAsDataUrl(input.files[0]);
      reader.onError.listen((err) => setState(() {
            error = err.toString();
          }));
      reader.onLoad.first.then((res) {
        final encoded = reader.result as String;
        // remove data:image/*;base64 preambule
        final stripped =
            encoded.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '');

        setState(() {
          name = input.files[0].name;
          data = base64.decode(stripped);
          error = null;
        });
      });
    });

    input.click();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Text('Lista de categorias'),
            SizedBox(
              width: 30,
            ),
            FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AgregarCategoria()),
                  );
                },
                child: Text('Agregar categoria'))
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 60),
        padding: EdgeInsets.only(top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: EdgeInsets.symmetric(horizontal: 50),
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(width: 1.0, color: Colors.grey),
                )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 30),
                      child: Text("Nombre"),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 30),
                      child: Text("Descripción"),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 30),
                      child: Text("Imaguen"),
                    ),
                    Container(
                      child: Text(""),
                    ),
                  ],
                )),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: RefreshIndicator(
                onRefresh: () async {
                  getCategoria();
                },
                child: listArt.length < 1
                    ? CircularProgressIndicator()
                    : ListView.builder(
                        itemCount: listArt.length,
                        itemBuilder: (BuildContext context, int index) {
                          return cat(listArt[index], index, context);
                        },
                      ),
                // FlatButton(
                //   child: Icon(Icons.open_in_browser),
                //   onPressed: () {
                //     pickImage();
                //   },
                // ),
                // error != null
                //     ? Text(error)
                //     : data != null ? Image.memory(data) : Text('No data...'),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
