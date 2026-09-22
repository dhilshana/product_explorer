import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:product_explorer/main.dart';
import 'package:product_explorer/providers/auth_controller.dart';
import 'package:product_explorer/screens/auth/login_screen.dart';
import 'package:product_explorer/utils/theme.dart';
import 'package:product_explorer/widgets/custom_app_bar.dart';
import 'package:product_explorer/widgets/custom_button.dart';
import 'package:product_explorer/widgets/custom_text_field.dart';
import 'package:product_explorer/widgets/link_text_style.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.mainPadding),
        child: Column(
          spacing: AppSpacing.spacingM,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Text('Create Account', style: AppFonts.screenTitle(color: appColors.textColor),),
                Text('Join us and start exploring', style: AppFonts.button(color: appColors.textSecondaryColor),),
              ],
            ),
            CustomTextField(
              label: 'Name',
              hintText: 'Enter your Name',
              labelIcon: Icon(Icons.person_outline),
              controller: _nameController,
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
              label: 'Register',
              onTap: () {
                Provider.of<AuthController>(context, listen: false).signUp(_emailController.text.trim(), _passwordController.text.trim());
              },
            ),
            Center(
              child: Text.rich(
                TextSpan(
                  text: 'Already have an account? ',
                  children: [
                    TextSpan(
                      text: 'Login',
                      style: LinkTextStyle.style,
                      recognizer: TapGestureRecognizer()
                      ..onTap = (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
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