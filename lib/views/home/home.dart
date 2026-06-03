import 'package:flutter/material.dart';
import 'package:new_furiniture_app_mvc/controllers/bottomnav_controller.dart';
import 'package:new_furiniture_app_mvc/controllers/product_controller.dart';
import 'package:new_furiniture_app_mvc/models/product_model.dart';
import 'package:get/get.dart';
import 'package:new_furiniture_app_mvc/views/cart/cart.dart';
import 'package:new_furiniture_app_mvc/views/favourites/fovourites.dart';
import 'package:new_furiniture_app_mvc/views/notifications/notifications.dart';
import 'package:new_furiniture_app_mvc/views/product/add_product.dart';
import 'package:new_furiniture_app_mvc/views/profile/profile.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final BottomNavController controller = Get.put(BottomNavController());
  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      homeContent(),
      Favourite(),
      NotificationsScreen(),
      Profile(),
    ];

    return Obx(
      () => Scaffold(
        body: screens[controller.currentIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: controller.currentIndex.value,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            controller.currentIndex.value = index;
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                controller.currentIndex.value == 0
                    ? Icons.home
                    : Icons.home_outlined,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                controller.currentIndex.value == 1
                    ? Icons.favorite
                    : Icons.favorite_border,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                controller.currentIndex.value == 2
                    ? Icons.notifications
                    : Icons.notifications_none,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                controller.currentIndex.value == 3
                    ? Icons.person
                    : Icons.person_outline,
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }

  Widget homeContent() {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Get.to(AddProduct());
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.search, color: Colors.black),
        centerTitle: true,
        title: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Make Home',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              'BEAUTIFUL',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () {
                Get.to(Cart());
              },
              child: Image.asset(
                'assets/images/cart.png',
                width: 24,
                height: 24,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCategoryItem(
                  'assets/images/fav.png',
                  'Popular',
                  isSelected: true,
                ),
                _buildCategoryItem('assets/images/chair.png', 'Chair'),
                _buildCategoryItem('assets/images/table.png', 'Table'),
                _buildCategoryItem('assets/images/sofa.png', 'Armchair'),
                _buildCategoryItem('assets/images/bed.png', 'Bed'),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: StreamBuilder<List<ProductModel>>(
                stream: productController.productsStream,
                builder: (context, snapshots) {
                  if (snapshots.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.black),
                    );
                  }

                  if (!snapshots.hasData || snapshots.data!.isEmpty) {
                    return const Center(child: Text('No Products Found'));
                  }

                  var products = snapshots.data!;
                  return GridView.builder(
                    itemCount: products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 20,
                          childAspectRatio: 0.62,
                          crossAxisCount: 2,
                        ),
                    itemBuilder: (context, index) {
                      final item = products[index];
                      return GestureDetector(
                        onTap: () {
                          Get.to(
                            product(
                              image: item.image,
                              name: item.name,
                              price: item.price.toString(),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        item.image,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                              return const Center(
                                                child: Icon(
                                                  Icons.broken_image,
                                                  color: Colors.grey,
                                                  size: 40,
                                                ),
                                              );
                                            },
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    right: 10,
                                    child: Image.asset(
                                      'assets/images/shoppingbag2.png',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              item.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '\$${item.price}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(
    String imagePath,
    String label, {
    bool isSelected = false,
  }) {
    return Column(
      children: [
        Image.asset(imagePath, width: 40),
        const SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.grey,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget product({
    required String image,
    required String name,
    required String price,
  }) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              image,
              height: 200,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.broken_image, size: 100),
            ),
            const SizedBox(height: 20),
            Text(
              name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              '\$$price',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
