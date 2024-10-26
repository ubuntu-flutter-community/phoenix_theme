import 'package:flutter/material.dart';

extension BuildContextX on BuildContext {
  ThemeData get theme => Theme.of(this);
  MediaQueryData get mq => MediaQuery.of(this);
}
