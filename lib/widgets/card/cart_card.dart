import 'package:cached_network_image/cached_network_image.dart';
import 'package:super_store_e_commerce_flutter/imports.dart';
import 'package:intl/intl.dart';

class CartCard extends StatelessWidget {
  final CartModel cart;
  const CartCard({
    Key? key,
    required this.cart,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.simpleCurrency(locale: 'id_ID');
    // Size size = MediaQuery.of(context).size;
    // final totalPrice = (cart.price! * cart.quantity!);
    final provider = Provider.of<CartProvider>(context);
    return Container(
      // padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.orange, width: 1.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(7),
              topLeft: Radius.circular(7),
            ),
            child: CachedNetworkImage(
              imageUrl: cart.image!,
              height: 106,
              width: 100,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(
                      color: Colors.orange, value: downloadProgress.progress),
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextBuilder(
                        text: '${cart.title}',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        // fontSize: 16,
                        maxLines: 3,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Padding(
                      padding: const EdgeInsets.all(2),
                      child: InkWell(
                        onTap: () {
                          provider.removeItem(cart.id!);
                        },
                        child: const SizedBox(
                          height: 20,
                          width: 20,
                          child: Icon(
                            Icons.close,
                            color: Colors.black,
                            size: 16,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextBuilder(
                          text: cart.category,
                          fontSize: 10,
                          color: Colors.white,
                        )),
                    const SizedBox(
                      width: 5,
                    ),
                    Text('| ${cart.store}')
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Row(
                      children: [
                        IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              provider.decreaseQuantity(cart.id!);
                            },
                            icon: const Icon(
                              Icons.remove_circle_outline,
                              color: Colors.black,
                            )),
                        TextBuilder(
                          text: cart.quantity.toString(),
                          color: Colors.black,
                          // fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        IconButton(
                            onPressed: () {
                              provider.increaseQuantity(cart.id!);
                            },
                            icon: const Icon(
                              Icons.add_circle_outline,
                              color: Colors.black,
                            ))
                      ],
                    ),
                    Expanded(
                        child: Column(
                      children: [
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextBuilder(
                              text: 'Total:',
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.orange,
                            ),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextBuilder(
                              text: formatCurrency
                                  .format(
                                      (cart.price!.round() * cart.quantity!))
                                  .toString(),
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            const SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                      ],
                    ))
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
