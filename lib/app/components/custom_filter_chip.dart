import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onSelected;

  const CustomFilterChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      showCheckmark: true,
      checkmarkColor: Colors.white,
      label: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: selected
                  ? Colors.white
                  : (Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Theme.of(context).primaryColor),
            ),
      ),
      selected: selected,
      onSelected: (bool selected) {
        onSelected();
      },
      selectedColor: Theme.of(context).primaryColor,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      labelStyle: TextStyle(
        color: selected
            ? Theme.of(context).scaffoldBackgroundColor
            : Theme.of(context).primaryColor,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.r),
        side: BorderSide(
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
