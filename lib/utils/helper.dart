

import 'package:url_launcher/url_launcher.dart';

customUrl(String link) async{
  String urlLink = link.replaceAll("{/sha", " ");
  if (await canLaunchUrl(Uri.parse(urlLink))) {
  await launchUrl(Uri.parse(urlLink));
  } else {
  throw 'Could not launch $urlLink';
  }
}