import 'package:ecommorce/themes/light_color.dart';
import 'package:ecommorce/themes/theme.dart';
import 'package:flutter/material.dart';

class MyOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _icon(IconData icon, {Color color = LightColor.iconColor}) {
      return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Theme.of(context).backgroundColor,
        ),
        child: Icon(
          icon,
          color: color,
        ),
      );
    }

    Widget _search() {
      return Container(
        padding: AppTheme.padding,
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
                    if (value.length > 3) {}
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Sipariş Ara",
                      hintStyle: TextStyle(fontSize: 12),
                      contentPadding: EdgeInsets.only(
                          left: 10, right: 10, bottom: 0, top: 5),
                      prefixIcon: Icon(Icons.search, color: Colors.black54)),
                ),
              ),
            ),
            //    _icon(Icons.filter_list, color: Colors.black54)
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Önceki Siparişler',
          // style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            _search(),
            MyOrderBody(),
          ],
        ),
      ),
    );
  }
}

class MyOrderBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    myTile() {
      return Card(
        elevation: 1,
        margin: EdgeInsets.all(10),
        child: ListTile(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => OrderDetail())),
            isThreeLine: true,
            title: Text('Yusuf Güngör'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Sipariş Durumu: Tamamlandı'),
                Text('Tarih:20 Mayıs Çarşamba'),
                Text('Sipariş kodu: 858585'),
              ],
            ),
            trailing: Text('214,60 TL')),
      );
    }

    var a = [
      myTile(),
      myTile(),
      myTile(),
      myTile(),
      myTile(),
      myTile(),
      myTile(),
      myTile(),
      myTile(),
      myTile(),
      myTile(),
      myTile(),
    ];
    return Expanded(
      child: ListView.builder(
        itemCount: a.length,
        itemBuilder: (context, index) => a[index],
      ),
    );
  }
}

class OrderDetail extends StatelessWidget {
  _tile(String text1, String text2) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[Text(text1), Text(text2)],
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sipariş Detayı',
          // style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: <Widget>[
            OrderDetailBody(),
            Card(
              elevation: 5,
              child: Column(
                children: <Widget>[
                  _tile('Sipariş Tarihi', '01.02.2008'),
                  _tile('Sipariş Tarihi', '01.02.2008'),
                  _tile('Sipariş Tarihi', '01.02.2008'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OrderDetailBody extends StatelessWidget {
  cellText(String text) => Expanded(
        child: Text(
          text,
          softWrap: true,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
        DataColumn(
          label: cellText('Ürün Adı'),
        ),
        DataColumn(
          label: cellText('Adet'),
        ),
        DataColumn(
          label: cellText('Komisyon'),
        ),
        DataColumn(
          label: cellText('Komisyonsuz Fiyat'),
        ),
        DataColumn(
          label: cellText('Toplam fiyat'),
        ),
      ],
      rows: [
        DataRow(
          cells: [
            DataCell(Text('data')),
            DataCell(Text('data')),
            DataCell(Text('data')),
            DataCell(Text('data')),
            DataCell(Text('data')),
          ],
        ),
        DataRow(
          cells: [
            DataCell(Text('data')),
            DataCell(Text('data')),
            DataCell(Text('data')),
            DataCell(Text('data')),
            DataCell(Text('data')),
          ],
        ),
        DataRow(
          cells: [
            DataCell(Text('data')),
            DataCell(Text('data')),
            DataCell(Text('data')),
            DataCell(Text('data')),
            DataCell(Text('data')),
          ],
        ),
        DataRow(
          cells: [
            DataCell(Text('data')),
            DataCell(Text('data')),
            DataCell(Text('data')),
            DataCell(Text('data')),
            DataCell(Text('data')),
          ],
        ),
      ],
    );
  }
}
