import 'package:super_store_e_commerce_flutter/imports.dart';

class UserCartAppbar extends StatefulWidget {
  const UserCartAppbar({Key? key}) : super(key: key);

  @override
  _CartAppbarState createState() => _CartAppbarState();
}

class _CartAppbarState extends State<UserCartAppbar> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return IconButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const Cart()));
      },
      icon: Stack(
        children: [
          Padding(
            padding:
                EdgeInsets.only(top: 6, right: cart.itemCount != 0 ? 7 : 0),
            child: const Icon(
              Icons.shopping_cart_outlined,
            ),
          ),
          if (cart.itemCount != 0)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                height: 15,
                width: 15,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.orange),
                child: TextBuilder(
                  text: cart.itemCount.toString(),
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            )
        ],
      ),
    );
  }
}
