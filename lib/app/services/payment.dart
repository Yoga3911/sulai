import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class PaymentService {
  PaymentService._();

  static Future<Map<String, String>> createPayment({
    required int price,
    required String method,
    String? phone,
  }) async {
    final invoiceUrl =
        Uri.parse("https://paa-payment.herokuapp.com/api/v1/ewallet");
    try {
      String body = json.encode(
        {
          "price": price,
          "method": method,
        },
      );
      if (phone!.isNotEmpty) {
        phone = phone.replaceFirst("0", "+62");
        body = json.encode(
          {
            "price": price,
            "method": method,
            "phone": phone,
          },
        );
      }
      final response = await http.post(
        invoiceUrl,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: body,
      );
      if (response.statusCode == 200) {
        log("Pesanan berhasil dibuat");
        final data =
            (json.decode(response.body) as Map<String, dynamic>)["data"];
        switch (method) {
          case "ID_OVO":
            return {
              "id": data["id"],
              "checkout_url": "",
            };
          case "ID_SHOPEEPAY":
            return {
              "id": data["id"],
              "checkout_url": data["actions"]["mobile_deeplink_checkout_url"],
            };
          default:
            return {
              "id": data["id"],
              "checkout_url": data["actions"]["mobile_web_checkout_url"],
            };
        }
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
    return {};
  }

  static Future<String> getPayment({required String chargeId}) async {
    try {
      final ewalletUrl =
          Uri.parse("https://paa-payment.herokuapp.com/api/v1/ewallet/get");
      const header = {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };
      final body = jsonEncode(
        {
          "charge_id": chargeId,
        },
      );
      final response = await http.post(
        ewalletUrl,
        headers: header,
        body: body,
      );
      if (response.statusCode == 200) {
        return (jsonDecode(response.body) as Map<String, dynamic>)["data"]
            ["status"];
      }
      return "";
    } on Exception catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
