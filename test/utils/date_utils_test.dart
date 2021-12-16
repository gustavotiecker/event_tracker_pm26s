import 'package:event_tracker_pm26s/utils/date_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("deve retornar 12/06/2021 06:59 AM", () {
    print(convertDate('2021-12-06T06:59:00'));
    expect(convertDate('2021-12-06T06:59:00Z'), equals("12/06/2021 06:59 AM"));
  });

  test("a data imconpleta deve gerar erro", () {
    expect(() => convertDate('2021-12-06T06:59'),
        throwsA(TypeMatcher<Exception>()));
  });
}
