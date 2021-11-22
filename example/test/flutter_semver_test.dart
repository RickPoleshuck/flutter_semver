// This is an example unit test.
//
// A unit test tests a single function, method, or class. To learn more about
// writing unit tests, visit
// https://flutter.dev/docs/cookbook/testing/unit/introduction

import 'package:flutter_semver/flutter_semver.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pub_semver/pub_semver.dart';

void main() {
  group('increment', () {
    test('minor', () {
      expect(increment(Version.parse('1.0.0'), SemanticPart.minor).toString(), '1.1.0');
      expect(increment(Version.parse('1.0.0+3'), SemanticPart.minor).toString(), '1.1.0');
      expect(increment(Version.parse('1.1.0'), SemanticPart.minor).toString(), '1.2.0');
    });
    test('major', () {
      expect(increment(Version.parse('1.0.0'), SemanticPart.major).toString(), '2.0.0');
      expect(increment(Version.parse('1.0.0+3'), SemanticPart.major).toString(), '2.0.0');
      expect(increment(Version.parse('1.1.0'), SemanticPart.major).toString(), '2.0.0');
    });
    test('patch', () {
      expect(increment(Version.parse('0.0.0'), SemanticPart.patch).toString(), '0.0.1');
      expect(increment(Version.parse('1.0.0+3'), SemanticPart.patch).toString(), '1.0.1');
      expect(increment(Version.parse('1.1.0'), SemanticPart.patch).toString(), '1.1.1');
    });
    test('build', () {
      expect(increment(Version.parse('0.0.1'), SemanticPart.build).toString(), '0.0.1+1');
      expect(increment(Version.parse('2.0.1+3'), SemanticPart.build).toString(), '2.0.1+4');
    });
  });
}
