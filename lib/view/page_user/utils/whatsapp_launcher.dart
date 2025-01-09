import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

whatsapp(String phone) async {
  ///REGEX phone 0 to 62 firstchar or to char
  String contact = phone;
  print(phone[0]);
  if (phone[0] == '0') {
    contact = phone.replaceFirst(RegExp(r'0'), '62');
  }
  String text = '';
  String androidUrl = "whatsapp://send?phone=$contact&text=";
  String iosUrl = "https://wa.me/$contact?text=${Uri.parse(text)}";

  String webUrl = 'https://api.whatsapp.com/send/?phone=$contact&text=';

  try {
    if (Platform.isIOS) {
      if (await canLaunchUrl(Uri.parse(iosUrl))) {
        await launchUrl(Uri.parse(iosUrl));
      }
    } else {
      if (await canLaunchUrl(Uri.parse(androidUrl))) {
        await launchUrl(Uri.parse(androidUrl));
      }
    }
  } catch (e) {
    print('object');
    await launchUrl(Uri.parse(webUrl), mode: LaunchMode.externalApplication);
  }
}
