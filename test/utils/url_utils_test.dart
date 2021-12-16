import 'package:event_tracker_pm26s/utils/url_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("a invalida deve gerar erro", () {
    expect(
        () => launchURL('2021-12-06T06:59'), throwsA(TypeMatcher<dynamic>()));
  });
}
