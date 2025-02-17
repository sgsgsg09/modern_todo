import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:modern_todo/core/theme/app_theme.dart';

class AddTodoDottedCard extends StatelessWidget {
  final VoidCallback onTap;

  const AddTodoDottedCard({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: Colors.grey,
      strokeWidth: 2,
      dashPattern: const [6, 4],
      borderType: BorderType.RRect,
      radius: const Radius.circular(8),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 80,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, size: 30, color: Colors.grey),
              const SizedBox(width: 8),
              Text(
                "Add New Todo",
                style: AppTheme.addTodoTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
