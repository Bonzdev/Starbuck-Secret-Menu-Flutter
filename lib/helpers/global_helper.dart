import 'package:url_launcher/url_launcher.dart';

launchURL(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

String capitalize(String s) => (s != null && s.length > 1)
    ? s[0].toUpperCase() + s.substring(1)
    : s != null ? s.toUpperCase() : null;
