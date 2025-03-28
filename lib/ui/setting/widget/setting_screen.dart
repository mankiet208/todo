import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/routing/routes.dart';
import 'package:todo/ui/core/themes/dimens.dart';
import 'package:todo/ui/setting/view_model/setting_view_model.dart';
import 'package:todo/utils/extensions/context_extension.dart';
import 'package:todo/utils/snackbar.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({
    super.key,
    required this.viewModel,
  });

  final SettingViewModel viewModel;

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  SettingViewModel get viewModel => widget.viewModel;

  @override
  void initState() {
    super.initState();
    viewModel.logout.addListener(_onLogOut);
  }

  @override
  void didUpdateWidget(covariant SettingScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewModel.logout.removeListener(_onLogOut);
    viewModel.logout.addListener(_onLogOut);
  }

  @override
  void dispose() {
    viewModel.logout.removeListener(_onLogOut);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.primaryContainer,
      appBar: AppBar(
        backgroundColor: context.colorScheme.primaryContainer,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: context.colorScheme.primary,
            size: 28,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildActionItem(
            context,
            text: 'Logout',
            onTap: () => viewModel.logout.execute(),
          ),
        ],
      ),
    );
  }

  Widget buildActionItem(
    BuildContext context, {
    required String text,
    VoidCallback? onTap,
    Widget? endWidget,
  }) {
    if (endWidget != null) {
      return Row(
        children: [
          Text(
            text,
            style: context.textTheme.titleLarge,
          ),
          Spacer(),
          endWidget,
        ],
      );
    }

    return TextButton(
      onPressed: onTap,
      child: Text(
        text,
        style: context.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 24,
        ),
      ),
    );
  }

  void _onLogOut() {
    if (viewModel.logout.isCompleted) {
      viewModel.logout.clearResult();
      context.go(Routes.login.path);
    }

    if (viewModel.logout.hasError) {
      viewModel.logout.clearResult();
      AppSnackBar.showSnackBarSuccess(
        context,
        message: 'Error while logging out.',
      );
    }
  }
}
