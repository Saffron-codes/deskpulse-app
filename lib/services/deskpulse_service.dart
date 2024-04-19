import 'dart:convert';

import 'package:deskpulse/constants.dart';
import 'package:http/http.dart' as http;

class DeskpulseService {
  final http.Client client;

  const DeskpulseService(this.client);

  Future<bool> verifyPairyKey(String pairKey) async {
    var reqUrl = "$SERVER_URL/device/verify?pair_key=$pairKey";
    final res = await http.get(Uri.parse(reqUrl));
    final rawJson = jsonDecode(res.body);
    if (res.statusCode != 200) {
      throw Exception(rawJson["message"]);
    } else {
      print(rawJson);
      return rawJson["verified"];
    }
  }
}
