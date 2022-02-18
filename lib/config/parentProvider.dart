import 'package:flutter/cupertino.dart';

class ParentProvider extends InheritedWidget {
  final String theme;
  final Widget child;

  ParentProvider({this.theme, this.child});

  @override
  bool updateShouldNotify(ParentProvider oldWidget) {
    return true;
  }

  static ParentProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ParentProvider>();
}
