import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;


sendNotification(
    {required List<String?> extrnalId, String? category, String? title}) async {
  var url = Uri.parse('https://api.onesignal.com/notifications?c=push');

  try {
    await http.post(url,
        body: jsonEncode({
          "app_id": dotenv.env['ONE_SIGNAL_APP_ID'],
          "contents": {
            "en": "Book your ticket now before the seats are sold out!"
          },
          "target_channel": "push",
          "headings": {
            "en": "Check this new ${category ?? " "} workshop $title"
          },
          "small_icon": "ic_stat_onesignal_default",
          "big_picture":
              "https://img.freepik.com/free-vector/new-product-concept-illustration_114360-6721.jpg?t=st=1730132793~exp=1730136393~hmac=5b2be75faf99a11ac7dd8b7fca54d30d8882f525cbc708df42143b6b3dbc98cd&w=1060",
          "include_aliases": {"external_id": extrnalId}
        }),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Basic ${dotenv.env['ONE_SIGNAL_API_KEY']}"
        });

  } catch (e) {
    return e;
  }
}

