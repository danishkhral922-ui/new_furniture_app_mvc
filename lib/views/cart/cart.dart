import 'package:flutter/material.dart';
import 'package:new_furiniture_app_mvc/controllers/cart_controller.dart';
import 'package:provider/provider.dart';
import 'package:new_furiniture_app_mvc/views/checkout/checkout.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final cartProvider = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text(
          'My Cart',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartProvider.cartItems.length,
              itemBuilder: (context, index) {
                final item = cartProvider.cartItems[index];

                return Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
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
                          Column(
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
                              Text(
                                '\$ ${item.price}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 25),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      cartProvider.increaseQuantity(item.id);
                                    },
                                    child: Image.asset(
                                      'assets/images/plus.png',
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    item.quantity.toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () {
                                      cartProvider.decreaseQuantity(item.id);
                                    },
                                    child: Image.asset(
                                      'assets/images/minus.png',
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              cartProvider.deleteItem(item.id);
                            },
                            child: Image.asset(
                              'assets/images/cancel.png',
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Divider(color: Colors.grey[200], thickness: 2),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                SizedBox(
                  height: 44,
                  width: 276,
                  child: Card(
                    margin: EdgeInsets.zero,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: 'Enter Your Promo Code',
                        hintStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  height: 44,
                  width: 44,
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.white : Colors.black,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: isDarkMode ? Colors.black : Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total :',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '\$ ${cartProvider.totalPrice().toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: SizedBox(
              height: 60,
              width: 335,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: isDarkMode ? Colors.white : Colors.black,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Checkout()),
                  );
                },
                child: Text(
                  'Check Out',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? Colors.black : Colors.white,
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
