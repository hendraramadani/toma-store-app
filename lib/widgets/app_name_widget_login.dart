import 'package:super_store_e_commerce_flutter/imports.dart';

class AppNameWidgetLogin extends StatelessWidget {
  const AppNameWidgetLogin({Key? key}) : super(key: key);

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
                fontSize: width * 0.07,
                fontWeight: FontWeight.w800),
            TextBuilder(
                text: 'STORE',
                fontSize: width * 0.07,
                fontWeight: FontWeight.w800),
          ],
        ),
      ],
    );
  }
}
