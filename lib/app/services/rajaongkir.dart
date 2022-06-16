import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class Ongkir {
  Future<dynamic> getAllCity() async {
    try {
      final url = Uri.parse("https://api.rajaongkir.com/starter/city");
      final response = await http.get(
        url,
        headers: {
          "key": "6cead2ace46bcf42eef01265e3387400",
        },
      );
      if (response.statusCode == 200) {
        return (json.decode(response.body));
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<dynamic> getCost({
    required String origin,
    required String destiantion,
    required int weight,
    required String courier,
  }) async {
    try {
      final url = Uri.parse("https://api.rajaongkir.com/starter/cost");
      const header = {
        "Content-Type": "application/json",
        "key": "6cead2ace46bcf42eef01265e3387400",
      };
      final body = json.encode({
        "origin": origin,
        "destination": destiantion,
        "weight": weight,
        "courier": courier,
      });
      final response = await http.post(url, headers: header, body: body);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
