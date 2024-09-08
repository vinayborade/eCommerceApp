import 'package:ecommerce_app/design-system/colors/index.dart';
import 'package:ecommerce_app/design-system/vb-text/index.dart';
import 'package:ecommerce_app/types/vb_typography_type.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  final Function(String, double, String, String, String) addProduct;

  const AddProductScreen({super.key, required this.addProduct});

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _title;
  String? _description;
  double? _price;
  String _image = 'https://i.pravatar.cc'; // Default image URL
  String _category = 'electronic'; // Default category

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        height: 55,
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            backgroundColor: VBColors.BUTTON_COLOR,
          ),
          child: const VBText(
            color: VBColors.BLACK,
            text: "Add Product",
            typographyType: VBTypographyType.BODY_M,
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              widget.addProduct(
                _title!,
                _price!,
                _description ?? '',
                _image,
                _category,
              );
              Navigator.pop(context);
            }
          },
        ),
      ),
      appBar: AppBar(
        backgroundColor: VBColors.COLOR_10,
        title: const VBText(
          text: "Add Product",
          typographyType: VBTypographyType.HEADING_L,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Product Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Product name is required';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _title = value;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Description'),
                  onSaved: (value) {
                    _description = value;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Price is required';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid price';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _price = double.tryParse(value!);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
