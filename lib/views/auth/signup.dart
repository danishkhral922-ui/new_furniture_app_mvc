import 'package:flutter/material.dart';
import 'package:new_furiniture_app_mvc/controllers/auth_controller.dart';
import 'package:new_furiniture_app_mvc/views/auth/login.dart';
import 'package:provider/provider.dart';

class Signup extends StatelessWidget {
  Signup({super.key});

  final ValueNotifier<bool> isPasswordHidden = ValueNotifier<bool>(true);
  final ValueNotifier<bool> isConfirmPasswordHidden = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final authProvider = context.read<AuthProvider>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/leftline.png'),
                  const SizedBox(width: 10),
                  Image.asset('assets/images/center.png'),
                  const SizedBox(width: 10),
                  Image.asset('assets/images/rightline.png'),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'WELCOME ',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 345,
              height: 590,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shadowColor: Colors.grey,
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: authProvider.nameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'Name',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Divider(thickness: 1),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: authProvider.emailController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'Email',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Divider(thickness: 1),
                        const SizedBox(height: 20),

                        // Password Field Input Observer
                        ValueListenableBuilder<bool>(
                          valueListenable: isPasswordHidden,
                          builder: (context, isHidden, child) {
                            return TextFormField(
                              controller: authProvider.passwordController,
                              obscureText: isHidden,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Password',
                                hintStyle: const TextStyle(color: Colors.grey),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    isPasswordHidden.value =
                                        !isPasswordHidden.value;
                                  },
                                  icon: Icon(
                                    isHidden
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        const Divider(thickness: 1),
                        const SizedBox(height: 20),

                        ValueListenableBuilder<bool>(
                          valueListenable: isConfirmPasswordHidden,
                          builder: (context, isHidden, child) {
                            return TextFormField(
                              controller:
                                  authProvider.confirmpasswordController,
                              obscureText: isHidden,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Confirm Password',
                                hintStyle: const TextStyle(color: Colors.grey),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    isConfirmPasswordHidden.value =
                                        !isConfirmPasswordHidden.value;
                                  },
                                  icon: Icon(
                                    isHidden
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        const Divider(thickness: 1),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 50,
                          width: 285,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isDarkMode
                                  ? Colors.white
                                  : Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () async {
                              await authProvider.signUp(context);

                              if (context.mounted) {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Login(),
                                  ),
                                  (route) => false,
                                );
                              }
                            },
                            child: Text(
                              'SIGN UP',
                              style: TextStyle(
                                color: isDarkMode ? Colors.black : Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an Account?  ',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Login(),
                                  ),
                                  (route) => false,
                                );
                              },
                              child: const Text(
                                'SIGN IN',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
