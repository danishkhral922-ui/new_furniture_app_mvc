import 'package:flutter/material.dart';
import 'package:new_furiniture_app_mvc/controllers/auth_controller.dart';
import 'package:new_furiniture_app_mvc/controllers/login_controller.dart';
import 'package:new_furiniture_app_mvc/controllers/snackbar_controller.dart';
import 'package:get/get.dart';
import 'package:new_furiniture_app_mvc/views/auth/signup.dart';

class Login extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());
  final SnackController controller2 = Get.put(SnackController());
  final AuthController authController = Get.put(AuthController());

  Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    SizedBox(width: 10),
                    Image.asset('assets/images/center.png'),
                    SizedBox(width: 10),
                    Image.asset('assets/images/rightline.png'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Text(
                      'WELCOME BACK',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
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
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: authController.emailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              hintText: 'Email',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                          SizedBox(height: 20),
                          Divider(color: Colors.grey, thickness: 2),
                          SizedBox(height: 20),
                          Obx(
                            () => TextFormField(
                              controller: authController.passwordController,
                              obscureText: controller.isHidden.value,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Password',
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.togglePassword();
                                  },
                                  icon: Icon(
                                    controller.isHidden.value
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                  ),
                                ),
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Divider(color: Colors.grey, thickness: 2),
                          SizedBox(height: 30),
                          Text(
                            'Forgot Password',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 30),
                          SizedBox(
                            height: 50,
                            width: 285,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () async {
                                await authController.login();
                              },
                              child: Text(
                                'LOG IN',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 27),
                          GestureDetector(
                            onTap: () {
                              Get.offAll(Signup());
                            },
                            child: Text(
                              'SIGN UP',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
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
