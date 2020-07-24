import 'dart:convert';

import 'package:ecommorce/utils/api.dart';
import 'package:html/parser.dart';

String _parseHtmlString(String htmlString) {
  try {
    var document = parse(htmlString);
    String parsedString = parse(document.body.text).documentElement.text;

    return parsedString;
  } catch (e) {
    return htmlString;
  }
}

class Product {
  final String id;
  final String name;
  final String category;
  final String image;
  final double price;
  final double saleprice;
  final double commission;
  final List<Productsize> productatt;
  int selectedquantity;
  double selectedcommission;
  Productsize selectedsize;
  final String desciption;

  Product(
      {this.commission = 10.0,
      this.id,
      this.name,
      this.category,
      this.price,
      this.image,
      this.desciption,
      this.productatt = const [],
      this.selectedsize,
      this.selectedquantity = 0,
      this.saleprice,
      this.selectedcommission = 10.0});

  factory Product.fromJson(Map<String, dynamic> json) {
    final List<Productsize> temp = [];
    Productsize selected = new Productsize();
    if (json['sizes'] != null)
      for (var i in json['sizes']) {
        if (i != null) {
          String sizeandcolor = i['size'] as String;
          int stock = i['stock'] as int;
          String size;
          String color;
          if (sizeandcolor.contains('-')) {
            List<String> tempsize = sizeandcolor.split('-');
            size = tempsize[0];
            color = tempsize[1];
          } else {
            size = sizeandcolor;
            color = '';
          }

          var a = Productsize(
            size: size,
            color: color,
            stock: stock,
          );
          temp.add(a);
          if (selected.stock == 0) if (stock > 0) {
            selected = a;
          }
        }
      }

    var c = jsonDecode(json['custom_properties'])['root'] as String;
    double tempcomission = double.parse(json['caption'] as String);

    //getSale
    var saleprice = json['sale_price'];
    double tempsale;
    if (saleprice != null)
      tempsale = double.parse(saleprice);
    else
      tempsale = 0;

    var productsizetemp = Productsize();
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      image: Network.domain +
          '/public/media/$c/' +
          (json['media_id'] as String) +
          '/' +
          (json['file_name'] as String),
      price: double.parse(json['regular_price'] as String),
      saleprice: tempsale,
      productatt: [productsizetemp], //temp,
      commission: tempcomission,
      selectedcommission: tempcomission,
      desciption: _parseHtmlString(json['description'] as String),
      selectedsize: productsizetemp,
    );
  }

  factory Product.clone(Product org) {
    return Product(
        category: org.category,
        desciption: org.desciption,
        id: org.id,
        image: org.image,
        name: org.name,
        price: org.price,
        productatt: org.productatt,
        selectedcommission: org.selectedcommission,
        selectedquantity: org.selectedquantity,
        selectedsize: org.selectedsize,
        commission: org.commission);
  }
}

class Productsize {
  final String size;
  final String color;
  final int stock;

  Productsize({
    this.color = 'Standart',
    this.size = 'Stokta Yok',
    this.stock = 0,
  });
}
