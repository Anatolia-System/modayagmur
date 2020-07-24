import 'package:ecommorce/model/product.dart';
import 'package:ecommorce/ui/productdetail/product_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommorce/themes/light_color.dart';
import 'package:ecommorce/widgets/title_text.dart';

// // class ProductCard extends StatelessWidget {
// //   final Product product;
// //   final ValueChanged<Product> onSelected;
// //   ProductCard({Key key, this.product, this.onSelected}) : super(key: key);

// // //   @override
// // //   _ProductCardState createState() => _ProductCardState();
// // // }

// // // class _ProductCardState extends State<ProductCard> {
// // //   Product product;
// // //   @override
// // //   void initState() {
// // //     product = widget.product;
// // //     super.initState();
// // //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       decoration: BoxDecoration(
// //         color: LightColor.background,
// //         borderRadius: BorderRadius.all(Radius.circular(20)),
// //         boxShadow: <BoxShadow>[
// //           BoxShadow(color: Color(0xfff8f8f8), blurRadius: 15, spreadRadius: 10),
// //         ],
// //       ),
// //       margin: EdgeInsets.symmetric(vertical: !product.isSelected ? 20 : 0),
// //       child: Container(
// //         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
// //         child: Stack(
// //           alignment: Alignment.center,
// //           children: <Widget>[
// //             Column(
// //               crossAxisAlignment: CrossAxisAlignment.center,
// //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //               children: <Widget>[
// //                 SizedBox(height: product.isSelected ? 15 : 0),
// //                 Stack(
// //                   alignment: Alignment.center,
// //                   children: <Widget>[
// //                     CircleAvatar(
// //                       radius: 40,
// //                       backgroundColor: LightColor.orange.withAlpha(40),
// //                     ),
// //                     Image.asset(product.image)
// //                   ],
// //                 ),
// //                 // SizedBox(height: 5),
// //                 TitleText(
// //                   text: product.name,
// //                   fontSize: product.isSelected ? 16 : 14,
// //                 ),

// //                 TitleText(
// //                   text: product.price.toString(),
// //                   fontSize: product.isSelected ? 18 : 16,
// //                 ),
// //               ],
// //             ),
// //           ],
// //         ),
// //       ).ripple(() {
// //         Navigator.of(context).pushNamed('/detail');
// //         onSelected(product);
// //       }, borderRadius: BorderRadius.all(Radius.circular(20))),
// //     );
// //   }
// // }

// class ProductCard extends StatefulWidget {
//   final Product product;
//   final ValueChanged<Product> onSelected;
//   ProductCard({Key key, this.product, this.onSelected}) : super(key: key);

//   @override
//   _ProductCardState createState() => _ProductCardState();
// }

// class _ProductCardState extends State<ProductCard> {
//   @override
//   Widget build(BuildContext context) {
//     final List<Text> options = [];

//     widget.product.productatt.forEach((element) {
//       options.add(Text(element.size + ' Stok:' + element.stock.toString()));
//     });

//     return Container(
//       width: MediaQuery.of(context).size.width,
//       child: Column(
//         children: <Widget>[
//           GestureDetector(
//             onTap: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => ProductDetailPage(
//                           product: widget.product,
//                         ))),
//             child: Image.network(
//               widget.product.image,
//               fit: BoxFit.fitWidth,
//             ),
//           ),
//           Expanded(flex: 1, child: Text(widget.product.name)),
//           // Expanded(
//           //   flex: 1,
//           //   child: GestureDetector(
//           //     onTap: () {
//           //       showModalBottomSheet(
//           //           context: context,
//           //           builder: (context) => Container(
//           //                 height: 200.0,
//           //                 child: CupertinoPicker(
//           //                   itemExtent: 32,
//           //                   onSelectedItemChanged: (i) {
//           //                     setState(() {
//           //                       widget.product.selectedsize =
//           //                           widget.product.productatt[i];
//           //                     });
//           //                   },
//           //                   children: options,
//           //                 ),
//           //               ));
//           //     },
//           //     child: Container(
//           //       alignment: Alignment.center,
//           //       width: MediaQuery.of(context).size.width,
//           //       margin: EdgeInsets.all(5),
//           //       decoration:
//           //           BoxDecoration(border: Border.all(color: Colors.black)),
//           //       child: Text(
//           //         'Beden:' +
//           //             (widget.product.selectedsize.size != null
//           //                 ? widget.product.selectedsize.size
//           //                 : 'Stokta yok'),
//           //         style: TextStyle(fontSize: 20),
//           //       ),
//           //     ),
//           //   ),
//           // ),

//           // Container(
//           //   width: MediaQuery.of(context).size.width,
//           //   child: RaisedButton(
//           //     color: Colors.red,
//           //     onPressed: () {},
//           //     child: Text("Hızlı al"),
//           //   ),
//           // ),
//           // FlatButton(
//           //     onPressed: widget.product.productatt.isEmpty
//           //         ? null
//           //         : () {
//           //             bloc.addToCart(widget.product);
//           //           },
//           //     disabledColor: Colors.grey,
//           //     shape: RoundedRectangleBorder(
//           //         borderRadius: BorderRadius.circular(15)),
//           //     color: LightColor.orange,
//           //     child: Container(
//           //       alignment: Alignment.center,
//           //       padding: EdgeInsets.symmetric(vertical: 10),
//           //       width: AppTheme.fullWidth(context) * .7,
//           //       child: TitleText(
//           //         text: 'Sepete Ekle',
//           //         color: LightColor.background,
//           //       ),
//           //     ))
//         ],
//       ),
//     );
//   }
// }

class ProductCard extends StatelessWidget {
  final Product product;
  final ValueChanged<Product> onSelected;
  ProductCard({Key key, this.product, this.onSelected}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductDetailPage(product: product)));
        onSelected(product);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 40,
                backgroundColor: LightColor.orange.withAlpha(40),
              ),
              product.image != null
                  ? AspectRatio(
                      aspectRatio: 3 / 4,
                      child: Image.network(
                        product.image,
                        height: MediaQuery.of(context).size.height,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Text('Resim'),
            ],
          ),
          // SizedBox(height: 5),
          TitleText(
            text: product.name,
          ),
          // TitleText(
          //   text: product.category,
          //   color: LightColor.orange,
          // ),
          Container(
            alignment: Alignment.centerLeft,
            child: getPriceText(),
          ),
        ],
      ),
    );
  }

  Widget getPriceText() {
    if (product.saleprice != 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TitleText(
            color: LightColor.darkgrey,
            text: product.price.toString() + ' TL',
          ),
          TitleText(
            color: LightColor.orange,
            text: product.saleprice.toString() + ' TL',
          ),
        ],
      );
    }
    return TitleText(
      color: Colors.orange,
      text: product.price.toString() + ' TL',
    );
  }
}
