import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:new_furiniture_app_mvc/controllers/bottomnav_controller.dart';
import 'package:new_furiniture_app_mvc/controllers/home_controller.dart';
import 'package:new_furiniture_app_mvc/controllers/product_controller.dart';
import 'package:new_furiniture_app_mvc/controllers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:new_furiniture_app_mvc/views/cart/cart.dart';
import 'package:new_furiniture_app_mvc/views/favourites/fovourites.dart';
import 'package:new_furiniture_app_mvc/views/notifications/notifications.dart';
import 'package:new_furiniture_app_mvc/views/product/add_product.dart';
import 'package:new_furiniture_app_mvc/views/product/edit_product.dart';
import 'package:new_furiniture_app_mvc/views/profile/profile.dart';
import 'package:new_furiniture_app_mvc/views/product/product.dart' as detail;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    final bottomNavProvider = context.watch<BottomNavProvider>();

    return Consumer<AppThemeProvider>(
      builder: (context, themeProvider, child) {
        final List<Widget> screens = [
          homeContent(context),
          const Favourite(),
          NotificationsScreen(),
          Profile(),
        ];

        return Scaffold(
          body: screens[bottomNavProvider.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: themeProvider.isLightMode
                ? Colors.white
                : Colors.grey[900],
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: bottomNavProvider.currentIndex,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: themeProvider.isLightMode
                ? Colors.black
                : Colors.white,
            unselectedItemColor: Colors.grey,
            onTap: (index) {
              bottomNavProvider.changeIndex(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  bottomNavProvider.currentIndex == 0
                      ? Icons.home
                      : Icons.home_outlined,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  bottomNavProvider.currentIndex == 1
                      ? Icons.favorite
                      : Icons.favorite_border,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  bottomNavProvider.currentIndex == 2
                      ? Icons.notifications
                      : Icons.notifications_none,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  bottomNavProvider.currentIndex == 3
                      ? Icons.person
                      : Icons.person_outline,
                ),
                label: '',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget homeContent(BuildContext context) {
    final themeProvider = Provider.of<AppThemeProvider>(context);
    final homeProvider = context.watch<HomeProvider>();

    return Scaffold(
      backgroundColor: themeProvider.isLightMode
          ? Colors.white
          : Colors.grey[900],
      floatingActionButton: FloatingActionButton(
        backgroundColor: themeProvider.isLightMode
            ? Colors.white
            : Colors.grey[800],
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProduct()),
          );
        },
        child: Icon(
          Icons.add,
          color: themeProvider.isLightMode ? Colors.black : Colors.white,
        ),
      ),
      appBar: AppBar(
        surfaceTintColor: themeProvider.isLightMode
            ? Colors.white
            : Colors.grey[900],
        backgroundColor: themeProvider.isLightMode
            ? Colors.white
            : Colors.grey[900],
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            setState(() {
              isSearching = !isSearching;
            });
            if (!isSearching) {
              context.read<HomeProvider>().updateSearchQuery('');
            }
          },
          child: Icon(
            isSearching ? Icons.close : Icons.search,
            color: themeProvider.isLightMode ? Colors.black : Colors.white,
          ),
        ),
        centerTitle: true,
        title: isSearching
            ? TextField(
                autofocus: true,
                onChanged: (value) =>
                    context.read<HomeProvider>().updateSearchQuery(value),
                style: TextStyle(
                  color: themeProvider.isLightMode
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
                      color: themeProvider.isLightMode
                          ? Colors.black
                          : Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isLightMode ? Icons.nights_stay : Icons.wb_sunny,
              color: themeProvider.isLightMode ? Colors.black : Colors.orange,
            ),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Cart()),
                );
              },
              child: Image.asset(
                'assets/images/cart.png',
                width: 24,
                height: 24,
                color: themeProvider.isLightMode ? null : Colors.white,
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
                  Icons.star_rounded,
                  'Popular',
                  context,
                  homeProvider,
                ),
                _buildCategoryItem(
                  Icons.chair_outlined,
                  'Chair',
                  context,
                  homeProvider,
                ),
                _buildCategoryItem(
                  Icons.table_restaurant_outlined,
                  'Table',
                  context,
                  homeProvider,
                ),
                _buildCategoryItem(
                  Icons.weekend_outlined,
                  'Armchair',
                  context,
                  homeProvider,
                ),
                _buildCategoryItem(
                  Icons.bed_outlined,
                  'Bed',
                  context,
                  homeProvider,
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Builder(
                builder: (context) {
                  if (homeProvider.isLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: themeProvider.isLightMode
                            ? Colors.black
                            : Colors.white,
                      ),
                    );
                  }

                  if (homeProvider.filteredProducts.isEmpty) {
                    return const Center(
                      child: Text(
                        'No Products Found',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    );
                  }

                  return GridView.builder(
                    itemCount: homeProvider.filteredProducts.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 20,
                          childAspectRatio: 0.62,
                          crossAxisCount: 2,
                        ),
                    itemBuilder: (context, index) {
                      final item = homeProvider.filteredProducts[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  detail.Product(product: item),
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
                                      color: themeProvider.isLightMode
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
                                            color: themeProvider.isLightMode
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
                                      color: themeProvider.isLightMode
                                          ? null
                                          : Colors.white,
                                    ),
                                  ),
                                  Positioned(
                                    top: 10,
                                    right: 10,
                                    child: GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            backgroundColor:
                                                themeProvider.isLightMode
                                                ? Colors.white
                                                : Colors.grey[900],
                                            title: Text(
                                              'Delete Product',
                                              style: TextStyle(
                                                color: themeProvider.isLightMode
                                                    ? Colors.black
                                                    : Colors.white,
                                              ),
                                            ),
                                            content: const Text(
                                              'Are you sure you want to delete this product?',
                                              style: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: Text(
                                                  'No',
                                                  style: TextStyle(
                                                    color:
                                                        themeProvider
                                                            .isLightMode
                                                        ? Colors.black
                                                        : Colors.white,
                                                  ),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  context
                                                      .read<ProductProvider>()
                                                      .deleteProduct(
                                                        context,
                                                        item.id,
                                                      );
                                                },
                                                child: const Text(
                                                  'Yes',
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      child: CircleAvatar(
                                        radius: 15,
                                        backgroundColor:
                                            themeProvider.isLightMode
                                            ? Colors.white70
                                            : Colors.black54,
                                        child: Icon(
                                          Icons.cancel_outlined,
                                          color: themeProvider.isLightMode
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
                                        context
                                            .read<ProductProvider>()
                                            .setEditFields(item);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EditProduct(
                                              productId: item.id,
                                              oldName: item.name,
                                              oldPrice: item.price.toString(),
                                              oldImage: item.image,
                                            ),
                                          ),
                                        );
                                      },
                                      child: CircleAvatar(
                                        radius: 15,
                                        backgroundColor:
                                            themeProvider.isLightMode
                                            ? Colors.white70
                                            : Colors.black54,
                                        child: Icon(
                                          Icons.edit,
                                          color: themeProvider.isLightMode
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
                                color: themeProvider.isLightMode
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
                                color: themeProvider.isLightMode
                                    ? Colors.black
                                    : Colors.white,
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
    IconData iconData,
    String label,
    BuildContext context,
    HomeProvider homeProvider,
  ) {
    final themeProvider = Provider.of<AppThemeProvider>(context);
    final bool isActive = homeProvider.selectedCategory == label;

    return GestureDetector(
      onTap: () {
        homeProvider.changeCategory(label);
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isActive
                  ? (themeProvider.isLightMode ? Colors.black : Colors.white)
                  : (themeProvider.isLightMode
                        ? Colors.grey[100]
                        : Colors.grey[800]),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              iconData,
              size: 26,
              color: isActive
                  ? (themeProvider.isLightMode ? Colors.white : Colors.black)
                  : Colors.grey[600],
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              color: isActive
                  ? (themeProvider.isLightMode ? Colors.black : Colors.white)
                  : Colors.grey,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
