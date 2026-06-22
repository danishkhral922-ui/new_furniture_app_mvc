import 'package:flutter/material.dart';
import 'package:new_furiniture_app_mvc/controllers/auth_controller.dart';
import 'package:new_furiniture_app_mvc/views/auth/login.dart';
import 'package:provider/provider.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final ValueNotifier<bool> isPasswordHidden = ValueNotifier<bool>(true);
  final ValueNotifier<bool> isConfirmPasswordHidden = ValueNotifier<bool>(true);

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
                    horizontal: 10,
                    vertical: 24,
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
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'WELCOME',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                AnimatedPadding(
                  padding: EdgeInsets.only(top: _isVisible ? 0 : 30),
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeOutBack,
                  child: SizedBox(
                    width: 345,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shadowColor: Colors.grey,
                        elevation: 8,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: authProvider.nameController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Name',
                                ),
                              ),
                              const Divider(thickness: 1),
                              TextFormField(
                                controller: authProvider.emailController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Email',
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
                              ValueListenableBuilder<bool>(
                                valueListenable: isConfirmPasswordHidden,
                                builder: (context, isHidden, child) {
                                  return TextFormField(
                                    controller:
                                        authProvider.confirmpasswordController,
                                    obscureText: isHidden,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Confirm Password',
                                      suffixIcon: IconButton(
                                        onPressed: () =>
                                            isConfirmPasswordHidden.value =
                                                !isConfirmPasswordHidden.value,
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
                              const SizedBox(height: 20),
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
                                    onTap: () => Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Login(),
                                      ),
                                      (route) => false,
                                    ),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
