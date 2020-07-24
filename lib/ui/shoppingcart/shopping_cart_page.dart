import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommorce/model/cartbloc.dart';
import 'package:ecommorce/model/product.dart';
import 'package:ecommorce/themes/light_color.dart';
import 'package:ecommorce/themes/theme.dart';
import 'package:ecommorce/ui/order/order.dart';
import 'package:ecommorce/widgets/title_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({Key key}) : super(key: key);

  Widget _cartItems(List<Product> cartList) {
    return ListView.builder(
      itemCount: cartList.length,
      itemBuilder: (context, index) => Item(model: cartList[index]),
      scrollDirection: Axis.vertical,
    );
  }

  Widget _price() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TitleText(
          text:
              '${bloc.cartlist.fold<int>(0, (previousValue, element) => previousValue + element.selectedquantity).toString()} Ürün',
          color: LightColor.grey,
          fontWeight: FontWeight.w500,
        ),
        TitleText(
          text: '₺${getPrice()}',
        ),
      ],
    );
  }

  Widget _submitButton(BuildContext context) {
    return FlatButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrderPage(products: bloc.cartlist),
              ));
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: LightColor.orange,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 12),
          width: AppTheme.fullWidth(context) * .7,
          child: TitleText(
            text: 'Siparişi Ver',
            color: LightColor.background,
            fontWeight: FontWeight.w500,
          ),
        ));
  }

  double getPrice() {
    double price = 0;
    bloc.cartlist.forEach((x) {
      price +=
          (x.price + x.selectedcommission - x.commission) * x.selectedquantity;
    });
    return price;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.getStream,
      initialData: bloc.cartlist,
      builder: (context, snapshot) {
        return snapshot.data.length > 0
            ? Container(
                padding: AppTheme.padding,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(child: _cartItems(snapshot.data)), //_cartItems()),
                    Column(
                      children: <Widget>[
                        _price(),
                        SizedBox(height: 5),
                        _submitButton(context),
                      ],
                    ),
                  ],
                ),
              )
            : Center(child: Text('Sepetiniz Boş'));
      },
    );
  }
}

class Item extends StatefulWidget {
  final Product model;

  const Item({Key key, this.model}) : super(key: key);

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        bloc.removeFromCart(widget.model);
      },
      child: Row(
        children: <Widget>[
          Expanded(
            child: ListTile(
              contentPadding: EdgeInsets.all(5),
              isThreeLine: true,
              leading: CachedNetworkImage(
                imageUrl: widget.model.image,
                placeholder: (context, url) => CupertinoActivityIndicator(),
              ),
              title: TitleText(
                text: widget.model.name,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
              subtitle: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      TitleText(
                        text: widget.model.price.toString(),
                      ),
                      TitleText(
                        text: '\₺ ',
                        color: LightColor.red,
                        fontSize: 15,
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Komisyon ' +
                          widget.model.selectedcommission.toString() +
                          '₺',
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Beden:' + widget.model.selectedsize.size,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  bloc.addToCart(widget.model);
                },
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Icon(Icons.arrow_drop_up),
                ),
              ),
              Container(
                width: 35,
                height: 35,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: LightColor.lightGrey.withAlpha(150),
                    borderRadius: BorderRadius.circular(10)),
                child: TitleText(
                  text: widget.model.selectedquantity.toString(),
                  fontSize: 12,
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (widget.model.selectedquantity == 1)
                    bloc.removeFromCart(widget.model);
                  else
                    bloc.removeQuantFromCart(widget.model);
                },
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Icon(Icons.arrow_drop_down),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
