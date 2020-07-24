import 'package:ecommorce/model/cargofirm.dart';
import 'package:ecommorce/model/order.dart';
import 'package:ecommorce/themes/light_color.dart';
import 'package:ecommorce/themes/theme.dart';
import 'package:ecommorce/widgets/title_text.dart';
import 'package:flutter/material.dart';

import 'ordersummary.dart';

class PickCargo extends StatelessWidget {
  final Order order;

  const PickCargo({Key key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Kargo Seç'),
        ),
        body: Padding(
            padding: EdgeInsets.all(20),
            child: MyCargoSelecter(
              order: order,
            )));
  }
}

class MyCargoSelecter extends StatefulWidget {
  final Order order;
  MyCargoSelecter({Key key, this.order}) : super(key: key);

  @override
  _MyCargoSelecterState createState() => _MyCargoSelecterState();
}

class _MyCargoSelecterState extends State<MyCargoSelecter> {
  Order _order;

  CargoFirm _selectedCargo;
  List<CargoFirm> _cargofirms;
  Paymenttype _paymenttype;

  @override
  initState() {
    _order = widget.order;
    _cargofirms = ([
      CargoFirm(name: 'MNG Kargo', price: '10₺'),
      CargoFirm(name: 'Aras Kargo', price: '10₺'),
      CargoFirm(name: 'UPS', price: '12₺')
    ]);
    _selectedCargo = _cargofirms.first;
    _paymenttype = Paymenttype.atdoorwithcreditcard;

    super.initState();
  }

  mycargotiles(int i) => ListTile(
        title: Text(_cargofirms[i].name),
        onTap: () {
          setState(() {
            _selectedCargo = _cargofirms[i];
          });
        },
        leading: Radio<CargoFirm>(
          value: _cargofirms[i],
          groupValue: _selectedCargo,
          onChanged: (CargoFirm value) {
            setState(() {
              _selectedCargo = value;
            });
          },
        ),
      );

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TitleText(
          text: 'Kargo Seç',
          color: LightColor.black,
          fontWeight: FontWeight.w500,
        ),
        for (int i = 0; i < _cargofirms.length; i++) mycargotiles(i),
        SizedBox(
          height: 25,
        ),
        TitleText(
          text: 'Ödeme Yöntemi',
          color: LightColor.black,
          fontWeight: FontWeight.w500,
        ),
        paymentTiles(),
        _submitButton(context)
      ],
    );
  }

  paymentTiles() {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
              CargoFirm.printTypeofPayment(Paymenttype.atdoorwithcreditcard)),
          onTap: () {
            setState(() {
              _paymenttype = Paymenttype.atdoorwithcreditcard;
            });
          },
          leading: Radio<Paymenttype>(
            value: Paymenttype.atdoorwithcreditcard,
            groupValue: _paymenttype,
            onChanged: (Paymenttype value) {
              setState(() {
                _paymenttype = value;
              });
            },
          ),
        ),
        ListTile(
          onTap: () {
            setState(() {
              _paymenttype = Paymenttype.atdoorwithcash;
            });
          },
          title: Text(CargoFirm.printTypeofPayment(Paymenttype.atdoorwithcash)),
          leading: Radio<Paymenttype>(
            value: Paymenttype.atdoorwithcash,
            groupValue: _paymenttype,
            onChanged: (Paymenttype value) {
              setState(() {
                _paymenttype = value;
              });
            },
          ),
        ),
        ListTile(
          onTap: () {
            setState(() {
              _paymenttype = Paymenttype.eft;
            });
          },
          title: Text(CargoFirm.printTypeofPayment(Paymenttype.eft)),
          leading: Radio<Paymenttype>(
            value: Paymenttype.eft,
            groupValue: _paymenttype,
            onChanged: (Paymenttype value) {
              setState(() {
                _paymenttype = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _submitButton(BuildContext context) {
    return FlatButton(
        onPressed: () {
          _order.paymenttype = _paymenttype;
          _order.cargoFirm = _selectedCargo;
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrderSummary(order: _order),
              ));
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: LightColor.orange,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 12),
          width: AppTheme.fullWidth(context) * .7,
          child: TitleText(
            text: 'Özet Sayfasnıa Geç',
            color: LightColor.background,
            fontWeight: FontWeight.w500,
          ),
        ));
  }
}
