import 'package:flutter/foundation.dart';

class AgeRange {
  final int lowAge;
  final int highAge;

  AgeRange({
    @required this.lowAge,
    @required this.highAge,
  });

  bool inRange(int age) {
    return (age >= lowAge && age <= highAge);
  }
}