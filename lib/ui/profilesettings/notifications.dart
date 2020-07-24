import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  final List<String> notfications = [
    "56415361431 nolu Siparişiniz ulaştıulaştıulaştıulaştıulaştı.",
    "Siparişiniz ulaştı.",
    "Siparişiniz ulaştı.",
    "Siparişiniz ulaştı.",
    "Siparişiniz ulaştı.",
    "Siparişiniz ulaştı.",
    "Siparişiniz ulaştı.",
    "Siparişiniz ulaştı.",
    "Siparişiniz ulaştı.",
    "Siparişiniz ulaştı.",
    "Siparişiniz ulaştı.",
    "Siparişiniz ulaştı.",
    "Siparişiniz ulaştı.",
    "Siparişiniz ulaştı.",
    "Siparişiniz ulaştı.",
    "Siparişiniz ulaştı.",
    "Siparişiniz ulaştı.",
    "Siparişiniz ulaştı.",
    "Siparişiniz ulaştı.",
    "Siparişiniz ulaştı.",
    "Siparişiniz ulaştı.",
    "Siparişiniz ulaştı.",
    "Siparişiniz ulaştı.",
    "Siparişiniz ulaştı.",
    "Siparişiniz ulaştı.",
    "Siparişiniz ulaştı.",
    "Siparişiniz ulaştı.",
    "Siparişiniz ulaştı.",
    "Siparişiniz ulaştı.",
    "Siparişiniz ulaştı.",
    "Siparişiniz ulaştı.",
    "Siparişiniz ulaştı.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bildirimler',
          // style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView.builder(
        itemCount: notfications.length,
        itemBuilder: (context, index) =>
            MyCard(notfication: notfications[index]),
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  const MyCard({
    Key key,
    @required this.notfication,
  }) : super(key: key);

  final String notfication;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(notfication),
      ),
    );
  }
}
