import 'package:flutter/material.dart';

class GoalEditableItem extends StatelessWidget {
  const GoalEditableItem({
    required this.label,
    required this.left,
    required this.right,
    required this.onTap,
    super.key,
  });

  final String label;
  final String left;
  final String right;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "$left / $right",
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
