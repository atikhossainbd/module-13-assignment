import 'package:http/http.dart' as http;

class DeleteProductApi {
  static Future<bool> deleteProduct(String productId) async {
    final url = 'https://crud.teamrabbil.com/api/v1/DeleteProduct/$productId';
    final uri = Uri.parse(url);

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return true;
      } else {
        print('Error: API call failed. Status: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      print('Error: Failed to delete product. $error');
      return false;
    }
  }
}