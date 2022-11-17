// ignore_for_file: sized_box_for_whitespace, no_leading_underscores_for_local_identifiers

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_loader.dart';
import 'package:food_delivery/base/show_custom_snackbar.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/pages/auth/sign_up_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_text_field.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    
       void _login(AuthController authController) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (email.isEmpty) {
        showCustomSnackBar("Type in your email address",
            title: "Email Address");
      } else if (password.isEmpty) {
        showCustomSnackBar("Type in your password", title: "Password");
      } else {
        
        authController.login(email, password).then((status) {
          if (status.isSuccess) {
            Get.toNamed(RouteHelper.getInitial());
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }
 

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController){
        return !authController.isLoading? SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
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
            // welcome
            Container(
              margin: EdgeInsets.only(left: Dimensions.width20),
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello",
                    style: TextStyle(
                        fontSize: Dimensions.font20 * 3 + Dimensions.font20 / 2,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Sign into your account",
                    style: TextStyle(
                        fontSize: Dimensions.font20, color: Colors.grey[500]
                        // fontWeight: FontWeight.bold
                        ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: Dimensions.height20,
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
            Row(
              children: [
                Expanded(child: Container()),
                RichText(
                  text: TextSpan(
                      text: "Sign into your account",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimensions.font20,
                      )),
                ),
                SizedBox(width: Dimensions.width20,)
              ],
            ),
            SizedBox(height: Dimensions.screenHeight * 0.05),
            // sign in button
            GestureDetector(
              onTap: () {
                _login(authController);
              },
              child: Container(
                width: Dimensions.screenWidth / 2,
                height: Dimensions.screenHeight / 13,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                    color: AppColors.mainColor),
                child: Center(
                  child: BigText(
                    text: "Sign In",
                    size: Dimensions.font20 + Dimensions.font20 / 2,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: Dimensions.screenHeight * 0.05),
            RichText(
              text: TextSpan(
                text: "Don\'t have an account?",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: Dimensions.font20,
                ),
                children: [
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.to(() => const SignUpPage(), transition: Transition.fade),
                      text: " Create",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.mainBlackColor,
                        fontSize: Dimensions.font20,
                      ))
                ],
              ),
            ),
          ],
        ),
      ):const CustomLoader();
  
      },) );
  }
}
