import 'package:flutter/material.dart';

class DataWidget<T> extends StatelessWidget {
  final T data;
  final Widget dataWidget;
  final Widget defaultWidget;

  const DataWidget({
    Key? key,
    required this.data,
    required this.dataWidget,
    required this.defaultWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data is List) {
      if (data != null && (data as List).isNotEmpty) {
        return dataWidget;
      } else {
        return defaultWidget;
      }
    }

    if (data != null) {
      return dataWidget;
    } else {
      return defaultWidget;
    }
  }
}
