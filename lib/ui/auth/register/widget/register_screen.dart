import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/routing/routes.dart';
import 'package:todo/ui/auth/register/view_model/register_view_model.dart';
import 'package:todo/ui/core/themes/colors.dart';
import 'package:todo/ui/core/themes/dimens.dart';
import 'package:todo/utils/extensions/context_extension.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({
    super.key,
    required this.viewModel,
  });

  final RegisterViewModel viewModel;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterViewModel get viewModel => widget.viewModel;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    viewModel.register.addListener(_onResult);
  }

  @override
  void dispose() {
    viewModel.register.removeListener(_onResult);
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
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildTextField(
                        hintText: context.appLocalizations!.loginScreen_email,
                        errorText: viewModel.hasEmailError
                            ? context.appLocalizations!.error_invalidEmail
                            : null,
                        controller: _emailController,
                        icon: Icons.person_outline,
                        onChanged: (email) => viewModel.updateEmail(email),
                      ),
                      const SizedBox(height: Dimensions.padding),
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
                      const SizedBox(height: Dimensions.padding),
                      SizedBox(
                        height: 50,
                        child: FilledButton(
                          onPressed: viewModel.isFormValid
                              ? () {
                                  viewModel.register.execute((
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
                            context.appLocalizations!.registerScreen_register,
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
                      const SizedBox(height: Dimensions.padding),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
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
            text:
                "${context.appLocalizations!.registerScreen_alreadyHaveAccount} ",
          ),
          TextSpan(
            text: context.appLocalizations!.registerScreen_backToLogin,
            style: linkStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                context.go(Routes.login.path);
              },
          ),
        ],
      ),
    );
  }

  void _onResult() {
    if (viewModel.register.isCompleted) {
      viewModel.register.clearResult();
      context.go(Routes.home.path);
      return;
    }

    if (viewModel.register.hasError) {
      final errorCode = viewModel.register.error!.exception.toString();
      final message = _getMessageFromCode(errorCode);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          action: SnackBarAction(
            label: context.appLocalizations!.general_tryAgain,
            onPressed: () => viewModel.register.execute((
              _emailController.value.text,
              _passwordController.value.text,
            )),
          ),
        ),
      );
      viewModel.register.clearResult();
    }
  }

  String _getMessageFromCode(String code) {
    switch (code) {
      case 'email-already-in-use':
        return context.appLocalizations!.registerScreen_emailAlreadyInUse;
      case 'invalid-email':
        return context.appLocalizations!.error_invalidEmail;
      default:
        return context.appLocalizations!.error_somethingWrong;
    }
  }
}
