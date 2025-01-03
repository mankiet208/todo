import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/routing/routes.dart';
import 'package:todo/ui/auth/login/view_model/login_view_model.dart';
import 'package:todo/ui/core/themes/colors.dart';
import 'package:todo/ui/core/themes/dimens.dart';
import 'package:todo/utils/extensions/context_extension.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
    required this.viewModel,
  });

  final LoginViewModel viewModel;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController =
      TextEditingController(); // email@example.com
  final TextEditingController _passwordController =
      TextEditingController(); // password

  LoginViewModel get viewModel => widget.viewModel;

  @override
  void initState() {
    super.initState();
    viewModel.login.addListener(_onResult);
  }

  @override
  void dispose() {
    viewModel.login.removeListener(_onResult);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
          listenable: viewModel,
          builder: (context, child) {
            return Column(
              children: [
                Expanded(
                  flex: 1,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 300),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          context.appLocalizations!.loginScreen_title1,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 50.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          context.appLocalizations!.loginScreen_title2,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: context.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildTextField(
                          hintText: context.appLocalizations!.loginScreen_email,
                          errorText: viewModel.hasEmailError
                              ? context
                                  .appLocalizations!.loginScreen_invalidEmail
                              : null,
                          controller: _emailController,
                          icon: Icons.person_outline,
                          onChanged: (email) => viewModel.updateEmail(email),
                        ),
                        const SizedBox(height: Dimens.padding),
                        _buildTextField(
                          hintText:
                              context.appLocalizations!.loginScreen_password,
                          errorText: viewModel.hasPasswordError
                              ? context
                                  .appLocalizations!.loginScreen_invalidPassword
                              : null,
                          controller: _passwordController,
                          icon: Icons.lock_outline,
                          obscureText: true,
                          onChanged: (password) =>
                              viewModel.updatePassword(password),
                        ),
                        const SizedBox(height: Dimens.padding),
                        SizedBox(
                          height: 50,
                          child: FilledButton(
                            onPressed: viewModel.isFormValid
                                ? () {
                                    viewModel.login.execute((
                                      _emailController.value.text,
                                      _passwordController.value.text,
                                    ));
                                  }
                                : null,
                            style: FilledButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              context.appLocalizations!.loginScreen_login,
                              style: context.textTheme.labelLarge?.copyWith(
                                color: context.colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        Center(
                          child: _buildBottomText(context),
                        ),
                        const SizedBox(height: Dimens.padding),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }

  Widget _buildTextField({
    required String hintText,
    String? errorText,
    IconData? icon,
    bool obscureText = false,
    TextEditingController? controller,
    Function(String)? onChanged,
  }) {
    final borderRadius = BorderRadius.circular(12);
    final boderColor = Colors.transparent;

    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(
            color: boderColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(
            color: boderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(
            color: boderColor,
          ),
        ),
        errorText: errorText,
        errorStyle: TextStyle(
          color: context.colorScheme.error,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.black.withValues(alpha: 0.6),
        ),
        prefixIcon: icon != null ? Icon(icon, size: 28) : null,
        fillColor: AppColors.primaryAccent,
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
      onTapOutside: (PointerDownEvent event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      onChanged: onChanged,
    );
  }

  Widget _buildBottomText(BuildContext context) {
    TextStyle defaultStyle = TextStyle(
      color: Colors.grey,
      fontSize: 20.0,
    );
    TextStyle linkStyle = TextStyle(color: context.colorScheme.primary);

    return RichText(
      text: TextSpan(
        style: defaultStyle,
        children: <TextSpan>[
          TextSpan(
            text: "${context.appLocalizations!.loginScreen_dontHaveAccount} ",
          ),
          TextSpan(
            text: context.appLocalizations!.loginScreen_registerNow,
            style: linkStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                print('Register');
              },
          ),
        ],
      ),
    );
  }

  void _onResult() {
    if (viewModel.login.isCompleted) {
      viewModel.login.clearResult();
      context.go(Routes.home.path);
      return;
    }

    if (viewModel.login.hasError) {
      final errorCode = viewModel.login.error!.exception.toString();
      var message = '';

      if (errorCode == 'user-not-found') {
        message = context.appLocalizations!.loginScreen_userNotFound;
      } else if (errorCode == 'wrong-password') {
        message = context.appLocalizations!.loginScreen_wrongPassword;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          action: SnackBarAction(
            label: context.appLocalizations!.general_tryAgain,
            onPressed: () => viewModel.login.execute((
              _emailController.value.text,
              _passwordController.value.text,
            )),
          ),
        ),
      );
      viewModel.login.clearResult();
    }
  }
}
