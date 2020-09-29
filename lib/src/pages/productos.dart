import 'package:emporio/src/API/API.dart';
import 'package:emporio/src/models/articulos.dart';
import 'package:emporio/src/pages/agregarPro.dart';
import 'package:flutter/material.dart';

class Productos extends StatefulWidget {
  Productos({Key key}) : super(key: key);

  @override
  _ProductosState createState() => _ProductosState();
}

class _ProductosState extends State<Productos> {
  List<Articulo> listPro = List();

  getProductos() async {
    this.listPro = await API.instance.getProductos();
    setState(() {});
    print(listPro.length);
    print(listPro[0].nombre);
    print(listPro);
  }

  @override
  void initState() {
    super.initState();
    getProductos();
  }

  Widget cat(Articulo art, int index) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width / 1.5,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    padding: EdgeInsets.only(right: 30),
                    child: Text(art.nombre)),
                Container(
                    padding: EdgeInsets.only(right: 30),
                    child: Text(art.descripcion)),
                Container(
                    padding: EdgeInsets.only(right: 30),
                    child: Text('\$' + art.precio)),
              ],
            ),
          ),
          Container(
            height: 150,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Image.network('https://airintelligencems.com/' + art.imagen),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Text('Lista de productos'),
            SizedBox(
              width: 30,
            ),
            FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AgregarProducto()),
                  );
                },
                child: Text('Agregar producto'))
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
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(width: 1.0, color: Colors.grey),
              )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: Text("Nombre"),
                  ),
                  Container(
                    child: Text("Descripción"),
                  ),
                  Container(
                    child: Text("Precio"),
                  ),
                  Container(
                    child: Text("Imaguen"),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RefreshIndicator(
                  onRefresh: () async {
                    getProductos();
                  },
                  child: listPro.length < 1
                      ? CircularProgressIndicator()
                      : ListView.builder(
                          itemCount: listPro.length,
                          itemBuilder: (BuildContext context, int index) {
                            return cat(listPro[index], index);
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
