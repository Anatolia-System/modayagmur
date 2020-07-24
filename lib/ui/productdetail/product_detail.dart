import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommorce/model/cartbloc.dart';
import 'package:ecommorce/model/product.dart';
import 'package:ecommorce/themes/light_color.dart';
import 'package:ecommorce/themes/theme.dart';
import 'package:ecommorce/widgets/title_text.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:ecommorce/widgets/extentions.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;
  ProductDetailPage({Key key, @required this.product}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  List<int> image;
  bool instock;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInToLinear));
    controller.forward();
    instock = widget.product.productatt.isNotEmpty;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool isLiked = true;
  Widget _appBar() {
    return Container(
      padding: AppTheme.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
            size: 15,
            padding: 12,
            isOutLine: true,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          _sizeWidget('Paylaş', () async {
            Clipboard.setData(ClipboardData(text: widget.product.desciption));
            http.Response response = await http.get(
              widget.product.image,
            );
            await Share.file(
              widget.product.name,
              widget.product.name,
              response.bodyBytes.buffer.asUint8List(),
              'image/png',
              text: 'ModaSistem',
            );
          }, isSelected: true),
        ],
      ),
    );
  }

  Widget _icon(
    IconData icon, {
    Color color = LightColor.iconColor,
    double size = 20,
    double padding = 10,
    bool isOutLine = false,
    Function onPressed,
  }) {
    return Container(
      height: 40,
      width: 40,
      padding: EdgeInsets.all(padding),
      // margin: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        border: Border.all(
            color: LightColor.iconColor,
            style: isOutLine ? BorderStyle.solid : BorderStyle.none),
        borderRadius: BorderRadius.all(Radius.circular(13)),
        color:
            isOutLine ? Colors.transparent : Theme.of(context).backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Color(0xfff8f8f8),
              blurRadius: 5,
              spreadRadius: 10,
              offset: Offset(5, 5)),
        ],
      ),
      child: Icon(icon, color: color, size: size),
    ).ripple(() {
      if (onPressed != null) {
        onPressed();
      }
    }, borderRadius: BorderRadius.all(Radius.circular(13)));
  }

  Widget _productImage(String image) {
    return AnimatedBuilder(
      builder: (context, child) {
        return AnimatedOpacity(
          duration: Duration(milliseconds: 500),
          opacity: animation.value,
          child: child,
        );
      },
      animation: animation,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          TitleText(
            text: "Resim Yok",
            fontSize: 100,
            color: LightColor.lightGrey,
          ),
          CachedNetworkImage(
            imageUrl: image,
          )
        ],
      ),
    );
  }

  Widget _detailWidget() {
    return DraggableScrollableSheet(
      maxChildSize: .8,
      initialChildSize: .53,
      minChildSize: .53,
      builder: (context, scrollController) {
        return Container(
          padding: AppTheme.padding.copyWith(bottom: 0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              color: Colors.white),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                // _categoryWidget(),
                //   _thumbnail(widget.product.image),

                SizedBox(height: 5),
                Container(
                  alignment: Alignment.center,
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                        color: LightColor.iconColor,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                          child: TitleText(
                              text: widget.product.name, fontSize: 25)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              TitleText(
                                text: "\₺ ",
                                fontSize: 18,
                                color: LightColor.red,
                              ),
                              TitleText(
                                text: widget.product.price.toString(),
                                fontSize: 23,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                instock ? _availableSize() : Text(''),
                SizedBox(
                  height: 20,
                ),
                TitleText(text: 'Komisyon:'),
                //Komison kısmı
                Slider(
                    divisions: 20,
                    min: widget.product.commission,
                    max: widget.product.commission + 20,
                    value: widget.product.selectedcommission,
                    onChanged: (value) {
                      setState(() {
                        widget.product.selectedcommission = value;
                      });
                    }),
                TitleText(
                  text:
                      widget.product.selectedcommission.ceil().toString() + '₺',
                ),
                SizedBox(
                  height: 20,
                ),

                _description(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _availableSize() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TitleText(
          text: "Mevcut Ölçüler",
          fontSize: 14,
        ),
        SizedBox(height: 20),
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: ListView(
              scrollDirection: Axis.horizontal,
              children: widget.product.productatt
                  .map(
                    (e) => _sizeWidget(
                      e.size,
                      () {
                        widget.product.selectedsize = e;
                      },
                      isSelected: e == widget.product.selectedsize,
                    ),
                  )
                  .toList()),
        ),
      ],
    );
  }

  Widget _sizeWidget(String text, Function onChanged,
      {Color color = LightColor.iconColor, bool isSelected = false}) {
    return Padding(
      padding: AppTheme.hPadding,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
              color: LightColor.iconColor,
              style: !isSelected ? BorderStyle.solid : BorderStyle.none),
          borderRadius: BorderRadius.all(Radius.circular(13)),
          color: isSelected
              ? LightColor.orange
              : Theme.of(context).backgroundColor,
        ),
        child: TitleText(
          text: text,
          fontSize: 16,
          color: isSelected ? LightColor.background : LightColor.titleTextColor,
        ),
      ).ripple(() {
        setState(() {
          onChanged();
        });
      }, borderRadius: BorderRadius.all(Radius.circular(13))),
    );
  }

  Widget _availableColor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TitleText(
          text: "Mevcut Renkler",
          fontSize: 14,
        ),
        SizedBox(height: 20),
        Container(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.all(5),
            shrinkWrap: true,
            addRepaintBoundaries: true,
            itemCount: widget.product.productatt.length,
            itemBuilder: (context, index) => _sizeWidget(
              widget.product.productatt[index].color,
              () {},
            ),
          ),
        )
      ],
    );
  }

  Widget _description() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TitleText(
          text: "Açıklama",
          fontSize: 14,
        ),
        SizedBox(height: 20),
        Text(widget.product.desciption),
      ],
    );
  }

  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  @override
  Widget build(BuildContext context) {
    FloatingActionButton _flotingButton() {
      return FloatingActionButton(
        onPressed: () {
          bloc.addToCart(Product.clone(widget.product));
          scaffoldState.currentState
              .showSnackBar(new SnackBar(content: new Text('Sepete Eklendi!')));
        },
        backgroundColor: LightColor.orange,
        child: Icon(Icons.shopping_basket,
            color: Theme.of(context).floatingActionButtonTheme.backgroundColor),
      );
    }

    return Scaffold(
      key: scaffoldState,
      floatingActionButton: instock
          ? new Builder(builder: (BuildContext context) => _flotingButton())
          : null,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color(0xfffbfbfb),
              Color(0xfff7f7f7),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  _appBar(),
                  _productImage(widget.product.image),
                ],
              ),
              _detailWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
