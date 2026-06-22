import 'package:flutter/material.dart';
import 'package:new_furiniture_app_mvc/controllers/favourite_controller.dart';
import 'package:provider/provider.dart';

class Favourite extends StatelessWidget {
  const Favourite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favourite'), centerTitle: true),
      body: Consumer<FavouriteProvider>(
        builder: (context, favProvider, child) {
          if (favProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (favProvider.favouriteItems.isEmpty) {
            return const Center(child: Text('Your list is empty'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: favProvider.favouriteItems.length,
            itemBuilder: (context, index) {
              final item = favProvider.favouriteItems[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Row(
                  children: [
                    Image.network(
                      item.image,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(item.price),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.cancel, color: Colors.red),
                      onPressed: () async {
                        await favProvider.removeFavourite(item.id);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
