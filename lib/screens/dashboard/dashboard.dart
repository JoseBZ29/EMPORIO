import 'package:emporio/models/categoria.dart';
import 'package:flutter/material.dart';
import 'package:emporio/models/github_model.dart';
import 'package:emporio/services/api_service.dart';

import 'package:emporio/utils/raw_data.dart';
import 'package:emporio/widgets/table_card.dart';
import 'package:emporio/widgets/ticket_cards.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool loading = false;
  @override
  void initState() {
    super.initState();
    getCategoria();
  }

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
    loading = true;
  }

  Widget tableCard(BuildContext context, List<Categoria> list) {
    return Card(
      elevation: 2.0,
      child: Column(children: [
        Container(
          width: MediaQuery.of(context).size.width < 1300
              ? MediaQuery.of(context).size.width - 100
              : MediaQuery.of(context).size.width - 330,
          padding: EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(width: 1, color: Colors.grey))),
          child: Table(
            columnWidths: <int, TableColumnWidth>{
              0: FixedColumnWidth((MediaQuery.of(context).size.width / 5)),
              1: FixedColumnWidth((MediaQuery.of(context).size.width / 5)),
              2: FixedColumnWidth((MediaQuery.of(context).size.width / 5)),
              3: FixedColumnWidth((MediaQuery.of(context).size.width / 5)),
            },
            children: [
              TableRow(decoration: BoxDecoration(), children: [
                Container(
                  padding: EdgeInsets.all(18),
                  child: Text(
                    "No.",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'HelveticaNeue',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(18),
                  child: Text(
                    "ID",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'HelveticaNeue',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(18),
                  child: Text(
                    "Nombre",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'HelveticaNeue',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(18),
                  child: Text(
                    "Descripcion",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'HelveticaNeue',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(18),
                  child: Text(
                    "Editar",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'HelveticaNeue',
                    ),
                  ),
                )
              ]),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width < 1300
              ? MediaQuery.of(context).size.width - 100
              : MediaQuery.of(context).size.width - 330,
          // padding: EdgeInsets.all(32),
          child: Table(
              columnWidths: <int, TableColumnWidth>{
                0: FixedColumnWidth((MediaQuery.of(context).size.width / 5)),
                1: FixedColumnWidth((MediaQuery.of(context).size.width / 5)),
                2: FixedColumnWidth((MediaQuery.of(context).size.width / 5)),
                3: FixedColumnWidth((MediaQuery.of(context).size.width / 5)),
              },
              children: List<TableRow>.generate(list.length, (i) {
                return TableRow(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(width: 0.5, color: Colors.grey))),
                    children: [
                      Container(
                        padding: EdgeInsets.all(18),
                        child: Text(
                          (i + 1).toString(),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontFamily: 'Raleway',
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(18),
                        child: Text(
                          list[i].id.toString(),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontFamily: 'HelveticaNeue',
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(18),
                        child: Text(
                          list[i].nombre.toString(),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontFamily: 'Raleway',
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(18),
                        child: Text(
                          list[i].descripcion.toString(),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontFamily: 'HelveticaNeue',
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(18),
                          child: FlatButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.edit),
                              label: Text('Editar')))
                    ]);
              })),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height);
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Center(
            child: loading
                ? tableCard(context, listArt)
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        ],
      ),
    );
  }
}
