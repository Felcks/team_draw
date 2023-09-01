import 'package:flutter/widgets.dart';

enum WindowSizeClass {
  COMPACT,
  MEDIUM,
  EXPANDED
}

WindowSizeClass getWidthWindowSizeClass(BuildContext context) {
  double width = MediaQuery.of(context).size.width;

  if(width < 600) {
    return WindowSizeClass.COMPACT;
  } else if (width < 840) {
    return WindowSizeClass.MEDIUM;
  }

  return WindowSizeClass.EXPANDED;
}

WindowSizeClass getHeightWindowSizeClass(BuildContext context) {
  double height = MediaQuery.of(context).size.height;

  if(height < 480) {
    return WindowSizeClass.COMPACT;
  } else if (height < 900) {
    return WindowSizeClass.MEDIUM;
  }

  return WindowSizeClass.EXPANDED;
}