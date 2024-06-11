import 'package:flutter/material.dart';

//created extension for size to get rid of sizedbox, it can be used any where in application
extension Padding on num{
  SizedBox get h => SizedBox(height: toDouble());
  SizedBox get w => SizedBox(width: toDouble());

  
}