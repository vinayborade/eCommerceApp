import 'package:ecommerce_app/Screens/checkout-screen/index.dart';
import 'package:ecommerce_app/VOs/products_vo.dart';
import 'package:ecommerce_app/design-system/colors/index.dart';
import 'package:ecommerce_app/design-system/vb-text/index.dart';
import 'package:ecommerce_app/types/vb_typography_type.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  final List<Product> cart;
  CartScreen({super.key, required this.cart});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Visibility(
        visible: widget.cart.isNotEmpty,
        child: SizedBox(
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
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CheckoutScreen(
                          cart: widget.cart,
                        )),
              );
            },
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: VBColors.COLOR_10,
        title: const VBText(
          text: "Cart",
          typographyType: VBTypographyType.HEADING_L,
        ),
      ),
      body: widget.cart.isNotEmpty
          ? ListView.builder(
              itemCount: widget.cart.length,
              itemBuilder: (context, index) {
                final product = widget.cart[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(5),
                    tileColor: VBColors.COLOR_10,
                    title: Row(
                      children: [
                        Image.network(product.image, width: 50, height: 50),
                        const SizedBox(width: 15),
                        SizedBox(
                          child: Text(product.title),
                          width: 150,
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.remove_shopping_cart),
                      onPressed: () {
                        (context as Element)
                            .markNeedsBuild(); // To force widget rebuild after removing
                        (context.findAncestorStateOfType<State<CartScreen>>()
                                as State<dynamic>)
                            .setState(() {
                          widget.cart.remove(product); // Remove the product
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text('${product.title} removed from cart!')),
                        );
                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
              },
            )
          : const Center(
              child: VBText(
              text: 'Your cart is empty',
              typographyType: VBTypographyType.HEADING_L,
              color: VBColors.ALEART_COLOR,
            )),
    );
  }
}
