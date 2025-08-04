import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class StripeService {
  static Future<void> startCheckout(double price, String name) async {
    try {
      final url = Uri.parse(
        'https://us-central1-simpleecommerceapp-bcb89.cloudfunctions.net/createCheckoutSession',
      );

      final response = await http.post(
        url,
        body: json.encode({'price': price, 'name': name}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode != 200) {
        print('Stripe error: ${response.body}');
        return;
      }

      final jsonResponse = jsonDecode(response.body);
      final sessionId = jsonResponse['id'];

      final checkoutUrl = 'https://checkout.stripe.com/pay/$sessionId';
      final uri = Uri.parse(checkoutUrl);
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw 'Could not launch checkout URL';
      }
    } catch (e) {
      print('Checkout failed: $e');
    }
  }
}
