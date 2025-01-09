import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/data/services/firebase/model/todo_request/todo_request.dart';
import 'package:todo/routing/routes.dart';
import 'package:todo/ui/core/themes/dimens.dart';
import 'package:todo/ui/core/widgets/add_todo_box.dart';
import 'package:todo/ui/core/widgets/error_indicator.dart';
import 'package:todo/ui/home/view_model/home_view_model.dart';
import 'package:todo/ui/home/widget/home_app_bar.dart';
import 'package:todo/ui/home/widget/home_body.dart';
import 'package:todo/utils/extensions/context_extension.dart';
import 'package:todo/utils/screen_size.dart';
import 'package:todo/utils/snackbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.viewModel,
  });

  final HomeViewModel viewModel;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final double scaleAnimCircleSize = 30.0;

  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  late FocusNode _focusNode;

  bool _isAnimHidden = true;
  bool _showAddTodo = false;

  HomeViewModel get viewModel => widget.viewModel;

  @override
  void initState() {
    super.initState();

    viewModel.createTodo.addListener(_onCreateTodo);
    viewModel.updateTodo.addListener(_onUpdateTodo);
    viewModel.deleteTodo.addListener(_onDeleteTodo);

    _focusNode = FocusNode();

    _scaleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _scaleController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        await context.pushNamed(Routes.setting.name);

        _resetMenuAnimation();
      }
    });

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: (ScreenSize.screenHeight / scaleAnimCircleSize) * 2,
    ).animate(_scaleController);
  }

  @override
  void dispose() {
    viewModel.createTodo.removeListener(_onCreateTodo);
    viewModel.updateTodo.removeListener(_onUpdateTodo);
    viewModel.deleteTodo.removeListener(_onDeleteTodo);
    _focusNode.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: context.colorScheme.primaryContainer,
      floatingActionButton: _buildFloatingButton(),
      body: ListenableBuilder(
        listenable: viewModel.load,
        builder: (context, child) {
          if (viewModel.load.isRunning) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (viewModel.load.hasError) {
            return ErrorIndicator(
              title: context.appLocalizations!.error_loadingHome,
              label: context.appLocalizations!.general_tryAgain,
              onPressed: viewModel.load.execute,
            );
          }

          return child!;
        },
        child: ListenableBuilder(
          listenable: viewModel,
          builder: (context, _) {
            return Stack(
              children: [
                CustomScrollView(
                  slivers: <Widget>[
                    HomeAppBar(
                      onTapMenu: _startMenuAnimation,
                    ),
                    HomeBody(viewModel: viewModel),
                  ],
                ),
                if (!_isAnimHidden) _buildSettingTransitionAnimation(),
                if (_showAddTodo) ..._buildAddTodo(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildFloatingButton() {
    return ListenableBuilder(
      listenable: viewModel.createTodo,
      builder: (context, child) {
        final isRunning = viewModel.createTodo.isRunning;

        return FloatingActionButton(
          backgroundColor: context.colorScheme.primary,
          isExtended: true,
          onPressed: isRunning
              ? null
              : () {
                  setState(() {
                    _showAddTodo = true;
                  });
                  _focusNode.requestFocus();
                },
          child: isRunning
              ? SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: context.colorScheme.onPrimary,
                  ),
                )
              : Icon(
                  Icons.add,
                  color: context.colorScheme.onPrimary,
                  size: 32,
                ),
        );
      },
    );
  }

  Widget _buildSettingTransitionAnimation() {
    return Positioned(
      left: Dimens.padding,
      top: 40,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.colorScheme.primaryContainer,
          ),
          width: scaleAnimCircleSize,
          height: scaleAnimCircleSize,
        ),
      ),
    );
  }

  List<Widget> _buildAddTodo() {
    return [
      GestureDetector(
        onTap: () {
          setState(() {
            _showAddTodo = false;
          });
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Container(
          color: Colors.black.withValues(alpha: 0.5),
          height: context.mediaQuery.size.height,
        ),
      ),
      AddTodoBox(
        focusNode: _focusNode,
        onSubmit: (title) {
          _createTodo(title: title);

          setState(() {
            _showAddTodo = false;
          });
          FocusManager.instance.primaryFocus?.unfocus();
        },
      ),
    ];
  }

  void _startMenuAnimation() {
    setState(() {
      _isAnimHidden = false;
    });

    _scaleController.forward();
  }

  void _resetMenuAnimation() {
    setState(() {
      _isAnimHidden = true;
    });

    _scaleController.reset();
  }

  void _createTodo({required String title}) {
    final todo = TodoRequest(
      title: title,
      createDate: DateTime.now(),
      dueDate: DateTime.now().add(const Duration(days: 2)),
      isDone: false,
    );

    viewModel.createTodo.execute(todo);
  }

  void _onCreateTodo() {
    if (viewModel.createTodo.isCompleted) {
      viewModel.createTodo.clearResult();

      AppSnackBar.showSnackBarSuccess(
        context,
        message: 'Todo created successfully.',
      );
      return;
    }
  }

  void _onUpdateTodo() {
    if (viewModel.updateTodo.isCompleted) {
      viewModel.updateTodo.clearResult();
      return;
    }

    if (viewModel.updateTodo.hasError) {
      AppSnackBar.showSnackBarError(
        context,
        message: 'Error while updating todo',
      );
    }
  }

  void _onDeleteTodo() {
    if (viewModel.deleteTodo.isCompleted) {
      viewModel.deleteTodo.clearResult();

      AppSnackBar.showSnackBarSuccess(
        context,
        message: 'Todo deleted successfully.',
      );
      return;
    }
  }
}
