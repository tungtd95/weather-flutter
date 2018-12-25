import 'package:flutter/material.dart';

abstract class BaseView extends State {
  void update() {
    setState(() {
      //when call this function, view will be updated automatically
    });
  }
}
