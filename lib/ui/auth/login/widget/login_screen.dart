import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/routing/routes.dart';
import 'package:todo/ui/auth/login/view_model/login_view_model.dart';
import 'package:todo/ui/core/themes/colors.dart';
import 'package:todo/ui/core/themes/dimens.dart';
import 'package:todo/utils/extensions/context_extension.dart';
import 'package:todo/utils/responsive.dart';

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
  LoginViewModel get viewModel => widget.viewModel;

  final TextEditingController _emailController =
      TextEditingController(); // email@example.com
  final TextEditingController _passwordController =
      TextEditingController(); // password

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
      backgroundColor: context.colorScheme.primaryContainer,
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (context.isDesktop) ...[
                Expanded(
                  child: _buildLeftPanel(),
                ),
              ],
              Flexible(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: Responsive.maxMobileWidth,
                  ),
                  child: _buildBody(context),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLeftPanel() {
    return Container(
      margin: context.isMobile
          ? null
          : EdgeInsets.only(
              top: Dimensions.padding,
              bottom: Dimensions.padding,
              left: Dimensions.padding,
              right: 0,
            ),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: context.isMobile ? null : BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(
          'Have a nice day!',
          textAlign: TextAlign.center,
          style: context.textTheme.displayLarge?.copyWith(
            fontSize: 80,
            color: context.colorScheme.primary,
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      margin: context.isMobile
          ? null
          : EdgeInsets.symmetric(
              vertical: Dimensions.padding,
              horizontal: 20,
            ),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: context.isMobile ? null : BorderRadius.circular(16),
      ),
      child: Column(
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
              padding: EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: _buildForms(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForms() {
    return Column(
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
          hintText: context.appLocalizations!.loginScreen_password,
          errorText: viewModel.hasPasswordError
              ? context.appLocalizations!.loginScreen_invalidPassword
              : null,
          controller: _passwordController,
          icon: Icons.lock_outline,
          obscureText: true,
          onChanged: (password) => viewModel.updatePassword(password),
        ),
        const SizedBox(height: Dimensions.padding),
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
        const SizedBox(height: Dimensions.padding),
      ],
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
        filled: true,
        fillColor: AppColors.primaryAccent,
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
                context.go('/register');
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
      final message = _getMessageFromCode(errorCode);

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

  String _getMessageFromCode(String code) {
    switch (code) {
      case 'user-not-found':
        return context.appLocalizations!.loginScreen_userNotFound;
      case 'wrong-password':
        return context.appLocalizations!.loginScreen_wrongPassword;
      case 'too-many-requests':
        return context.appLocalizations!.loginScreen_tooManyRequest;
      default:
        return context.appLocalizations!.error_somethingWrong;
    }
  }
}
