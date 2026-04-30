import 'package:flutter/material.dart';
import 'package:tm_store_app/common/widgets/custom_shape/container/circular_container.dart';
import 'package:tm_store_app/utils/constants/colors.dart';
import 'package:tm_store_app/utils/helpers/helper_functions.dart';


class TChoiceChip extends StatelessWidget {
  const TChoiceChip({
    super.key, required this.text, required this.selected, this.onSelected,
  });

  final String text;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    final isColors = THelperFunctions.getColor(text) != null;
     
     // To make the background of the Chip Transparent warp with Theme, data

    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: ChoiceChip(
        label: isColors ? const SizedBox()  : Text(text),
        selected: selected,
        onSelected: onSelected,
        // ignore: dead_code
        labelStyle: TextStyle(color: selected ? TColors.white : null), 
        avatar:  isColors ? TCirularContainer(width: 50, height: 50, backgroundColor:  THelperFunctions.getColor(text)!) : null,
        shape: isColors ?  CircleBorder() : null,
        labelPadding: isColors ?  EdgeInsets.all(0) : null,
        padding: isColors ? EdgeInsets.all(0) : null,
        //selectedColor: Colors.green,
        backgroundColor: isColors ?  THelperFunctions.getColor(text)! : null ,
      
        ),
    );
  }
}