import 'package:crud_app/models/product_item.dart';
import 'package:crud_app/screens/add_product_screen/add_product_screen.dart';
import 'package:crud_app/screens/product_screen/services/api.dart';
import 'package:crud_app/screens/product_screen/services/delete_product.dart';
import 'package:crud_app/screens/update_product_screen/update_product_screen.dart';
import 'package:crud_app/util/custom_snackbar.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ProductScreen> {
  List<ProductItem> productItem = [];
  bool _isProductLoading = false;

  @override
  void initState() {
    super.initState();
    getAllProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crud Application'),
        elevation: 1,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          const Duration(seconds: 2);
          getAllProduct();
          setState(() {});
        },
        child: _isProductLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.separated(
                itemCount: productItem.length,
                itemBuilder: (context, index) {
                  return _buildProductItem(productItem[index]);
                },
                separatorBuilder: (_, __) => const Divider(),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddProductScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildProductItem(ProductItem productItem) {
    return ListTile(
      leading:
          productItem.img.isNotEmpty && productItem.img.startsWith("https://")
              ? Image.network(
                  productItem.img,
                  width: 60,
                  fit: BoxFit.cover,
                )
              : const Text("No Image"),
      title: Text(productItem.productName),
      subtitle: Wrap(
        children: [
          Text(
            "Unit Price: ${productItem.unitPrice}",
            style: const TextStyle(fontSize: 12),
          ),
          const SizedBox(width: 5),
          Text(
            "Qty: ${productItem.qty}",
            style: const TextStyle(fontSize: 12),
          ),
          const SizedBox(width: 5),
          Text(
            "Total Price: ${productItem.totalPrice}",
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      UpdateProductScreen(productItem: productItem),
                ),
              );
              if (result == true){
                Util.mySnackBar("Product Updated", context);
                getAllProduct();
              }
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              _showDeleteDialog(productItem.id!);
            },
            icon: const Icon(Icons.delete),
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  // get data
  Future<void> getAllProduct() async {
    _isProductLoading = true;
    setState(() {});
    final response = await ProductApi.getAllProduct();
    _isProductLoading = false;
    if (response.isNotEmpty) {
      productItem = response;
    } else {
      print("No data found");
    }
    setState(() {});
  }

  void _showDeleteDialog(String productId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete Product"),
          content:
              Text("Are your sure that your want to delete this product ?"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel")),
            TextButton(
                onPressed: () async {
                  bool isSucces =
                      await DeleteProductApi.deleteProduct(productId);
                  if (isSucces) {
                    Navigator.pop(context);
                    Util.mySnackBar("Delete Success", context);
                    getAllProduct();
                  } else {
                    Navigator.pop(context);
                    Util.mySnackBar("Something Wrong", context);
                  }
                },
                child: const Text("Yes"))
          ],
        );
      },
    );
  }
}
