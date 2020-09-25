class Ruta {
  List<dynamic> lista;
  Ruta({this.lista});

  static Ruta fromJson(Map<String, dynamic> json) {
    final section = Map<String, dynamic>.from(json['routes'][0]);
    return Ruta(lista: section['geometry']['coordinates']);
  }
}
