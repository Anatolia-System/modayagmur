import 'package:ecommorce/ui/profilesettings/myorders.dart';
import 'package:ecommorce/ui/profilesettings/notifications.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          myTile(Icons.shopping_cart, 'Önceki Siparişlerim', () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyOrders()));
          }),
          myTile(Icons.notifications_none, 'Bildirimlerim', () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Notifications()));
          }),
          myTile(Icons.exit_to_app, 'Çıkış yap', () async {
            SharedPreferences localStorage =
                await SharedPreferences.getInstance();
            localStorage.remove('token');
            Navigator.pushNamedAndRemoveUntil(
                context, '/login', (route) => false);
          }),
        ],
      ),
    );
  }

  myTile(IconData icon, String text, Function ontap) => ListTile(
        leading: Icon(icon),
        title: Text(text),
        onTap: ontap,
      );
}
