import 'package:flutter/material.dart';
import 'package:new_furiniture_app_mvc/controllers/cart_controller.dart';
import 'package:new_furiniture_app_mvc/controllers/favourite_controller.dart';
import 'package:provider/provider.dart';
import 'package:new_furiniture_app_mvc/models/product_model.dart';
import 'package:new_furiniture_app_mvc/views/cart/cart.dart';

class Product extends StatelessWidget {
  final ProductModel product;

  const Product({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageHeader(context, isDarkMode),
            const SizedBox(height: 25),
            _buildProductInfo(isDarkMode),
            const SizedBox(height: 50),
            _buildActionButtons(context, isDarkMode),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildImageHeader(BuildContext context, bool isDarkMode) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 380,
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.grey[900] : Colors.grey[100],
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(40),
            ),
          ),
          child: Image.network(product.image, fit: BoxFit.cover),
        ),
        Positioned(
          top: 50,
          left: 20,
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductInfo(bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '\$ ${product.price}',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            product.description.isNotEmpty
                ? product.description
                : 'Premium furniture for your home.',
            style: TextStyle(
              color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, bool isDarkMode) {
    final cartProvider = context.read<CartProvider>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Consumer<FavouriteProvider>(
            builder: (context, fav, _) {
              final isFav = fav.isFavourite(product.name);
              return GestureDetector(
                onTap: () => isFav
                    ? fav.removeFromFavourite(context, product.name)
                    : fav.addToFavourite(
                        name: product.name,
                        price: product.price.toString(),
                        image: product.image,
                      ),
                child: Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.grey[850] : Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    isFav ? Icons.favorite : Icons.favorite_border,
                    color: isFav
                        ? Colors.red
                        : (isDarkMode ? Colors.white : Colors.black),
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 15),
          Expanded(
            child: SizedBox(
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDarkMode ? Colors.white : Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  await cartProvider.addToCart(
                    name: product.name,
                    price: product.price,
                    image: product.image,
                  );
                  if (context.mounted)
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const Cart()),
                    );
                },
                child: Text(
                  'Add to cart',
                  style: TextStyle(
                    color: isDarkMode ? Colors.black : Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
