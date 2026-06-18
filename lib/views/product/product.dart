import 'package:flutter/material.dart';
import 'package:new_furiniture_app_mvc/controllers/cart_controller.dart';
import 'package:new_furiniture_app_mvc/controllers/favourite_controller.dart';
import 'package:new_furiniture_app_mvc/models/product_model.dart';
import 'package:new_furiniture_app_mvc/views/cart/cart.dart';
import 'package:get/get.dart';

class Product extends StatelessWidget {
  final ProductModel product;

  Product({super.key, required this.product});

  final CartController controller = Get.put(CartController());
  final FavouriteController favouriteController = Get.put(
    FavouriteController(),
  );

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                // Top Image Container with Banner Arc
                Container(
                  width: screenWidth,
                  height: 380,
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.grey[900] : Colors.grey[100],
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                    ),
                    child: Image.network(
                      product.image,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: isDarkMode
                              ? Colors.grey[850]
                              : Colors.grey[200],
                          child: const Center(
                            child: Icon(
                              Icons.image_not_supported,
                              size: 50,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // Floating Back Arrow Button
                Positioned(
                  top: 50,
                  left: 20,
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: isDarkMode ? Colors.grey[850] : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 16,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),

            // Product Name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                product.name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Price & Static Quantity Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$ ${product.price}',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    'Quantity: 1',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),

            // Rating & Reviews Indicator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 22),
                  const SizedBox(width: 5),
                  Text(
                    '4.5',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '(50 reviews)',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Description Box
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                product.description.isNotEmpty
                    ? product.description
                    : 'This product is made of high-quality materials and designed to provide both comfort and style. It features a modern design that will complement and enhance the look of any room.',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 50),

            // Bottom Action Bar (Favorite & Add To Cart Button)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Obx(() {
                    final isFav = favouriteController.isFavourite(product.name);
                    return GestureDetector(
                      onTap: () async {
                        if (isFav) {
                          await favouriteController.removeFromFavourite(
                            product.name,
                          );
                          Get.snackbar(
                            'Removed',
                            'Removed From Favourites',
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                            snackPosition: SnackPosition.TOP,
                          );
                        } else {
                          await favouriteController.addToFavourite(
                            name: product.name,
                            price: product.price.toString(),
                            image: product.image,
                          );
                          Get.snackbar(
                            'Success',
                            'Added To Favourites',
                            backgroundColor: Colors.green,
                            colorText: Colors.white,
                            snackPosition: SnackPosition.TOP,
                          );
                        }
                      },
                      child: Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? Colors.grey[850]
                              : Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: isFav
                              ? Colors.red
                              : (isDarkMode ? Colors.white : Colors.black),
                          size: 26,
                        ),
                      ),
                    );
                  }),
                  const SizedBox(width: 15),
                  Expanded(
                    child: SizedBox(
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDarkMode
                              ? Colors.white
                              : Colors.black,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () async {
                          await controller.addToCart(
                            name: product.name,
                            price: product.price,
                            image: product.image,
                          );
                          Get.snackbar(
                            'Success',
                            'Product Added To Cart',
                            backgroundColor: Colors.green,
                            colorText: Colors.white,
                            snackPosition: SnackPosition.TOP,
                          );
                          Get.to(() => Cart());
                        },
                        child: Text(
                          'Add to cart',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.black : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
