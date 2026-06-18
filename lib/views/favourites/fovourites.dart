import 'package:flutter/material.dart';
import 'package:new_furiniture_app_mvc/controllers/cart_controller.dart';
import 'package:new_furiniture_app_mvc/controllers/favourite_controller.dart';
import 'package:get/get.dart';
import 'package:new_furiniture_app_mvc/views/cart/cart.dart';

class Favourite extends StatelessWidget {
  Favourite({super.key});

  final FavouriteController favouriteController = Get.put(
    FavouriteController(),
  );
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

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
                Get.to(Cart());
              },
              child: Image.asset(
                'assets/images/cart.png',
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (favouriteController.isLoading.value &&
            favouriteController.favouriteItems.isEmpty) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).iconTheme.color,
            ),
          );
        }

        if (favouriteController.favouriteItems.isEmpty) {
          return const Center(
            child: Text(
              'Your favorites list is empty',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          itemCount: favouriteController.favouriteItems.length,
          itemBuilder: (context, index) {
            final item = favouriteController.favouriteItems[index];
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
                            favouriteController.removeFavourite(item.id);
                          },
                          child: Image.asset(
                            'assets/images/cancel.png',
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 30),
                        GestureDetector(
                          onTap: () async {
                            await cartController.addToCart(
                              name: item.name,
                              price: item.price,
                              image: item.image,
                            );
                            Get.snackbar(
                              'Success',
                              'Added To Cart',
                              backgroundColor: Colors.green,
                              colorText: Colors.white,
                            );
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
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        height: 50,
        width: 334,
        child: FloatingActionButton(
          backgroundColor: isDarkMode ? Colors.white : Colors.black,
          onPressed: () async {
            if (favouriteController.favouriteItems.isEmpty) return;

            for (var item in favouriteController.favouriteItems) {
              await cartController.addToCart(
                name: item.name,
                price: item.price,
                image: item.image,
              );
            }
            Get.snackbar(
              'Success',
              'All Products Added To Cart',
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
            Get.to(Cart());
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
        ),
      ),
    );
  }
}
