import 'package:at_common_flutter/at_common_flutter.dart';

/// This is a custom input field
/// @param [hintText] is a [String] to display if the input field is empty
/// @param [initialValue] is a [String] to pre-populate the input field
/// @param [height] in [double] sets the height of the input field
/// @param [width] in [double] sets the width of the input field
/// @param [icon] is the trailing icon on the input field and calls the [onIconTap] or [onTap] when tapped
/// @param [onTap] defines what to execute on tap on the input field
/// @param [onIconTap] defines what to execute on tap on the [icon]
/// @param [onSubmitted] defines what to execute on submit in the input field
/// @param [iconColor] is the color to fill the [icon]
/// @param [value] defines the observable value of the input field
/// @param [isReadOnly] toggles the input field to be read only

import 'package:at_common_flutter/utils/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomInputField extends StatelessWidget {
  final String hintText, initialValue;
  final double width, height;
  final IconData? icon;
  final Function? onTap, onIconTap, onSubmitted;
  final Color? iconColor;
  final ValueChanged<String>? value;
  final bool isReadOnly;

  TextEditingController textController = TextEditingController();

  CustomInputField(
      {this.hintText = '',
      this.height = 50,
      this.width = 300,
      this.iconColor,
      this.icon,
      this.onTap,
      this.onIconTap,
      this.value,
      this.initialValue = '',
      this.onSubmitted,
      this.isReadOnly = false});

  @override
  Widget build(BuildContext context) {
    textController = TextEditingController.fromValue(TextEditingValue(
        text: initialValue != null ? initialValue : '',
        selection: TextSelection.collapsed(
            offset: initialValue != null ? initialValue.length : -1)));
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: ColorConstants.inputFieldGrey,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              readOnly: isReadOnly,
              style: TextStyle(
                fontSize: 15.toFont,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                enabledBorder: InputBorder.none,
                border: InputBorder.none,
                hintStyle: TextStyle(
                    color: ColorConstants.darkGrey, fontSize: 15.toFont),
              ),
              onTap: onTap as void Function()? ?? () {},
              onChanged: (val) {
                value!(val);
              },
              controller: textController,
              onSubmitted: (str) {
                if (onSubmitted != null) {
                  onSubmitted!(str);
                }
              },
            ),
          ),
          icon != null
              ? InkWell(
                  onTap: onIconTap as void Function()? ??
                      onTap as void Function()?,
                  child: Icon(
                    icon,
                    color: iconColor ?? ColorConstants.darkGrey,
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
