import 'package:super_store_e_commerce_flutter/imports.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class Invoice extends StatefulWidget {
  late List<InvoiceModel>? invoiceData;
  Invoice(this.invoiceData, {Key? key}) : super(key: key);

  @override
  _InvoiceState createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  late Image image1;
  late Image image2;
  @override
  void initState() {
    image1 = Image.asset("assets/images/invoice.png");
    image2 = Image.asset("assets/images/invoice10.png");
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    precacheImage(image1.image, context);
    precacheImage(image2.image, context);
  }

  final formatCurrency = NumberFormat.simpleCurrency(locale: 'id_ID');
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.orange,
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // SizedBox(
            //   height: 100,
            // ),
            Padding(
                padding: const EdgeInsets.only(top: 50),
                child: SizedBox(
                  height: 600,
                  width: 350,
                  child: Stack(
                    children: [
                      if (widget.invoiceData![0].detail.length < 6) ...{
                        image1
                      } else ...{
                        image2
                      },
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Invoice #${widget.invoiceData![0].order.id}',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Customer : ${widget.invoiceData![0].order.name}",
                                      style: const TextStyle(fontSize: 17),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 75,
                                  width: 75,
                                  child: Image.asset(
                                    'assets/images/logo.jpg',
                                    fit: BoxFit.cover,
                                    width: 50,
                                    height: 100,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            // const MySeparator(color: Colors.grey),

                            const Text(
                              "Detail Order :",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),

                            SizedBox(
                                height: widget.invoiceData![0].detail.length < 6
                                    ? 130
                                    : 300,
                                child: ListView.builder(
                                  itemCount:
                                      widget.invoiceData![0].detail.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Text(
                                            "${index + 1}. ${widget.invoiceData![0].detail[index].title} (${widget.invoiceData![0].detail[index].quantity} pcs) ",
                                            style:
                                                const TextStyle(fontSize: 17),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Text(
                                            formatCurrency
                                                .format(widget.invoiceData![0]
                                                    .detail[index].price)
                                                .toString(),
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(),
                                Text(
                                  "Total : ${formatCurrency.format(widget.invoiceData![0].order.totalCost).toString()}",
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )),
            Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    height: 60,
                    color: Colors.white,
                    minWidth: size.width,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => const UserHome()));
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextBuilder(
                          text: 'Kembali',
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ],
                    ),
                  ),
                ))
          ],
        ),
      )),
    );
  }
}

class MySeparator extends StatelessWidget {
  const MySeparator({Key? key, this.height = 1, this.color = Colors.black})
      : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 10.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}
