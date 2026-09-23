import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:product_explorer/core/theme/app_theme.dart';
import 'package:product_explorer/main.dart';
import 'package:product_explorer/viewmodels/auth_viewmodel.dart';
import 'package:product_explorer/views/auth/register_view.dart';
import 'package:product_explorer/widgets/custom_app_bar.dart';
import 'package:product_explorer/widgets/custom_button.dart';
import 'package:product_explorer/widgets/custom_icon_button.dart';
import 'package:product_explorer/widgets/custom_snackbar.dart';
import 'package:product_explorer/widgets/custom_text_field.dart';
import 'package:product_explorer/widgets/link_text_style.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _passwordVisible = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      CustomSnackbar.showSnackBar(
        context,
        'Please enter both email and password.',
        appColors.redColor,
      );
      return;
    }

    final authVm = context.read<AuthViewModel>();
    final success = await authVm.login(email: email, password: password);

    if (!mounted) return;

    if (!success) {
      final message = authVm.errorMessage ?? 'Login failed. Please try again.';
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
                      'Welcome Back',
                      style: AppFonts.screenTitle(color: appColors.textColor),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Login to continue',
                      style: AppFonts.button(color: appColors.textSecondaryColor),
                    ),
                  ],
                ),
                SizedBox(height: AppSpacing.spacingL),
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
                  onSubmitted: (_) => _handleLogin(),
                ),
                SizedBox(height: AppSpacing.spacingL),
                CustomButton(
                  label: 'Login',
                  isLoading: authVm.isLoading,
                  onTap: _handleLogin,
                ),
                SizedBox(height: AppSpacing.spacingM),
                Center(
                  child: TextButton(
                    onPressed: () {
                      CustomSnackbar.showSnackBar(
                        context,
                        'Password reset instructions sent to your email.',
                        appColors.primaryColor,
                      );
                    },
                    child: Text(
                      'Forgot Password?',
                      style: LinkTextStyle.style,
                    ),
                  ),
                ),
                SizedBox(height: AppSpacing.spacingS),
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
                        style: AppFonts.button(color: appColors.textSecondaryColor),
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
                SizedBox(height: AppSpacing.spacingM),
                CustomIconButton(
                  label: 'Continue with Google',
                  icon: 'assets/icons/google_icon.png',
                  onTap: () {
                    CustomSnackbar.showSnackBar(
                      context,
                      'Google Sign-In is for demo purposes. Please use email & password.',
                      appColors.primaryColor,
                    );
                  },
                ),
                SizedBox(height: AppSpacing.spacingL),
                Center(
                  child: Text.rich(
                    TextSpan(
                      text: "Don't have an account? ",
                      style: AppFonts.body(color: appColors.textSecondaryColor),
                      children: [
                        TextSpan(
                          text: 'Register',
                          style: LinkTextStyle.style,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterView(),
                                ),
                              );
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
