import 'package:dio/dio.dart';
import 'package:emporio/models/articulos.dart';
import 'package:emporio/models/categoria.dart';
import 'package:emporio/models/pedido.dart';
import 'package:emporio/models/rutas.dart';
import 'package:emporio/models/usuario.dart';

class API {
  API._internal();
  final Dio _dio = Dio();
  static API _instance = API._internal();
  static API get instance => _instance;

  Future<User> crearUsuario() async {
    print('funcion API User');
    final Response response = await this._dio.get(
          'https://airintelligencems.com/api/users/1',
        );
    print(response);
    print(response.data);
    return User.fromJson(response.data[0]);
  }

  Future<List<Categoria>> getCategorias() async {
    print('funcion API getCategorias');
    final Response response = await this._dio.get(
          'https://airintelligencems.com/api/categories',
        );
    print(response);
    print(response.data);
    print(
        '---------------------------------------------antes jsonlist---------');
    final categorias = Categorias.fromJsonList(response.data);
    print('------------------------------------------');
    print(categorias.items[0].nombre);
    return categorias.items;
  }

  Future<List<Articulo>> getProductos() async {
    print('funcion API getProductos');
    final Response response = await this._dio.get(
          'https://airintelligencems.com/api/subcategories',
        );
    print(response);
    print(response.data);
    print(
        '---------------------------------------------antes jsonlist---------');
    final categorias = Articulos.fromJsonList(response.data);
    print('------------------------------------------');
    print(categorias.items[0].nombre);
    return categorias.items;
  }

  Future<List<Articulo>> buscarProductos(String producto) async {
    print('funcion API buscarProductos');
    final Response response = await this._dio.get(
          'https://airintelligencems.com/api/subcategories/id/$producto',
        );
    print(response);
    print(response.data);
    print(
        '---------------------------------------------antes jsonlist---------');
    final categorias = Articulos.fromJsonList(response.data);
    print('------------------------------------------');
    print(categorias.items[0].nombre);

    return categorias.items;
  }

  Future<List<Articulo>> buscarProducto(String query) async {
    print('funcion API Productos query');
    final Response response = await this._dio.get(
          'https://airintelligencems.com/api/subcategories/nombre/$query',
        );
    print(response);
    print(response.data);
    print(
        '---------------------------------------------antes jsonlist---------');
    final categorias = Articulos.fromJsonList(response.data);
    print('------------------------------------------');
    print(categorias.items[0].nombre);
    return categorias.items;
  }

  Future<Ruta> ruta(double reaprtidorLat, double reaprtidorLong, double destLat,
      double destLong) async {
    //20.598484, -100.347189
    //20.597778, -100.347870
    print('funcion API User');
    final Response response = await this._dio.get(
          'https://api.mapbox.com/directions/v5/mapbox/driving/$reaprtidorLong,$reaprtidorLat;$destLong,$destLat?geometries=geojson&access_token=pk.eyJ1IjoidG9vcmluZyIsImEiOiJja2RxNXdiZG0wY281MnBwYms4M2Vjc21lIn0.-wcfNaVRlISnUrNrDzZnHw',
        );
    print(response);
    print(response.data);
    return Ruta.fromJson(response.data);
  }

  Future<Pedido> pedido(
    String idCliente,
    String usuario,
    String productos,
    String direccion,
    String latitude,
    String longitude,
    String price,
    String horaFecha,
    String qr,
  ) async {
    print('funcion API pedido');
    final Response response =
        await this._dio.post('https://airintelligencems.com/api/orders', data: {
      "id_user": idCliente,
      "usuario": usuario,
      "direccion": direccion,
      "productos": productos,
      "lat_destino": latitude,
      "long_destino": longitude,
      "lat_repartidor": "20.5963",
      "long_repartido": "-100.3428",
      "fecha": horaFecha,
      "total": price,
      "codigo_qr": qr,
      "validado_qr": "false",
      "tipo_entrega": "Puerta",
      "id_afiliado": 1
    });
    print(response);
    print(response.data);

    final pedido = Pedido.fromJsonMap(response.data);
    return pedido;
  }

  Future<Pedido> getPedido(String id) async {
    print('funcion API Pedidos');
    final Response response = await this._dio.get(
          'https://airintelligencems.com/api/orders/$id',
        );
    print(response);
    print(response.data);
    print(
        '---------------------------------------------antes jsonlist---------');
    final categorias = Pedido.fromJsonMap(response.data[0]);
    print('------------------------------------------');
    print(categorias.idOrder);
    return categorias;
  }

  Future<Categoria> categoria(String nombre, String descripcion, String portada,
      String idAfiliado) async {
    print('funcion API pedido');
    final Response response = await this
        ._dio
        .post('https://airintelligencems.com/api/categories', data: {
      "nombre": nombre,
      "descripcion": descripcion,
      "portada": portada,
      "id_afiliado": idAfiliado
    });
    print(response);
    print(response.data);

    final cat = Categoria.fromJsonMap(response.data);
    return cat;
  }

  Future<Articulo> producto(String nombre, String descripcion, String cantidad,
      String precio, String portada, String idCat, String idAfiliado) async {
    print('funcion API pedido');
    final Response response = await this
        ._dio
        .post('https://airintelligencems.com/api/subcategories', data: {
      "nombre": nombre,
      "descripcion": descripcion,
      "cantidad": cantidad,
      "precio": precio,
      "portada": portada,
      "id_categoria": idCat,
      "id_afiliado": idAfiliado
    });
    print(response);
    print(response.data);

    final producto = Articulo.fromJsonMap(response.data);
    return producto;
  }

  Future actCategoria(String id, String nombre, String descripcion,
      String portada, String idAfiliado) async {
    print('funcion API pedido');
    final Response response = await this
        ._dio
        .put('https://airintelligencems.com/api/categories/$id', data: {
      "nombre": nombre,
      "descripcion": descripcion,
      "portada": portada,
      "id_afiliado": idAfiliado
    });
    print(response);
    print(response.data);

    return response;
  }
}
