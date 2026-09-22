import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:product_explorer/providers/auth_controller.dart';
import 'package:product_explorer/screens/auth/register_screen.dart';
import 'package:product_explorer/utils/theme.dart';
import 'package:product_explorer/widgets/custom_app_bar.dart';
import 'package:product_explorer/widgets/custom_button.dart';
import 'package:product_explorer/widgets/custom_icon_button.dart';
import 'package:product_explorer/widgets/custom_text_field.dart';
import 'package:product_explorer/widgets/link_text_style.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class LoginScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.all(AppSpacing.mainPadding),
        child: Column(
          spacing: AppSpacing.spacingM,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome Back',style: AppFonts.screenTitle(color: appColors.textColor),),
                Text('Login to continue', style: AppFonts.button(color: appColors.textSecondaryColor)),
              ],
            ),
            CustomTextField(
                label: 'Email',
                hintText: 'you@example.com',
                labelIcon: Icon(Icons.email_outlined),
                controller: _emailController,
              ),
              CustomTextField(
                label: 'Password',
                hintText: 'xxxxxx',
                labelIcon: Icon(Icons.lock_outline),
                controller: _passwordController,
              ),
            CustomButton(
              label: 'Login',
              onTap: () {
                Provider.of<AuthController>(context, listen: false).login(_emailController.text.trim(), _passwordController.text.trim());
              },
            ),
            Center(child: Text('Forgot Password?', style: LinkTextStyle.style,)),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: appColors.borderColor,
                    thickness: 1,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'or',
                    style: AppFonts.button(color: appColors.textSecondaryColor)
                  ),
                ),

                Expanded(
                  child: Divider(
                    color: appColors.borderColor,
                    thickness: 1,
                  ),
                ),
              ],
            ),
            Center(child: CustomIconButton(label: 'Continue with Google', icon: 'assets/icons/google_icon.png',)),
            Center(
              child: Text.rich(
                TextSpan(
                  text: 'Don\'t have an account? ',
                  children:[
                    TextSpan(
                      text: 'Register',
                      style: LinkTextStyle.style,
                      recognizer: TapGestureRecognizer()
                      ..onTap = (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen(),));
                      }
                    )
                  ]
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}