import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class PaymentService {
  PaymentService._();
  static Future<Map<String, String>> createInvoice({
    required int price,
    required String method,
  }) async {
    final invoiceUrl =
        Uri.parse("https://paa-payment.herokuapp.com/api/v1/ewallet");
    try {
      final body = json.encode(
        {
          "price": price,
          "method": method,
        },
      );
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
        return {
          "id": data["id"],
          "checkout_url": data["actions"]["mobile_web_checkout_url"],
        };
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
    return {};
  }
}
