import 'package:super_store_e_commerce_flutter/imports.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  Future<int?> getId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getInt('id');

    return userId;
  }

  // late List<CartModel>? _cartModel = [];

  Future<void> _callCart(id, data) async {
    (await CartApiService().cart(id, data));
  }

  // List<CartModel>? _getCartModel = [];
  List<CartModel>? _items = [];

  Future<List<CartModel>?> _callGetCart() async {
    getId().then((id) async => {_items = await CartApiService().getCart(id)});

    return _items;
  }

  void cartData() {
    _callGetCart();
  }

  List<CartModel> get items {
    return [..._items!];
  }

  int get itemCount => _items!.length;

  bool get kDebugMode => false;

  void addItem(CartModel cartModel) {
    int index = _items!.indexWhere((item) => item.id == cartModel.id);
    if (index != -1) {
      // Item already exists, update quantity and price
      CartModel existingItem = _items![index];
      CartModel updatedItem = existingItem.copyWith(
        quantity: existingItem.quantity! + cartModel.quantity!,
        totalPrice: existingItem.totalPrice! + cartModel.totalPrice!,
      );
      _items![index] = updatedItem;
    } else {
      // Item doesn't exist, add it to the list
      _items!.add(cartModel);
    }
    notifyListeners();

    String jsonData = cartModelToJson(_items!);

    getId().then((id) => {_callCart(id, jsonData)});
  }

  void removeItem(int id) {
    _items!.removeWhere((element) => element.id == id);
    notifyListeners();
    String jsonData = cartModelToJson(_items!);

    getId().then((id) => {_callCart(id, jsonData)});
  }

  void increaseQuantity(int id) {
    final index = _items!.indexWhere((e) => e.id == id);
    _items![index].quantity = _items![index].quantity! + 1;
    _items![index].totalPrice =
        _items![index].price! * _items![index].quantity!;
    notifyListeners();
    String jsonData = cartModelToJson(_items!);

    getId().then((id) => {_callCart(id, jsonData)});
  }

  void decreaseQuantity(int id) {
    final index = _items!.indexWhere((e) => e.id == id);
    if (_items![index].quantity! > 1) {
      _items![index].quantity = _items![index].quantity! - 1;
      _items![index].totalPrice =
          _items![index].price! * _items![index].quantity!;
    }
    notifyListeners();
    String jsonData = cartModelToJson(_items!);

    getId().then((id) => {_callCart(id, jsonData)});
  }

  void clearCart() {
    _items!.clear();
    notifyListeners();
  }

  void removeSingleItem(int id) {
    final index = _items!.indexWhere((e) => e.id == id);
    if (_items![index].quantity! > 1) {
      _items![index].quantity = _items![index].quantity! - 1;
      _items![index].totalPrice =
          _items![index].price! * _items![index].quantity!;
    } else {
      _items!.removeWhere((element) => element.id == id);
    }
    notifyListeners();
    String jsonData = cartModelToJson(_items!);

    getId().then((id) => {_callCart(id, jsonData)});
  }

  int totalPrice() {
    double totalPrice = 0;
    for (int i = 0; i < _items!.length; i++) {
      totalPrice += _items![i].totalPrice!;
    }
    // notifyListeners();
    if (kDebugMode) {
      // print('Total Price: $totalPrice');
    }
    return totalPrice.round();
  }

  void clearList() {
    _items!.clear();
    items.clear();
    // print(_items!);
    // print(_items);
  }
}
