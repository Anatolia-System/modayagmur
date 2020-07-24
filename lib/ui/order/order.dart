import 'package:ecommorce/model/order.dart';
import 'package:ecommorce/model/product.dart';
import 'package:ecommorce/themes/light_color.dart';
import 'package:ecommorce/themes/theme.dart';
import 'package:ecommorce/ui/order/pickcargo.dart';
import 'package:ecommorce/widgets/title_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatelessWidget {
  final List<Product> products;

  const OrderPage({Key key, this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        elevation: 2,
        title: Text('Sipariş Sayfası'),
      ),
      body: SafeArea(
          child: MyForm(
        products: products,
      )),
    );
  }
}

class MyForm extends StatefulWidget {
  final List<Product> products;

  const MyForm({Key key, @required this.products}) : super(key: key);
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  TextEditingController name, surname, phone, city, town, address;

  @override
  void initState() {
    name = TextEditingController();
    surname = TextEditingController();
    phone = TextEditingController();
    city = TextEditingController();
    town = TextEditingController();
    address = TextEditingController();

    name.text = 'Yusuf';
    surname.text = 'Güngör';
    phone.text = '212 280 00 66';
    city.text = 'İstanbul';
    town.text = 'Beşiktaş';
    address.text = ' Konaklar Mah. Akçam Cad. No:15 ';
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              MyTextField(
                label: 'İsim*',
                controller: name,
              ),
              MyTextField(
                label: 'Soyadı*',
                controller: surname,
              ),
              MyTextField(
                label: 'Telefon',
                controller: phone,
              ),
              MyTextField(
                label: 'İl',
                controller: city,
              ),
              MyTextField(
                label: 'İlçe',
                controller: town,
              ),
              MyTextField(
                label: 'Adres',
                controller: address,
                line: 5,
              ),
              _submitButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    return FlatButton(
        onPressed: () {
          Order order = Order(
            name: name.text,
            surname: surname.text,
            phone: phone.text,
            city: city.text,
            town: town.text,
            address: address.text,
            orderlist: widget.products,
          );

          // print(order.name);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PickCargo(order: order),
              ));
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: LightColor.orange,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 12),
          width: AppTheme.fullWidth(context) * .7,
          child: TitleText(
            text: 'Kargo Seç',
            color: LightColor.background,
            fontWeight: FontWeight.w500,
          ),
        ));
  }
}

class MyTextField extends StatelessWidget {
  final String label, hint;
  final int line;
  final TextEditingController controller;

  const MyTextField(
      {Key key,
      this.label = '',
      this.hint = '',
      this.line = 1,
      this.controller})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        maxLines: line,
        controller: controller,
        decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.red),
          labelText: label,
          hintText: hint,
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.all(Radius.circular(15))),
        ),
      ),
    );
  }
}
