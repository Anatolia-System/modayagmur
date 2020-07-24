import 'dart:convert';

import 'package:ecommorce/model/category.dart';
import 'package:ecommorce/model/product.dart';
import 'package:ecommorce/themes/light_color.dart';
import 'package:ecommorce/themes/theme.dart';
import 'package:ecommorce/utils/api.dart';
import 'package:ecommorce/widgets/product_card.dart';
import 'package:ecommorce/widgets/product_icon.dart';
import 'package:ecommorce/widgets/title_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommorce/widgets/extentions.dart';

import 'package:http/http.dart' as http;

List<Product> productlist;
int selectedcategoryid;
Future<List<Product>> fetch;

Future<List<Product>> fetchproducts(String id, [bool search = false]) async {
  var a;
  productlist.clear();

  if (search) {
    a = await http
        .post(Network.domain + MyConstants.search, body: {"name": id});
  } else {
    a = await http
        .post(Network.domain + MyConstants.products, body: {"id": id});
  }

  var myjson = jsonDecode(a.body);
  // print(myjson[0]['custom_properties'].toString());
  // print(jsonDecode(myjson[0]['custom_properties'])['root'].toString());
  return myjson.map<Product>((json) => Product.fromJson(json)).toList();

  // String response = await rootBundle.loadString('testjson/$id.json');
  // final parsed = json.decode(response);
  // print('katagori resimleri başarıyla çekildi.');

  // return parsed['products']
  //     .map<Product>((json) => Product.fromJson(json))
  //     .toList();
}

class MyHomePage extends StatefulWidget {
  final List<Category> categories;
  MyHomePage({Key key, this.categories}) : super(key: key);

  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController scroll;

  @override
  initState() {
    productlist = [];
    selectedcategoryid = widget.categories[0].id;
    fetch = fetchproducts(selectedcategoryid.toString());
    scroll = ScrollController();
    super.initState();
  }

  Widget _icon(IconData icon, {Color color = LightColor.iconColor}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(13)),
          color: Theme.of(context).backgroundColor,
          boxShadow: AppTheme.shadow),
      child: Icon(
        icon,
        color: color,
      ),
    ).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(13)));
  }

  void _changeCatagory(int id) {
    setState(() {
      if (scroll.hasClients) scroll.position.jumpTo(0);
      selectedcategoryid = id;
      fetch = fetchproducts(selectedcategoryid.toString());
      FocusScope.of(context).unfocus();
    });
  }

  Widget _categoryWidget() {
    return Container(
      height: 45,
      width: AppTheme.fullWidth(context),
      child: ListView.builder(
        padding: AppTheme.hPadding,
        scrollDirection: Axis.horizontal,
        itemCount: widget.categories.length,
        itemBuilder: (context, index) {
          return ProductIcon(
            model: widget.categories[index],
            isSelected: selectedcategoryid == widget.categories[index].id,
            onSelected: (value) {
              _changeCatagory(value.id);
            },
          );
        },
      ),
    );
  }

  Widget _productWidget() {
    return FutureBuilder<List<Product>>(
        future: fetch,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.waiting) {
            if (snapshot.hasData) {
              return MyGrid(
                scroll: scroll,
                data: snapshot.data,
              );
            } else
              return Center(child: CupertinoActivityIndicator());
          } else
            return Center(child: CupertinoActivityIndicator());
        });
  }

  Widget _search() {
    return Container(
      padding: AppTheme.hPadding,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: LightColor.lightGrey.withAlpha(100),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: TextField(
                onChanged: (value) {
                  if (value.length > 2) {
                    setState(() {
                      selectedcategoryid = -1;
                      fetch = fetchproducts(value, true);
                    });
                  } else if (value.length == 0) {
                    _changeCatagory(widget.categories[0].id);
                  }
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Ürünleri Ara",
                    hintStyle: TextStyle(fontSize: 12),
                    contentPadding:
                        EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
                    prefixIcon: Icon(Icons.search, color: Colors.black54)),
              ),
            ),
          ),
          _icon(Icons.filter_list, color: Colors.black54)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        _search(),
        _categoryWidget(),
        Expanded(child: _productWidget()),
      ],
    );
  }
}

class MyGrid extends StatelessWidget {
  const MyGrid({
    Key key,
    this.data,
    this.scroll,
  }) : super(key: key);

  final ScrollController scroll;
  final List<Product> data;

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    if (data.isNotEmpty)
      return GridView.builder(
          controller: scroll,
          // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //   crossAxisCount: 2,
          //   crossAxisSpacing: 15,
          //   //childAspectRatio: .54,
          // ),
          padding: EdgeInsets.symmetric(horizontal: 10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
              crossAxisSpacing: 10,
              childAspectRatio: .54),
          itemCount: data.length,
          addAutomaticKeepAlives: true,
          itemBuilder: (context, index) => ProductCard(
                product: data[index],
                onSelected: (model) {},
              ));
    else
      return Center(
        child: TitleText(
          text: 'Ürün Yok',
        ),
      );
  }
}
