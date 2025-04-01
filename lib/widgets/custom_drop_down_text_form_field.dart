import 'package:flutter/material.dart';
import 'package:highway_weight/styles/colors.dart';

class CustomDropDownTextFormField<T> extends StatelessWidget {
  final List<T> dropdownItems;
  final List<T>? dropdownValue;
  final String hintText;
  final Function(T?)? onChanged;
  final String Function(T)? itemLabelBuilder;

  const CustomDropDownTextFormField({
    super.key,
    required this.dropdownItems,
    this.onChanged,
    required this.hintText,
    this.itemLabelBuilder,
    this.dropdownValue,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      dropdownColor: AppColors.whitePrimary,
      borderRadius: BorderRadius.circular(10.0),
      menuMaxHeight: 400.0,
      hint: Text(hintText),
      items:
          dropdownItems.map((item) {
            return DropdownMenuItem(
              value: item,
              child:
                  itemLabelBuilder != null
                      ? Text(itemLabelBuilder!(item))
                      : Text(item.toString()),
            );
          }).toList(),
      onChanged: onChanged,
    );
  }
}
