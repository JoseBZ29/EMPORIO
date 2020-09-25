class Categorias {
  List<Categoria> items = new List();
  Categorias();
  Categorias.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final producto = new Categoria.fromJsonMap(item);
      items.add(producto);
    }
  }
}

class Categoria {
  String nombre;
  String imagen;
  int id;
  String descripcion;
  Categoria(this.id, this.nombre, this.imagen, this.descripcion);

  Categoria.fromJsonMap(Map<String, dynamic> json) {
    id = json['id_categoria'];
    nombre = json['nombre'];
    imagen = json['portada'];
    descripcion = json['descripcion'];
  }
}
