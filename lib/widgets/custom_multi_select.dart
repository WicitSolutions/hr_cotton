import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../colors/app_colors.dart';

class CustomSelect extends StatelessWidget {
  final Map<String, String> items;
  final String title;
  final Function onConfirm;

  const CustomSelect({Key? key, required this.items, required this.title, required this.onConfirm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MultiSelectItem> dropDownData = [];
    
    items.forEach((key, value) {
      dropDownData.add(MultiSelectItem(key, value));
    });

    return SizedBox(
      width: double.infinity,
      child: MultiSelectDialogField(
        items: dropDownData,
        // chipDisplay: MultiSelectChipDisplay.none(), // To hide Chips
        searchable: true,
        title: Text(
          title,
          style: const TextStyle(
              color: Colors.black,
              fontSize: 15
          ),
        ),
        selectedColor: AppColors.facebookColor,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          border: Border.all(
            color: AppColors.baseGrey30Color,
            width: 2,
          ),
        ),
        buttonIcon: const Icon(
          Icons.arrow_drop_down,
          color: AppColors.facebookColor,
        ),
        buttonText: Text(
          "Select $title",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        onConfirm: (results) {
          onConfirm(results);
        },
      ),
    );
  }
}
