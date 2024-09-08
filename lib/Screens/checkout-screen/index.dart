import 'package:ecommerce_app/Screens/home-Page/index.dart';
import 'package:ecommerce_app/VOs/products_vo.dart';
import 'package:ecommerce_app/design-system/colors/index.dart';
import 'package:ecommerce_app/design-system/vb-text/index.dart';
import 'package:ecommerce_app/types/vb_typography_type.dart';
import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  final List<Product> cart;
  CheckoutScreen({super.key, required this.cart});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();

  // User input fields
  String _name = '';
  String _email = '';

  // Calculate total price of all products in cart
  double getTotalPrice() {
    return widget.cart.fold(0, (sum, item) => sum + item.price);
  }

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
            text: "Checkout",
            typographyType: VBTypographyType.BODY_M,
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();

              // Proceed with checkout
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Checkout successful for $_name!'),
                ),
              );

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            }
          },
        ),
      ),
      appBar: AppBar(
        backgroundColor: VBColors.COLOR_10,
        title: const VBText(
          text: "Checkout",
          typographyType: VBTypographyType.HEADING_L,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const VBText(
                text: 'Your Order',
                typographyType: VBTypographyType.HEADING_M,
                color: VBColors.COLOR_10,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.cart.length,
                  itemBuilder: (context, index) {
                    final product = widget.cart[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(5),
                        tileColor: VBColors.COLOR_10,
                        leading:
                            Image.network(product.image, width: 50, height: 50),
                        title: SizedBox(width: 150, child: Text(product.title)),
                        subtitle: Text('₹ ${product.price.toStringAsFixed(2)}'),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Total: ₹ ${getTotalPrice().toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const VBText(
                text: 'Guest Details',
                typographyType: VBTypographyType.HEADING_M,
                color: VBColors.COLOR_10,
              ),
              const SizedBox(height: 10),
              // Name field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              const SizedBox(height: 10),
              // Email field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null ||
                      !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),

              const SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
    );
  }
}
