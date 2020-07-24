import 'package:ecommorce/model/cargofirm.dart';
import 'package:ecommorce/model/order.dart';
import 'package:ecommorce/model/product.dart';
import 'package:ecommorce/themes/light_color.dart';
import 'package:ecommorce/themes/theme.dart';
import 'package:ecommorce/widgets/title_text.dart';
import 'package:flutter/material.dart';

class OrderSummary extends StatelessWidget {
  final Order order;

  const OrderSummary({Key key, this.order}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String list = '';
    for (int i = 0; i < order.orderlist.length; i++) {
      Product temp = order.orderlist[i];
      list += temp.name +
          ' x${temp.selectedquantity.toString()}' +
          '\n' +
          temp.selectedsize.size +
          ' ' +
          temp.selectedsize.color +
          '\n';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Sipariş Özeti'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: TitleText(
                  text: 'Sipariş Özetiniz',
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              MyTextArea(
                title: 'İsim Soyisim',
                content: order.name + ' ' + order.surname,
              ),
              MyTextArea(
                title: 'Adres',
                content: order.address,
              ),
              MyTextArea(
                title: 'Telefon',
                content: order.phone,
              ),
              MyTextArea(
                title: 'İl/İlçe',
                content: order.city + '/' + order.town,
              ),
              MyTextArea(
                  title: 'Ödeme',
                  content: order.cargoFirm.name +
                      '\n' +
                      CargoFirm.printTypeofPayment(order.paymenttype)),
              MyTextArea(title: 'Sipariş', content: list),
              _submitButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    return FlatButton(
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/login',
            (Route<dynamic> route) => false,
          );
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: LightColor.orange,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 12),
          width: AppTheme.fullWidth(context) * .7,
          child: TitleText(
            text: 'Siparişi Bitir',
            color: LightColor.background,
            fontWeight: FontWeight.w500,
          ),
        ));
  }
}

class MyTextArea extends StatelessWidget {
  final String title, content;

  MyTextArea({this.title = '', this.content = ''});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TitleText(
              text: title,
              fontSize: 20,
            ),
            Container(
                color: Colors.amber[200],
                width: MediaQuery.of(context).size.width,
                child: Text(
                  content,
                  style: TextStyle(fontSize: 20),
                )),
          ],
        ),
      ),
    );
  }
}
