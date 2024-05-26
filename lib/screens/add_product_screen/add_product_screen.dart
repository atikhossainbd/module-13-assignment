import 'package:crud_app/models/product_item.dart';
import 'package:crud_app/screens/add_product_screen/services/add_product_api.dart';
import 'package:crud_app/util/custom_snackbar.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _productNameTEController =
      TextEditingController();
  final TextEditingController _productCodeTEController =
      TextEditingController();
  final TextEditingController _productImageTEController =
      TextEditingController();
  final TextEditingController _productUnitPriceTEController =
      TextEditingController();
  final TextEditingController _productQtyTEController = TextEditingController();
  final TextEditingController _productTotalPriceTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildTextFormField(
                    "Product Name", "Product Name", _productNameTEController),
                const SizedBox(height: 20),
                _buildTextFormField(
                    "Product Code", "Product Code", _productCodeTEController),
                const SizedBox(height: 20),
                _buildTextFormField(
                    "Product Image", "Image Url", _productImageTEController),
                const SizedBox(height: 20),
                _buildTextFormField(
                    "Unit Price", "Unit Price", _productUnitPriceTEController),
                const SizedBox(height: 20),
                _buildTextFormField("Qty", "Qty", _productQtyTEController),
                const SizedBox(height: 20),
                _buildTextFormField(
                    "Total Price", "Total Price", _productTotalPriceTEController),
                const SizedBox(height: 20),
                isLoading ? const CircularProgressIndicator() : ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
                        bool isSuccess = await AddProduct.updateProduct(
                          ProductItem(
                              productName: _productNameTEController.text,
                              productCode: _productCodeTEController.text,
                              img: _productImageTEController.text,
                              unitPrice: _productUnitPriceTEController.text,
                              qty: _productQtyTEController.text,
                              totalPrice: _productTotalPriceTEController.text),
                        );

                        if(isSuccess){
                          isLoading = false;
                          Util.mySnackBar("Product Added", context);
                          clearTextField();
                          setState(() {});
                        } else{
                          isLoading = false;
                          Util.mySnackBar("Something Went Wrong", context);
                          setState(() {});
                        }
                      }
                    },
                    child: const Text('Add')),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(
      String title, String hint, TextEditingController textEditingController) {
    return TextFormField(
      controller: textEditingController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        label: Text(title),
        hintText: hint,
      ),
      validator: (String? value) {
        if (value == null || value.trim().isEmpty) {
          return 'Write your product Name';
        }
        return null;
      },
    );
  }

  @override
  void dispose() {
    _productNameTEController.dispose();
    _productCodeTEController.dispose();
    _productImageTEController.dispose();
    _productUnitPriceTEController.dispose();
    _productQtyTEController.dispose();
    _productTotalPriceTEController.dispose();
    super.dispose();
  }

  void clearTextField(){
    _productNameTEController.clear();
    _productCodeTEController.clear();
    _productImageTEController.clear();
    _productUnitPriceTEController.clear();
    _productQtyTEController.clear();
    _productTotalPriceTEController.clear();
  }

}
