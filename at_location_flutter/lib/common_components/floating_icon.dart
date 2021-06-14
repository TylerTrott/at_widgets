import 'package:at_location_flutter/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:at_common_flutter/services/size_config.dart';

class FloatingIcon extends StatelessWidget {
  final Color bgColor, iconColor;
  final IconData icon;
  final bool isTopLeft;
  final Function onPressed;

  FloatingIcon(
      {this.bgColor,
      this.iconColor,
      this.icon,
      this.isTopLeft = false,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      height: 50.toHeight,
      width: 50.toHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: !isTopLeft ? Radius.circular(10.0) : Radius.circular(0),
          bottomRight: isTopLeft ? Radius.circular(10.0) : Radius.circular(0),
        ),
        color: bgColor ?? AllColors().Black,
        boxShadow: [
          BoxShadow(
            color: iconColor ?? Color(0xFF868A92),
            blurRadius: 2.0,
            spreadRadius: 2.0,
            offset: Offset(0.0, 0.0),
          )
        ],
      ),
      child: IconButton(
          padding: EdgeInsets.all(10.toHeight),
          icon: Icon(
            icon ?? Icons.table_rows,
            color: iconColor ?? AllColors().WHITE,
            size: 27.toFont,
          ),
          onPressed: onPressed ?? () => Scaffold.of(context).openEndDrawer()),
    );
  }
}
