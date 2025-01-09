import 'package:super_store_e_commerce_flutter/imports.dart';

class AppNameWidget extends StatelessWidget {
  const AppNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextBuilder(
                text: 'TOMA ',
                color: Colors.orange,
                fontWeight: FontWeight.bold),
            TextBuilder(text: 'STORE', fontWeight: FontWeight.bold),
          ],
        ),
      ],
    );
  }
}
