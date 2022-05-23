import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class PaymentService {
  PaymentService._();
  static Future<Map<String, String>> createInvoice() async {
    final invoiceUrl =
        Uri.parse("https://paa-payment.herokuapp.com/api/v1/invoice");
    try {
      final body = json.encode({
        "given_names": "Ekooo",
        "email": "eko@gmail.com",
        "mobile_number": "+62988328121",
        "address": "Jl Mawar",
        "items": [
          {
            "name": "Laptop Asus ROG",
            "price": 20000000,
            "quantity": 2,
            "category": "Laptop",
          },
          {
            "name": "Laptop Lenovo Legion",
            "price": 22000000,
            "quantity": 1,
            "category": "Laptop",
          },
        ]
      });
      final response = await http.post(
        invoiceUrl,
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
        },
        body: body,
      );
      if (response.statusCode == 200) {
        log("Pesanan berhasil dibuat");
        final data = (json.decode(response.body) as Map<String, dynamic>)["data"];
        return {
          "id": data["id"],
          "invoice_url": data["invoice_url"],
        };
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
    return {};
  }
}
