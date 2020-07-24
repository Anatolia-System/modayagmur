class CargoFirm {
  String name, price;

  CargoFirm({this.name, this.price});

  static String printTypeofPayment(Paymenttype type) {
    switch (type) {
      case Paymenttype.atdoorwithcreditcard:
        return 'Kapıda Kredi Kartı İle Ödeme';

        break;
      case Paymenttype.atdoorwithcash:
        return 'Kapıda Nakit Ödeme';
        break;
      case Paymenttype.eft:
        return 'Havale / EFT';
      default:
        return '';
    }
  }
}

enum Paymenttype { atdoorwithcreditcard, atdoorwithcash, eft }
