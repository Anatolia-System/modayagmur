import 'package:ecommorce/model/cargofirm.dart';
import 'package:ecommorce/model/product.dart';

class Order {
  String name, surname, phone, city, town, address;
  CargoFirm cargoFirm;
  Paymenttype paymenttype;
  List<Product> orderlist;

  Order(
      {this.name,
      this.surname,
      this.phone,
      this.city,
      this.town,
      this.address,
      this.orderlist});
}
