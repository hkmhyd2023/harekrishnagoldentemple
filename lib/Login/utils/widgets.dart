import 'package:flutter/material.dart';
import 'package:harekrishnagoldentemple/Login/utils/colors.dart';

InputDecoration commonInputDecoration({String? hintText, Widget? prefixIcon, Widget? suffixIcon}) {
  return InputDecoration(
    filled: true,
    fillColor: textFieldColor,
    hintText: hintText,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    hintStyle: TextStyle(color: hintTextColor, fontSize: 16),
    contentPadding: EdgeInsets.symmetric(horizontal: 16),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
  );
}

Widget homeTitleWidget({
  String? titleText,
  String? viewAllText,
  Function()? onAllTap,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(titleText!, style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
        TextButton(
          child: Text(
            viewAllText ?? "View All",
            style: TextStyle(color: viewAllColor, fontSize: 16, fontWeight: FontWeight.normal),
          ),
          onPressed: onAllTap!,
        ),
      ],
    ),
  );
}

Widget drawerWidget({String? drawerTitle, Function()? drawerOnTap, IconData? drawerIcon}) {
  return ListTile(
    horizontalTitleGap: 0,
    visualDensity: VisualDensity.compact,
    leading: Icon(drawerIcon!, size: 20),
    title: Text(drawerTitle!, style: TextStyle()),
    onTap: drawerOnTap!,
  );
}
