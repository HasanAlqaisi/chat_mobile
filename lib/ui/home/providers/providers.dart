import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final contentControllerProvider =
    Provider.autoDispose((ref) => TextEditingController());
