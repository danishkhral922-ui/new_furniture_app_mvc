import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:new_furiniture_app_mvc/controllers/bottomnav_controller.dart';
import 'package:new_furiniture_app_mvc/controllers/product_controller.dart';
import 'package:new_furiniture_app_mvc/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:new_furiniture_app_mvc/controllers/theme_provider.dart';
import 'package:new_furiniture_app_mvc/views/cart/cart.dart';
import 'package:new_furiniture_app_mvc/views/favourites/fovourites.dart';
import 'package:new_furiniture_app_mvc/views/notifications/notifications.dart';
import 'package:new_furiniture_app_mvc/views/product/add_product.dart';
import 'package:new_furiniture_app_mvc/views/product/edit_product.dart';
import 'package:new_furiniture_app_mvc/views/profile/profile.dart';
import 'package:new_furiniture_app_mvc/views/product/product.dart' as detail;

class Home extends StatelessWidget {
  Home({super.key});

  final BottomNavController controller = Get.put(BottomNavController());
  final ProductController productController = Get.put(ProductController());
  final HomeController homeController = Get.put(
    HomeController(),
    permanent: true,
  );
  final RxBool isSearching = false.obs;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppthemeProvider>(
      builder: (context, themeProvider, child) {
        final List<Widget> screens = [
          homeContent(context),
          Favourite(),
          NotificationsScreen(),
          Profile(),
        ];

        return Obx(
          () => Scaffold(
            body: screens[controller.currentIndex.value],
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: themeProvider.islightMode
                  ? Colors.white
                  : Colors.grey[900],
              showSelectedLabels: false,
              showUnselectedLabels: false,
              currentIndex: controller.currentIndex.value,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: themeProvider.islightMode
                  ? Colors.black
                  : Colors.white,
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
      },
    );
  }

  Widget homeContent(BuildContext context) {
    final themeProvider = Provider.of<AppthemeProvider>(context);

    return Scaffold(
      backgroundColor: themeProvider.islightMode
          ? Colors.white
          : Colors.grey[900],
      floatingActionButton: FloatingActionButton(
        backgroundColor: themeProvider.islightMode
            ? Colors.white
            : Colors.grey[800],
        onPressed: () {
          Get.to(AddProduct());
        },
        child: Icon(
          Icons.add,
          color: themeProvider.islightMode ? Colors.black : Colors.white,
        ),
      ),
      appBar: AppBar(
        surfaceTintColor: themeProvider.islightMode
            ? Colors.white
            : Colors.grey[900],
        backgroundColor: themeProvider.islightMode
            ? Colors.white
            : Colors.grey[900],
        elevation: 0,
        leading: Obx(
          () => GestureDetector(
            onTap: () {
              isSearching.value = !isSearching.value;
              if (!isSearching.value) {
                homeController.filterProducts('');
              }
            },
            child: Icon(
              isSearching.value ? Icons.close : Icons.search,
              color: themeProvider.islightMode ? Colors.black : Colors.white,
            ),
          ),
        ),
        centerTitle: true,
        title: Obx(
          () => isSearching.value
              ? TextField(
                  autofocus: true,
                  onChanged: (value) => homeController.filterProducts(value),
                  style: TextStyle(
                    color: themeProvider.islightMode
                        ? Colors.black
                        : Colors.white,
                    fontSize: 16,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Search furniture...',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
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
                        color: themeProvider.islightMode
                            ? Colors.black
                            : Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
        ),
        actions: [
          // Theme Switch Button (Suraj/Chaand Icon)
          IconButton(
            icon: Icon(
              themeProvider.islightMode ? Icons.nights_stay : Icons.wb_sunny,
              color: themeProvider.islightMode ? Colors.black : Colors.orange,
            ),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
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
                color: themeProvider.islightMode ? null : Colors.white,
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
                _buildCategoryItem(Icons.star_rounded, 'Popular', context),
                _buildCategoryItem(Icons.chair_outlined, 'Chair', context),
                _buildCategoryItem(
                  Icons.table_restaurant_outlined,
                  'Table',
                  context,
                ),
                _buildCategoryItem(Icons.weekend_outlined, 'Armchair', context),
                _buildCategoryItem(Icons.bed_outlined, 'Bed', context),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Obx(() {
                if (homeController.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: themeProvider.islightMode
                          ? Colors.black
                          : Colors.white,
                    ),
                  );
                }

                if (homeController.filteredProducts.isEmpty) {
                  return const Center(
                    child: Text(
                      'No Products Found',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                }

                return GridView.builder(
                  itemCount: homeController.filteredProducts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.62,
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    final item = homeController.filteredProducts[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => detail.Product(product: item));
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
                                    color: themeProvider.islightMode
                                        ? Colors.grey[200]
                                        : Colors.grey[800],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: CachedNetworkImage(
                                      width: double.infinity,
                                      height: double.infinity,
                                      imageUrl: item.image,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator(
                                          color: themeProvider.islightMode
                                              ? Colors.black
                                              : Colors.white,
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Center(
                                            child: Icon(
                                              Icons.broken_image,
                                              color: Colors.grey,
                                              size: 40,
                                            ),
                                          ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  right: 10,
                                  child: Image.asset(
                                    'assets/images/shoppingbag2.png',
                                    color: themeProvider.islightMode
                                        ? null
                                        : Colors.white,
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.defaultDialog(
                                        title: 'Delete Product',
                                        titleStyle: TextStyle(
                                          color: themeProvider.islightMode
                                              ? Colors.black
                                              : Colors.white,
                                        ),
                                        backgroundColor:
                                            themeProvider.islightMode
                                            ? Colors.white
                                            : Colors.grey[900],
                                        middleTextStyle: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                        middleText:
                                            'Are you sure you want to delete this product?',
                                        textConfirm: 'Yes',
                                        textCancel: 'No',
                                        confirmTextColor:
                                            themeProvider.islightMode
                                            ? Colors.white
                                            : Colors.black,
                                        buttonColor: themeProvider.islightMode
                                            ? Colors.black
                                            : Colors.white,
                                        cancelTextColor:
                                            themeProvider.islightMode
                                            ? Colors.black
                                            : Colors.white,
                                        onConfirm: () {
                                          Get.back();
                                          productController.deleteProduct(
                                            item.id,
                                          );
                                        },
                                        onCancel: () {
                                          Get.back();
                                        },
                                      );
                                    },
                                    child: CircleAvatar(
                                      radius: 15,
                                      backgroundColor: themeProvider.islightMode
                                          ? Colors.white70
                                          : Colors.black54,
                                      child: Icon(
                                        Icons.cancel_outlined,
                                        color: themeProvider.islightMode
                                            ? Colors.black
                                            : Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  left: 10,
                                  child: GestureDetector(
                                    onTap: () {
                                      productController.SetEditfields(item);
                                      Get.to(
                                        EditProduct(
                                          productId: item.id,
                                          oldName: item.name,
                                          oldPrice: item.price.toString(),
                                          oldImage: item.image,
                                        ),
                                      );
                                    },
                                    child: CircleAvatar(
                                      radius: 15,
                                      backgroundColor: themeProvider.islightMode
                                          ? Colors.white70
                                          : Colors.black54,
                                      child: Icon(
                                        Icons.edit,
                                        color: themeProvider.islightMode
                                            ? Colors.black
                                            : Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            item.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: themeProvider.islightMode
                                  ? Colors.black
                                  : Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '\$${item.price}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: themeProvider.islightMode
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(
    IconData iconData,
    String label,
    BuildContext context,
  ) {
    final themeProvider = Provider.of<AppthemeProvider>(context);
    return Obx(() {
      final bool isActive = homeController.selectedCategory.value == label;
      return GestureDetector(
        onTap: () {
          homeController.changeCategory(label);
        },
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isActive
                    ? (themeProvider.islightMode ? Colors.black : Colors.white)
                    : (themeProvider.islightMode
                          ? Colors.grey[100]
                          : Colors.grey[800]),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                iconData,
                size: 26,
                color: isActive
                    ? (themeProvider.islightMode ? Colors.white : Colors.black)
                    : Colors.grey[600],
              ),
            ),
            const SizedBox(height: 5),
            Text(
              label,
              style: TextStyle(
                color: isActive
                    ? (themeProvider.islightMode ? Colors.black : Colors.white)
                    : Colors.grey,
                fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    });
  }
}
