class Articulos {
  List<Articulo> items = new List();
  Articulos();
  Articulos.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final producto = new Articulo.fromJsonMap(item);
      items.add(producto);
    }
  }
}

class Articulo {
  int id;
  String nombre;
  String precio;
  String imagen;
  String descripcion;
  Articulo(this.id, this.nombre, this.precio, this.imagen, this.descripcion);

  Articulo.fromJsonMap(Map<String, dynamic> json) {
    id = json['id_producto'];
    nombre = json['nombre'];
    precio = json['precio'];
    imagen = json['portada'];
    descripcion = json['descripcion'];
  }
}
