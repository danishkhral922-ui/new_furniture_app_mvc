import 'package:flutter/material.dart';
import 'package:new_furiniture_app_mvc/controllers/auth_controller.dart';
import 'package:new_furiniture_app_mvc/views/auth/signup.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final ValueNotifier<bool> isPasswordHidden = ValueNotifier<bool>(true);
  bool _isVisible = false;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) setState(() => _isVisible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final authProvider = context.read<AuthProvider>();

    return Scaffold(
      body: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeOut,
        child: SingleChildScrollView(
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
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'HELLO !',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'WELCOME BACK',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),

                AnimatedPadding(
                  padding: EdgeInsets.only(top: _isVisible ? 0 : 30),
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeOutBack,
                  child: SizedBox(
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
                                  border: InputBorder.none,
                                  hintText: 'Email',
                                  contentPadding: EdgeInsets.all(15),
                                ),
                              ),
                              const Divider(thickness: 1),
                              ValueListenableBuilder<bool>(
                                valueListenable: isPasswordHidden,
                                builder: (context, isHidden, child) {
                                  return TextFormField(
                                    controller: authProvider.passwordController,
                                    obscureText: isHidden,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Password',
                                      contentPadding: const EdgeInsets.all(15),
                                      suffixIcon: IconButton(
                                        onPressed: () =>
                                            isPasswordHidden.value =
                                                !isPasswordHidden.value,
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

                              AnimatedScale(
                                scale: _isPressed ? 0.95 : 1.0,
                                duration: const Duration(milliseconds: 100),
                                child: SizedBox(
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
                                      setState(() => _isPressed = true);
                                      await Future.delayed(
                                        const Duration(milliseconds: 100),
                                      );
                                      setState(() => _isPressed = false);

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
                              ),
                              const SizedBox(height: 27),
                              GestureDetector(
                                onTap: () => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Signup(),
                                  ),
                                ),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
