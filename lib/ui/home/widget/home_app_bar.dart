import 'package:flutter/material.dart';
import 'package:todo/ui/core/themes/dimens.dart';
import 'package:todo/utils/extensions/context_extension.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
    required this.onTapMenu,
  });

  final VoidCallback onTapMenu;

  double get collapsedPadding => 64;
  double get expandedPadding => 16;
  double get appBarMaxHeight => 130;
  double get appBarMinHeight => kToolbarHeight + 8;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar.large(
      foregroundColor: context.colorScheme.primary,
      backgroundColor: context.colorScheme.primaryContainer,
      surfaceTintColor: context.colorScheme.primaryContainer,
      leading: IconButton(
        icon: const Icon(
          Icons.menu,
          size: 28,
        ),
        onPressed: onTapMenu,
      ),
      stretch: true,
      pinned: true,
      expandedHeight: appBarMaxHeight,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final double statusBarHeight =
              MediaQuery.of(context).viewPadding.top.roundToDouble();
          final double currentHeight = constraints.maxHeight.roundToDouble();
          final double minHeight = statusBarHeight + kToolbarHeight + 8;
          final double maxHeight = appBarMaxHeight + statusBarHeight;
          final double factor =
              (currentHeight - minHeight) / (maxHeight - minHeight);
          final double leftPadding = expandedPadding +
              (collapsedPadding - expandedPadding) * (1 - factor);

          // Set the title with dynamic font size
          return FlexibleSpaceBar(
            title: Text(
              'Tasks',
              style: TextStyle(
                color: context.colorScheme.primary,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            titlePadding: EdgeInsets.only(
              left: leftPadding,
              bottom: Dimens.padding,
            ),
          );
        },
      ),
    );
  }
}
