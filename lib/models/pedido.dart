class Pedido {
  int idOrder;
  String dateTime;
  double latitude;
  double longitude;
  double latitudeRepartidor;
  double longitudeRepartidor;
  int idDealers;
  double price;
  String idCliente;
  String direccion;
  String productos;
  String qr;
  String validado;

  Pedido.fromJsonMap(Map<String, dynamic> json) {
    idOrder = json['id_pedido'];
    idCliente = json['id_user'].toString();
    direccion = json['direccion'];
    productos = json['productos'];
    latitude = double.parse(json['lat_destino']);
    longitudeRepartidor = double.parse(json['long_repartido']);
    latitudeRepartidor = double.parse(json['lat_repartidor']);
    longitude = double.parse(json['long_destino']);
    dateTime = json['fecha'];
    price = double.parse(json['total']);
    qr = json['codigo_qr'];
    validado = json['validado_qr'];
  }
}
