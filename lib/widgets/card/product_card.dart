import 'package:super_store_e_commerce_flutter/imports.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  const ProductCard({Key? key, required this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.simpleCurrency(locale: 'id_ID');
    Size size = MediaQuery.sizeOf(context);
    final ScaffoldMessengerState addToCartMsg = ScaffoldMessenger.of(context);
    final cart = Provider.of<CartProvider>(context);

    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.orange, width: 1.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () => openImage(context, size),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(7),
                  topLeft: Radius.circular(7),
                ),
                clipBehavior: Clip.antiAlias,
                child: CachedNetworkImage(
                  imageUrl: product.image!,
                  height: size.height,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                  colorBlendMode: BlendMode.overlay,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                    child: SizedBox(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator(
                          color: Colors.orange,
                          value: downloadProgress.progress,
                        )),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(height: 5.0),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: TextBuilder(
                      text: product.title!,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      maxLines: 3,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: TextBuilder(
                      text: product.store!,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      maxLines: 3,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextBuilder(
                          text: product.category,
                          fontSize: 10,
                          color: Colors.white,
                        )),
                  ),
                  // const SizedBox(height: ),
                  Padding(
                    padding: const EdgeInsets.only(left: 2, right: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            TextBuilder(
                              text: formatCurrency
                                  .format(product.price!.round())
                                  .toString(),
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ],
                        ),
                        IconButton(
                          splashColor: Colors.orange,
                          tooltip: 'Add to cart',
                          onPressed: () {
                            addToCartMsg.showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                backgroundColor: Colors.black,
                                behavior: SnackBarBehavior.floating,
                                content: const TextBuilder(
                                    text:
                                        'Produk ditambahkan ke dalam keranjang'),
                              ),
                            );
                            CartModel cartModel = CartModel(
                                id: product.id!,
                                title: product.title!,
                                price: product.price!,
                                image: product.image!,
                                category: product.category!,
                                store: product.store!,
                                quantity: 1,
                                totalPrice: product.price!,
                                productId: product.id!);
                            cart.addItem(cartModel); //==> POST API
                          },
                          icon: const Icon(Icons.add_shopping_cart_rounded),
                          color: Colors.orange,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  openImage(BuildContext context, Size size) {
    showDialog(
      context: context,
      useSafeArea: true,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          // actionsPadding: EdgeInsets.zero,
          // buttonPadding: EdgeInsets.zero,
          contentPadding: const EdgeInsets.all(20),
          // iconPadding: EdgeInsets.zero,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextBuilder(
                    text: product.title!,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 25,
                        color: Colors.black,
                      ))
                ],
              )
            ],
          ),
          content: InteractiveViewer(
              // minScale: 0.1,
              // maxScale: 1,
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: product.image!,
                height: size.height * 0.4,
                width: size.width,
                fit: BoxFit.fitWidth,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                  child: SizedBox(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator(
                        color: Colors.orange,
                        value: downloadProgress.progress,
                      )),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              const SizedBox(
                height: 15,
              ),
              const TextBuilder(
                text: 'Deskripsi Produk :',
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(product.description!)
            ],
          )),
        );
      },
    );
  }
}
