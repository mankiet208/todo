import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/domain/models/todo/todo.dart';
import 'package:todo/ui/core/themes/dimens.dart';
import 'package:todo/ui/home/view_model/home_view_model.dart';
import 'package:todo/utils/extensions/context_extension.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
    required this.viewModel,
  });

  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    if (viewModel.todos.isEmpty) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.only(
            top: context.mediaQuery.size.height / 4,
          ),
          child: Center(
            child: Text(
              'Your Todos is empty',
              style: context.textTheme.bodyLarge?.copyWith(
                fontSize: 24,
              ),
            ),
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.only(
        left: Dimens.padding,
        right: Dimens.padding,
        bottom: 100,
      ),
      sliver: SliverList.separated(
        itemCount: viewModel.todos.length,
        itemBuilder: (_, index) {
          final todo = viewModel.todos[index];

          return _ToDo(
            key: ValueKey(todo.id),
            todo: todo,
            onTap: () {},
            onDelete: (todoId) {
              viewModel.deleteTodo.execute(todoId);
            },
            onChangeStatus: (status) {
              if (status == null) return;
              final newTodo = todo.copyWith(isDone: status);
              viewModel.updateTodo.execute(newTodo);
            },
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: Dimens.extraSmallPadding);
        },
      ),
    );
  }
}

class _ToDo extends StatelessWidget {
  const _ToDo({
    super.key,
    required this.todo,
    required this.onTap,
    required this.onDelete,
    required this.onChangeStatus,
  });

  final Todo todo;
  final GestureTapCallback onTap;
  final Function(String) onDelete;
  final Function(bool?) onChangeStatus;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            iconColor: WidgetStatePropertyAll(context.colorScheme.onError),
          ),
        ),
      ),
      child: Slidable(
        key: ValueKey(todo.id),
        endActionPane: ActionPane(
          extentRatio: 0.25,
          motion: DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (_) => onDelete(todo.id),
              backgroundColor: context.colorScheme.error,
              foregroundColor: context.colorScheme.onError,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: context.colorScheme.onPrimaryContainer,
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                offset: Offset(0, 0.5),
                blurRadius: 0.5,
                spreadRadius: 0,
              )
            ],
          ),
          child: CheckboxListTile(
            title: Text(todo.title),
            secondary: Icon(Icons.star_outline),
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.symmetric(
              vertical: Dimens.smallPadding,
              horizontal: Dimens.padding,
            ),
            activeColor: context.colorScheme.primary,
            checkColor: context.colorScheme.onPrimary,
            checkboxScaleFactor: 1.4,
            value: todo.isDone,
            onChanged: (bool? val) => onChangeStatus(val),
          ),
        ),
      ),
    );
  }
}
