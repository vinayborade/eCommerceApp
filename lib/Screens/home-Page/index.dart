import 'package:ecommerce_app/Screens/add-product/index.dart';
import 'package:ecommerce_app/Screens/cart-screen/index.dart';
import 'package:ecommerce_app/VOs/products_vo.dart';
import 'package:ecommerce_app/design-system/colors/index.dart';
import 'package:ecommerce_app/design-system/vb-text-style/index.dart';
import 'package:ecommerce_app/design-system/vb-text/index.dart';
import 'package:ecommerce_app/types/vb_typography_type.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

List<Product> products = [];
List<Product> filteredProducts = [];
List<Product> _cart = []; // Cart to hold selected products
TextEditingController searchController = TextEditingController();

class _HomePageState extends State<HomePage> {
  void addToCart(Product product) {
    setState(() {
      if (!_cart.contains(product)) {
        _cart.add(product);
      }
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Added to Cart'),
          content: Text('${product.title} has been added to your cart.'),
          actions: [
            TextButton(
              child: const Text('Continue Shopping'),
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Close the dialog and continue shopping
              },
            ),
            TextButton(
              child: const Text('View Cart'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CartScreen(cart: _cart), // Navigate to the cart screen
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void removeFromCart(Product product) {
    setState(() {
      _cart.remove(product);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${product.title} removed from cart!')),
    );
  }

  // Function to add product
  Future<void> addProduct(String title, double price, String description,
      String image, String category) async {
    final response = await http.post(
      Uri.parse('https://fakestoreapi.com/products'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'title': title,
        'price': price,
        'description': description,
        'image': image,
        'category': category,
      }),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      // Add the new product to the list and update the state
      setState(() {
        products.add(Product.fromJson(
            jsonResponse)); // Assuming you have a Product model
      });

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product added successfully!')),
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add product!')),
      );
    }
  }

  Future<void> fetchProducts({String sort = 'asc'}) async {
    final response = await http
        .get(Uri.parse('https://fakestoreapi.com/products?sort=$sort'));

    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      List<Product> fetchedProducts =
          jsonResponse.map((data) => Product.fromJson(data)).toList();
      setState(() {
        products = fetchedProducts;
        filteredProducts = products; // Start with the full product list
      });
    } else {
      throw Exception('Failed to load products');
    }
  }

  Widget _buildSortButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            fetchProducts(sort: 'asc'); // Fetch products in ascending order
          },
          child: const VBText(
            text: "Sort Ascending",
            typographyType: VBTypographyType.BODY_M,
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            fetchProducts(sort: 'desc'); // Fetch products in descending order
          },
          child: const VBText(
            text: "Sort Descending",
            typographyType: VBTypographyType.BODY_M,
          ),
        ),
      ],
    );
  }

  Future<void> deleteProduct(int productId) async {
    final response = await http.delete(
      Uri.parse('https://fakestoreapi.com/products/$productId'),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      print("Product deleted: $jsonResponse");

      setState(() {
        products
            .removeWhere((product) => product.id == productId); // Update list
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product deleted successfully!')),
      );
    } else {
      print("Failed to delete product");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete product!')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  // Search products by name
  void searchProducts(String query) {
    final results = products.where((product) {
      final titleLower = product.title.toLowerCase();
      final searchLower = query.toLowerCase();
      return titleLower.contains(searchLower); // Filter by product name
    }).toList();

    setState(() {
      if (results.isEmpty) {
        filteredProducts = [];

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: VBText(
              text: 'No products found matching "$query"',
              typographyType: VBTypographyType.BODY_M,
            ),
            backgroundColor: Colors.red, // Change the color here
            behavior: SnackBarBehavior.floating, // Optional: floating SnackBar
          ),
        );
      } else {
        // Display filtered results
        filteredProducts = results;
      }
    });
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(20),
      width: double.infinity,
      height: 58,
      child: TextField(
        controller: searchController,
        onChanged: (value) {
          setState(() {
            searchProducts(value.trim());
          });
        },
        style: VBTextStyle.get(
          typographyType: VBTypographyType.BODY_M,
          color: VBColors.WHITE.withOpacity(0.5),
        ),
        cursorColor: VBColors.WHITE.withOpacity(0.5),
        decoration: InputDecoration(
          fillColor: const Color.fromRGBO(37, 37, 47, 1),
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
          hintText: "Search products",
          hintStyle: VBTextStyle.get(
              typographyType: VBTypographyType.BODY_M,
              color: VBColors.WHITE.withOpacity(0.5)),
          prefixIcon: Container(
            padding: const EdgeInsets.all(15),
            child: const Icon(Icons.search),
          ),
        ),
      ),
    );
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
            text: "Add new Product",
            typographyType: VBTypographyType.BODY_M,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddProductScreen(
                        addProduct: addProduct,
                      )),
            );
          },
        ),
      ),
      appBar: AppBar(
        backgroundColor: VBColors.COLOR_10,
        title: const VBText(
          text: "Dashboard",
          typographyType: VBTypographyType.HEADING_L,
        ),
        actions: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(cart: _cart),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSearchBar(), // Search bar
            _buildSortButtons(), // Sorting buttons
            filteredProducts.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: _buildProductsTable(),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductsTable() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 60),
      child: Column(
        children: [
          ...products.map(
            (e) {
              return Card(
                margin: const EdgeInsets.all(10),
                color: VBColors.COLOR_10,
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.network(
                            e.image,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 150,
                                child: VBText(
                                  text: e.title,
                                  typographyType: VBTypographyType.HEADING_M,
                                ),
                              ),
                              const SizedBox(height: 10),
                              VBText(
                                text: 'Price: ₹ ${e.price.toStringAsFixed(2)}',
                                typographyType: VBTypographyType.BODY_M,
                              ),
                              VBText(
                                text: 'Category: ${e.category}',
                                typographyType: VBTypographyType.BODY_M,
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Actions (Delete and Add to Cart)
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: VBText(
                                      text:
                                          'Are you sure you want to delete ${e.title}?',
                                      typographyType:
                                          VBTypographyType.HEADING_M,
                                      color: VBColors.ALEART_COLOR,
                                    ),
                                    actions: [
                                      TextButton(
                                        child: const Text('NO'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: const Text('Yes'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          deleteProduct(
                                              e.id); // Delete the product
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.add_shopping_cart),
                            onPressed: () {
                              addToCart(e); // Add the product to the cart
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${e.title} added to cart!'),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );

    // Container(
    //   height: MediaQuery.of(context).size.height * 0.7,
    //   margin: const EdgeInsets.only(left: 10, top: 20),
    //   color: VBColors.COLOR_10,
    //   padding: const EdgeInsets.all(20),
    //   child: SingleChildScrollView(
    //     child: SingleChildScrollView(
    //       scrollDirection: Axis.horizontal,
    //       child: DataTable(
    //         columns: const [
    //           DataColumn(label: Text('Actions')),
    //           DataColumn(label: Text('Image')),
    //           DataColumn(label: Text('ID')),
    //           DataColumn(label: Text('Product name')),
    //           DataColumn(label: Text('Price')),
    //           DataColumn(label: Text('Category')),
    //         ],
    //         rows: filteredProducts.map((product) {
    //           return DataRow(
    //             cells: [
    //               DataCell(Row(
    //                 children: [
    //                   InkWell(
    //                     child: const Icon(Icons.delete),
    //                     onTap: () {
    //                       showDialog(
    //                         context: context,
    //                         builder: (BuildContext context) {
    //                           return AlertDialog(
    //                             title: VBText(
    //                               text:
    //                                   'Are you sure you want to delete this ${product.title}?',
    //                               typographyType: VBTypographyType.HEADING_M,
    //                               color: VBColors.ALEART_COLOR,
    //                             ),
    //                             actions: [
    //                               TextButton(
    //                                 child: const Text('NO'),
    //                                 onPressed: () {
    //                                   Navigator.of(context)
    //                                       .pop(); // Close the dialog and continue shopping
    //                                 },
    //                               ),
    //                               TextButton(
    //                                 child: const Text('Yes'),
    //                                 onPressed: () {
    //                                   Navigator.of(context)
    //                                       .pop(); // Close the dialog
    //                                   deleteProduct(
    //                                       product.id); // Deletes the product
    //                                 },
    //                               ),
    //                             ],
    //                           );
    //                         },
    //                       );
    //                     },
    //                   ),
    //                   const SizedBox(width: 10), // Spacer between icons
    //                   InkWell(
    //                     child: const Icon(Icons.add_shopping_cart),
    //                     onTap: () {
    //                       addToCart(product); // Adds the product to the cart
    //                     },
    //                   ),
    //                 ],
    //               )),
    //               DataCell(
    //                 Image.network(product.image, width: 50, height: 50),
    //               ),
    //               DataCell(VBText(
    //                 text: product.id.toString(),
    //                 typographyType: VBTypographyType.BODY_M,
    //               )),
    //               DataCell(InkWell(
    //                 child: VBText(
    //                   text: product.title,
    //                   typographyType: VBTypographyType.BODY_M,
    //                 ),
    //                 onTap: () {
    //                   addToCart(
    //                       product); // Clicking the product name adds it to the cart
    //                   ScaffoldMessenger.of(context).showSnackBar(
    //                     SnackBar(
    //                         content: Text('${product.title} added to cart!')),
    //                   );
    //                 },
    //               )),
    //               DataCell(VBText(
    //                 text: '₹ ${product.price.toStringAsFixed(2)}',
    //                 typographyType: VBTypographyType.BODY_M,
    //               )),
    //               DataCell(VBText(
    //                 text: product.category,
    //                 typographyType: VBTypographyType.BODY_M,
    //               )),
    //             ],
    //           );
    //         }).toList(),
    //       ),
    //     ),
    //   ),
    // );
  }
}
