import 'dart:convert';
import 'package:crud_app/models/product_item.dart';
import 'package:http/http.dart' as http;

class ProductApi {
  static Future<List<ProductItem>> getAllProduct() async {
    const url = 'https://crud.teamrabbil.com/api/v1/ReadProduct';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    final body = response.body;
    final json = jsonDecode(body);
    final result = json['data'] as List<dynamic>;

    final transformed = result.map((data) {
      return ProductItem.formMap(data);
    }).toList();

    return transformed;
  }
} // UserApi end here ==============