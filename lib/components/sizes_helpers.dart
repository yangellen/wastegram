import 'package:flutter/material.dart';

Size displaySize(BuildContext context) => MediaQuery.of(context).size;

double percentHeight(BuildContext context, double size) =>
    (displaySize(context).height) * size;

double percentWidth(BuildContext context, double size) =>
    (displaySize(context).width) * size;

double displayWidth(BuildContext context) => displaySize(context).width;

double getSize(BuildContext context, double sizeL, double sizeP) {
  if (MediaQuery.of(context).orientation == Orientation.landscape) {
    return displayWidth(context) * sizeL;
  } else {
    return displayWidth(context) * sizeP;
  }
}
