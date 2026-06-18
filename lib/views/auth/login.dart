import 'package:flutter/material.dart';
import 'package:new_furiniture_app_mvc/controllers/auth_controller.dart';
import 'package:new_furiniture_app_mvc/views/auth/signup.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final ValueNotifier<bool> isPasswordHidden = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final authProvider = context.read<AuthProvider>();

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
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
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Text(
                      'HELLO  !',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Text(
                      'WELCOME BACK',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 345,
                height: 437,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
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
                                  hintStyle: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          const Divider(thickness: 1),
                          const SizedBox(height: 30),
                          const Text(
                            'Forgot Password',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 30),
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
                                await authProvider.login(context);
                              },
                              child: Text(
                                'LOG IN',
                                style: TextStyle(
                                  color: isDarkMode
                                      ? Colors.black
                                      : Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 27),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Signup(),
                                ),
                              );
                            },
                            child: const Text(
                              'SIGN UP',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
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
      ),
    );
  }
}
