import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart' as graphic;

import 'data.dart';

class Graphics extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                child: Text('Smooth Line and Area',
                    style: TextStyle(fontSize: 20)),
                padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
              ),
              Container(
                width: 350,
                height: 300,
                child: graphic.Chart(
                  data: lineData,
                  scales: {
                    'Date': graphic.CatScale(
                      accessor: (map) => map['Date'] as String,
                      range: [0, 1],
                      tickCount: 5,
                    ),
                    'Close': graphic.NumScale(
                      accessor: (map) => map['Close'] as num,
                      nice: true,
                      min: 100,
                    )
                  },
                  geoms: [
                    graphic.AreaGeom(
                      position: graphic.PositionAttr(field: 'Date*Close'),
                      shape: graphic.ShapeAttr(
                          values: [graphic.Shapes.smoothArea]),
                      color: graphic.ColorAttr(values: [
                        graphic.Defaults.theme.colors.first.withAlpha(80),
                      ]),
                    ),
                    graphic.LineGeom(
                      position: graphic.PositionAttr(field: 'Date*Close'),
                      shape: graphic.ShapeAttr(
                          values: [graphic.Shapes.smoothLine]),
                      size: graphic.SizeAttr(values: [0.5]),
                    ),
                  ],
                  axes: {
                    'Date': graphic.Defaults.horizontalAxis,
                    'Close': graphic.Defaults.verticalAxis,
                  },
                ),
              ),
              Padding(
                child: Text('Polar Coord Area Stack',
                    style: TextStyle(fontSize: 20)),
                padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
              ),
              Container(
                width: 350,
                height: 300,
                child: graphic.Chart(
                  data: adjustData,
                  scales: {
                    'index': graphic.CatScale(
                      accessor: (map) => map['index'].toString(),
                    ),
                    'type': graphic.CatScale(
                      accessor: (map) => map['type'] as String,
                    ),
                    'value': graphic.NumScale(
                      accessor: (map) => map['value'] as num,
                      nice: true,
                      max: 1800,
                    ),
                  },
                  coord: graphic.PolarCoord(),
                  geoms: [
                    graphic.AreaGeom(
                      position: graphic.PositionAttr(field: 'index*value'),
                      color: graphic.ColorAttr(field: 'type'),
                      adjust: graphic.StackAdjust(),
                    )
                  ],
                  axes: {
                    'index': graphic.Defaults.circularAxis,
                    'value': graphic.Defaults.radialAxis..label = null,
                  },
                ),
              ),
              Padding(
                child: Text('Radius Rect', style: TextStyle(fontSize: 20)),
                padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
              ),
              Container(
                width: 850,
                height: 500,
                child: graphic.Chart(
                  data: basicData,
                  scales: {
                    'genre': graphic.CatScale(
                      accessor: (map) => map['genre'] as String,
                    ),
                    'sold': graphic.NumScale(
                      accessor: (map) => map['sold'] as num,
                      nice: true,
                    )
                  },
                  geoms: [
                    graphic.IntervalGeom(
                      position: graphic.PositionAttr(field: 'genre*sold'),
                      shape: graphic.ShapeAttr(values: [
                        graphic.Shapes.rrectInterval(radius: Radius.circular(5))
                      ]),
                    )
                  ],
                  axes: {
                    'genre': graphic.Defaults.horizontalAxis,
                    'sold': graphic.Defaults.verticalAxis,
                  },
                ),
              ),
              Padding(
                child: Text('Dodge Adjust', style: TextStyle(fontSize: 20)),
                padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
              ),
              Container(
                width: 350,
                height: 300,
                child: graphic.Chart(
                  data: adjustData,
                  scales: {
                    'index': graphic.CatScale(
                      accessor: (map) => map['index'].toString(),
                    ),
                    'type': graphic.CatScale(
                      accessor: (map) => map['type'] as String,
                    ),
                    'value': graphic.NumScale(
                      accessor: (map) => map['value'] as num,
                      nice: true,
                    ),
                  },
                  geoms: [
                    graphic.IntervalGeom(
                      position: graphic.PositionAttr(field: 'index*value'),
                      color: graphic.ColorAttr(field: 'type'),
                      adjust: graphic.DodgeAdjust(),
                      size: graphic.SizeAttr(values: [4]),
                    )
                  ],
                  axes: {
                    'index': graphic.Defaults.horizontalAxis,
                    'value': graphic.Defaults.verticalAxis,
                  },
                ),
              ),
              Padding(
                child: Text('Stack Adjust', style: TextStyle(fontSize: 20)),
                padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
              ),
              Container(
                width: 350,
                height: 300,
                child: graphic.Chart(
                  data: adjustData,
                  scales: {
                    'index': graphic.CatScale(
                      accessor: (map) => map['index'].toString(),
                    ),
                    'type': graphic.CatScale(
                      accessor: (map) => map['type'] as String,
                    ),
                    'value': graphic.NumScale(
                      accessor: (map) => map['value'] as num,
                      max: 2000,
                    ),
                  },
                  geoms: [
                    graphic.IntervalGeom(
                      position: graphic.PositionAttr(field: 'index*value'),
                      color: graphic.ColorAttr(field: 'type'),
                      adjust: graphic.StackAdjust(),
                    )
                  ],
                  axes: {
                    'index': graphic.Defaults.horizontalAxis,
                    'value': graphic.Defaults.verticalAxis,
                  },
                ),
              ),
              Padding(
                child: Text('Polar Coord', style: TextStyle(fontSize: 20)),
                padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
              ),
              Container(
                width: 350,
                height: 300,
                child: graphic.Chart(
                  data: basicData,
                  scales: {
                    'genre': graphic.CatScale(
                      accessor: (map) => map['genre'] as String,
                    ),
                    'sold': graphic.NumScale(
                      accessor: (map) => map['sold'] as num,
                      nice: true,
                    )
                  },
                  coord: graphic.PolarCoord(),
                  geoms: [
                    graphic.IntervalGeom(
                      position: graphic.PositionAttr(field: 'genre*sold'),
                      color: graphic.ColorAttr(field: 'genre'),
                    )
                  ],
                  axes: {
                    'genre': graphic.Defaults.circularAxis,
                    'sold': graphic.Defaults.radialAxis..label = null,
                  },
                ),
              ),
              Padding(
                child: Text('Polar Coord Transposed',
                    style: TextStyle(fontSize: 20)),
                padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
              ),
              Container(
                width: 350,
                height: 300,
                child: graphic.Chart(
                  data: basicData,
                  scales: {
                    'genre': graphic.CatScale(
                      accessor: (map) => map['genre'] as String,
                    ),
                    'sold': graphic.NumScale(
                      accessor: (map) => map['sold'] as num,
                      nice: true,
                    )
                  },
                  coord: graphic.PolarCoord(transposed: true, innerRadius: 0.5),
                  geoms: [
                    graphic.IntervalGeom(
                      position: graphic.PositionAttr(field: 'genre*sold'),
                      color: graphic.ColorAttr(field: 'genre'),
                    )
                  ],
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.all(20),
                ),
              ),
              Padding(
                child:
                    Text('Polar Coord Stack', style: TextStyle(fontSize: 20)),
                padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
              ),
              Container(
                width: 350,
                height: 300,
                child: graphic.Chart(
                  data: adjustData,
                  scales: {
                    'index': graphic.CatScale(
                      accessor: (map) => map['index'].toString(),
                    ),
                    'type': graphic.CatScale(
                      accessor: (map) => map['type'] as String,
                    ),
                    'value': graphic.NumScale(
                      accessor: (map) => map['value'] as num,
                      max: 1800,
                      tickCount: 5,
                    ),
                  },
                  coord: graphic.PolarCoord(),
                  geoms: [
                    graphic.IntervalGeom(
                      position: graphic.PositionAttr(field: 'index*value'),
                      color: graphic.ColorAttr(field: 'type'),
                      adjust: graphic.StackAdjust(),
                    )
                  ],
                  axes: {
                    'index': graphic.Defaults.circularAxis..top = true,
                    'value': graphic.Defaults.radialAxis
                      ..grid = null
                      ..top = true
                      ..label.style =
                          TextStyle(color: Colors.white, fontSize: 10)
                      ..label.offset = Offset(-4, 0),
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
