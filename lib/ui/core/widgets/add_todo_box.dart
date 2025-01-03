import 'package:flutter/material.dart';
import 'package:todo/utils/extensions/context_extension.dart';

class AddTodoBox extends StatefulWidget {
  const AddTodoBox({
    super.key,
    this.focusNode,
    this.onSubmit,
  });

  final FocusNode? focusNode;
  final Function(String)? onSubmit;

  @override
  State<AddTodoBox> createState() => _AddTodoBoxState();
}

class _AddTodoBoxState extends State<AddTodoBox> {
  late TextEditingController _controller;

  bool get hasText => _controller.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _controller,
      builder: (context, value, child) {
        return Positioned(
          bottom: context.mediaQuery.viewInsets.bottom,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
            ),
            child: Column(
              children: [
                _buildTextField(context),
                _buildActionBar(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            focusNode: widget.focusNode,
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.circle_outlined,
                color: context.colorScheme.outline,
              ),
              hintText: 'hint text',
            ),
            style: context.textTheme.bodyLarge?.copyWith(
              fontSize: 18,
            ),
            onSubmitted: (value) => widget.onSubmit?.call(value),
          ),
        ),
        IconButton(
          onPressed: () => widget.onSubmit?.call(_controller.text),
          icon: Icon(
            Icons.done,
            color: hasText
                ? context.colorScheme.primary
                : context.colorScheme.outline,
          ),
        ),
      ],
    );
  }

  Widget _buildActionBar(BuildContext context) {
    return Row(
      children: [
        TextButton.icon(
          onPressed: () {
            print('Set due date');
          },
          icon: Icon(
            Icons.calendar_month,
            color: context.colorScheme.outline,
            size: 24,
          ),
          label: Text(
            'Set due date',
            style: context.textTheme.labelLarge?.copyWith(
              color: context.colorScheme.outline,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
