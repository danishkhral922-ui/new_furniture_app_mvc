import 'package:flutter/material.dart';
import 'package:new_furiniture_app_mvc/controllers/cart_controller.dart';
import 'package:new_furiniture_app_mvc/controllers/favourite_controller.dart';
import 'package:provider/provider.dart';
import 'package:new_furiniture_app_mvc/views/cart/cart.dart';

class Favourite extends StatelessWidget {
  const Favourite({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final cartProvider = context.read<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.search),
        title: const Text(
          'Favourite',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Cart()),
                );
              },
              child: Image.asset(
                'assets/images/cart.png',
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Consumer<FavouriteProvider>(
        builder: (context, favouriteProvider, child) {
          if (favouriteProvider.isLoading &&
              favouriteProvider.favouriteItems.isEmpty) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).iconTheme.color,
              ),
            );
          }

          if (favouriteProvider.favouriteItems.isEmpty) {
            return const Center(
              child: Text(
                'Your favorites list is empty',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            itemCount: favouriteProvider.favouriteItems.length,
            itemBuilder: (context, index) {
              final item = favouriteProvider.favouriteItems[index];
              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(item.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              item.price,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              favouriteProvider.removeFavourite(item.id);
                            },
                            child: Image.asset(
                              'assets/images/cancel.png',
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 30),
                          GestureDetector(
                            onTap: () async {
                              await cartProvider.addToCart(
                                name: item.name,
                                price: item.price,
                                image: item.image,
                              );
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Added To Cart'),
                                    backgroundColor: Colors.green,
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              }
                            },
                            child: Image.asset(
                              'assets/images/shoppingbag.png',
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Divider(
                    color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                    thickness: 2,
                  ),
                  const SizedBox(height: 10),
                ],
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        height: 50,
        width: 334,
        child: Consumer<FavouriteProvider>(
          builder: (context, favouriteProvider, child) {
            return FloatingActionButton(
              backgroundColor: isDarkMode ? Colors.white : Colors.black,
              onPressed: () async {
                if (favouriteProvider.favouriteItems.isEmpty) return;

                for (var item in favouriteProvider.favouriteItems) {
                  await cartProvider.addToCart(
                    name: item.name,
                    price: item.price,
                    image: item.image,
                  );
                }

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('All Products Added To Cart'),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Cart()),
                  );
                }
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Add all to my Cart',
                style: TextStyle(
                  color: isDarkMode ? Colors.black : Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
