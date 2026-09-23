import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:product_explorer/core/theme/app_theme.dart';
import 'package:product_explorer/main.dart';
import 'package:product_explorer/viewmodels/auth_viewmodel.dart';
import 'package:product_explorer/widgets/custom_app_bar.dart';
import 'package:product_explorer/widgets/custom_button.dart';
import 'package:product_explorer/widgets/custom_snackbar.dart';
import 'package:product_explorer/widgets/custom_text_field.dart';
import 'package:product_explorer/widgets/link_text_style.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _passwordVisible = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      CustomSnackbar.showSnackBar(
        context,
        'Please fill in all required fields.',
        appColors.redColor,
      );
      return;
    }

    if (password.length < 6) {
      CustomSnackbar.showSnackBar(
        context,
        'Password must be at least 6 characters.',
        appColors.redColor,
      );
      return;
    }

    final authVm = context.read<AuthViewModel>();
    final success = await authVm.signUp(
      email: email,
      password: password,
      name: name.isNotEmpty ? name : null,
    );

    if (!mounted) return;

    if (success) {
      Navigator.maybePop(context);
    } else {
      final message = authVm.errorMessage ?? 'Registration failed. Please try again.';
      CustomSnackbar.showSnackBar(context, message, appColors.redColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authVm = context.watch<AuthViewModel>();

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppSpacing.mainPadding),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create Account',
                      style: AppFonts.screenTitle(color: appColors.textColor),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Join us and start exploring',
                      style: AppFonts.button(color: appColors.textSecondaryColor),
                    ),
                  ],
                ),
                SizedBox(height: AppSpacing.spacingL),
                CustomTextField(
                  label: 'Name',
                  hintText: 'Enter your name',
                  labelIcon: Icon(Icons.person_outline, color: appColors.hintColor),
                  controller: _nameController,
                ),
                SizedBox(height: AppSpacing.spacingM),
                CustomTextField(
                  label: 'Email',
                  hintText: 'you@example.com',
                  labelIcon: Icon(Icons.email_outlined, color: appColors.hintColor),
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: AppSpacing.spacingM),
                CustomTextField(
                  label: 'Password',
                  hintText: '••••••••',
                  labelIcon: Icon(Icons.lock_outline, color: appColors.hintColor),
                  controller: _passwordController,
                  suffixIcon: Icon(
                    _passwordVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    color: appColors.hintColor,
                  ),
                  onSuffixIconTap: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                  isObscure: _passwordVisible,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _handleRegister(),
                ),
                SizedBox(height: AppSpacing.spacingL),
                CustomButton(
                  label: 'Register',
                  isLoading: authVm.isLoading,
                  onTap: _handleRegister,
                ),
                SizedBox(height: AppSpacing.spacingL),
                Center(
                  child: Text.rich(
                    TextSpan(
                      text: 'Already have an account? ',
                      style: AppFonts.body(color: appColors.textSecondaryColor),
                      children: [
                        TextSpan(
                          text: 'Login',
                          style: LinkTextStyle.style,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.maybePop(context);
                            },
                        ),
                      ],
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
