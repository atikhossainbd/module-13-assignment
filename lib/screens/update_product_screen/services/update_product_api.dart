import 'dart:convert';
import 'package:crud_app/models/product_item.dart';
import 'package:http/http.dart' as http;

class UpdateProductApi {
  static Future<bool> updateProduct(ProductItem product) async {
    final url = 'https://crud.teamrabbil.com/api/v1/UpdateProduct/${product.id}';
    final uri = Uri.parse(url);

    final body = jsonEncode(product.toJson());

    try {
      final response = await http.post(
        uri,
        body: body,
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return true;
      } else {
        print('Error: API call failed. Status: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      print('Error: Failed to update product. $error');
      return false;
    }
  }
}
