import 'package:crud_app/models/product_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddProduct {
  static Future<bool> updateProduct(ProductItem productItem) async {
    const url = 'https://crud.teamrabbil.com/api/v1/CreateProduct';
    final uri = Uri.parse(url);

    try{
      final json = jsonEncode(productItem.toJson());
      final response = await http.post(
        uri,
        body: json,
        headers: {"Content-Type": "application/json"},
      );
      if(response.statusCode == 200){
        return true;
      } else {
        return false;
      }
    } catch (error){
      return false;
    }

  }
} // UserApi end here ==============
