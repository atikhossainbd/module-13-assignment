import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Util{
  static mySnackBar(message, BuildContext context) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}