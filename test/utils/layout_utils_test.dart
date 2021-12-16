import 'package:event_tracker_pm26s/utils/layout_utils.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("addVerticalSpace: deve retornar um Sizedbox", () {
    expect(addVerticalSpace(10), isA<SizedBox>());
  });

  test("addHorizontalSpace: deve retornar um Sizedbox", () {
    expect(addHorizontalSpace(10), isA<SizedBox>());
  });
}
