// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_loader.dart';
import 'package:food_delivery/base/show_custom_snackbar.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/models/signup_body_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_text_field.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImages = [
      "t.png",
      "f.png",
      "g.png",
    ];

    void _registration(AuthController authController) {
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = phoneController.text.trim();

      if (name.isEmpty) {
        showCustomSnackBar("Type in your name", title: "Name");
      } else if (phone.isEmpty) {
        showCustomSnackBar("Type in your phone number", title: "Phone Number");
      } else if (email.isEmpty) {
        showCustomSnackBar("Type in your email address",
            title: "Email Address");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("Type in a valid email address",
            title: "Valid Email Address");
      } else if (password.isEmpty) {
        showCustomSnackBar("Type in your password", title: "Password");
      } else if (password.length < 6) {
        showCustomSnackBar("Password can not be less than six characters",
            title: "Password");
      } else {
        showCustomSnackBar("All Went Well", title: "Perfect");
        SignUpBody signUpBody = SignUpBody(
            name: name, phone: phone, email: email, password: password);
        authController.registration(signUpBody).then((status) {
          if (status.isSuccess) {
            print("Success regristation");
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }
    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(
          builder: (_authController) {
            return !_authController.isLoading?SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: 0.04,
                  ),
                  // app logo
                  Container(
                    height: Dimensions.screenHeight * 0.25,
                    child: const Center(
                      child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 60,
                          backgroundImage: AssetImage("images/Cloche.png")),
                    ),
                  ),
                  // email
                  AppTextFiels(
                      textController: emailController,
                      hintText: "Email",
                      icon: Icons.email),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  // password
                  AppTextFiels(
                      textController: passwordController,
                      hintText: "Password",
                      icon: Icons.password_sharp, isObscure: true,),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  // name
                  AppTextFiels(
                      textController: nameController,
                      hintText: "Name",
                      icon: Icons.person),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  // phone
                  AppTextFiels(
                      textController: phoneController,
                      hintText: "Phone",
                      icon: Icons.phone),
                  SizedBox(
                    height: Dimensions.height20,
                  ),

                  GestureDetector(
                    onTap: () {
                      _registration(_authController);
                    },
                    child: Container(
                      width: Dimensions.screenWidth / 2,
                      height: Dimensions.screenHeight / 13,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius30),
                          color: AppColors.mainColor),
                      child: Center(
                        child: BigText(
                          text: "Sign Up",
                          size: Dimensions.font20 + Dimensions.font20 / 2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  RichText(
                    text: TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.back(),
                        text: "Have an account already?",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font20,
                        )),
                  ),
                  SizedBox(height: Dimensions.screenHeight * 0.05),
                  RichText(
                    text: TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.back(),
                        text: "Sign up using one of the following methods",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font16,
                        )),
                  ),
                  Wrap(
                    children: List.generate(
                        3,
                        (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: Dimensions.radius30,
                                backgroundImage:
                                    AssetImage("images/" + signUpImages[index]),
                              ),
                            )),
                  )
                ],
              ),
            ):const CustomLoader();
          },
        ));
  }
}
