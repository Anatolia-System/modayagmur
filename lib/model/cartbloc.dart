import 'dart:async';
import 'package:ecommorce/model/product.dart';

class CartItemsBloc {
  /// The [cartStreamController] is an object of the StreamController class
  /// .broadcast enables the stream to be read in multiple screens of our app
  final cartStreamController = StreamController.broadcast();

  /// The [getStream] getter would be used to expose our stream to other classes
  Stream get getStream => cartStreamController.stream;

  /// The [cartlist] Map would hold all the data this bloc provides
  final List<Product> cartlist = [];

  /// The [dispose] method is used
  /// to automatically close the stream when the widget is removed from the widget tree
  void dispose() {
    cartStreamController.close();
  }

  void clearCart() {
    cartlist.clear();
    cartStreamController.sink.add(cartlist);
  }

  void addToCart(Product item) {
    // bool a = cartlist.any((element) =>
    //     identical(item.productatt, element.productatt) &&
    //     identical(item, element));
    Product a;
    a = cartlist.firstWhere(
      (element) => _isSame(element, item),
      orElse: () => null,
    );
    if (a == null) {
      item.selectedquantity++;
      cartlist.add(item);
    } else {
      a.selectedquantity++;
    }
    cartStreamController.sink.add(cartlist);
  }

  /// [removeFromCart] removes items from the cart, back to the shop
  void removeFromCart(item) {
    cartlist.remove(item);
    cartStreamController.sink.add(cartlist);
  } // close our StreamController

  void removeQuantFromCart(Product item) {
    item.selectedquantity--;
    cartStreamController.sink.add(cartlist);
  } // c

  _isSame(Product first, Product second) {
    print(first.selectedsize.size + ' - ' + second.selectedsize.size);

    return first.id == second.id &&
        first.selectedsize.size == second.selectedsize.size &&
        first.selectedsize.color == second.selectedsize.color &&
        first.selectedcommission == second.selectedcommission;
  }
}

final bloc = CartItemsBloc();
