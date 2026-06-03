import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyReviews extends StatelessWidget {
  const MyReviews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: const Text(
          'My Reviews',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            children: [
              _buildReviewCard(
                productName: 'Minimal Lamp',
                price: '\$ 12.00',
                imagePath: 'assets/images/coffeetable2.png',
                rating: 5,
                date: '20/03/2020',
                reviewText:
                    'Nice Furniture with good delivery. The delivery time is very fast. Then products look like exactly the picture in the app. Besides, color is also the same and quality is very good despite very cheap price',
              ),
              const SizedBox(height: 16),
              _buildReviewCard(
                productName: 'Minimal Lamp',
                price: '\$ 12.00',
                imagePath: 'assets/images/coffeetable2.png',
                rating: 5,
                date: '20/03/2020',
                reviewText:
                    'Nice Furniture with good delivery. The delivery time is very fast. Then products look like exactly the picture in the app. Besides, color is also the same and quality is very good despite very cheap price',
              ),
              const SizedBox(height: 16),
              _buildReviewCard(
                productName: 'Minimal Lamp',
                price: '\$ 12.00',
                imagePath: 'assets/images/coffeetable2.png',
                rating: 5,
                date: '20/03/2020',
                reviewText:
                    'Nice Furniture with good delivery. The delivery time is very fast. Then products look like exactly the picture in the app. Besides, color is also the same and quality is very good despite very cheap price',
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReviewCard({
    required String productName,
    required String price,
    required String imagePath,
    required int rating,
    required String date,
    required String reviewText,
  }) {
    return Card(
      elevation: 4,
      shadowColor: Colors.black12,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    height: 60,
                    width: 60,
                    child: Image.asset(imagePath, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productName,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        price,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      Icons.star,
                      color: index < rating
                          ? Colors.amber
                          : Colors.grey.shade300,
                      size: 20,
                    ),
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Review Text
            Text(
              reviewText,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
                height: 1.4, // Line spacing behtar karne ke liye
              ),
            ),
          ],
        ),
      ),
    );
  }
}
