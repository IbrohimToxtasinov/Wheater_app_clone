import 'package:flutter/cupertino.dart';

Widget textWidget(BuildContext context, {name, color, fontsize, fontWeight}) {
  return Text(name,
      style: TextStyle(
          fontSize: fontsize, fontWeight: fontWeight, color: color));
}
