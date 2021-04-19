import 'package:at_contacts_group_flutter/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:at_common_flutter/at_common_flutter.dart';

class CustomInputField extends StatelessWidget {
  final String hintText;
  final double width, height;
  final IconData icon;
  final Function onTap;
  final Color iconColor;

  CustomInputField(
      {this.hintText = '',
      this.height = 50,
      this.width = 300,
      this.iconColor,
      this.icon,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.toWidth,
      height: height.toHeight,
      decoration: BoxDecoration(
        color: AllColors().INPUT_GREY_BACKGROUND,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: hintText,
                enabledBorder: InputBorder.none,
                border: InputBorder.none,
                hintStyle: TextStyle(color: AllColors().DARK_GREY),
              ),
              onTap: onTap ?? () {},
            ),
          ),
          icon != null
              ? Icon(
                  icon,
                  color: iconColor ?? AllColors().DARK_GREY,
                )
              : SizedBox()
        ],
      ),
    );
  }
}