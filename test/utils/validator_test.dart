import 'package:demo_login/utils/validator/validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('test validator email', () {
    test('with email null', () {
      final result = MyValidator.isValidEmail(null);
      expect(result, 'Please enter your email');
    });
    test('with email Maximum length', () {
      final result = MyValidator.isValidEmail('string' * 225);
      expect(result?.isNotEmpty, true);
    });
    test(
        'with email Contains only numbers, alphanumeric characters and dash(-), underscore(_) and period(.).',
        () {
      final result = MyValidator.isValidEmail('aaa-aaa');
      expect(result?.isNotEmpty, true);
    });
    test('with email redundant @', () {
      final result = MyValidator.isValidEmail('null333@m@.ddd');
      expect(result?.isNotEmpty, true);
    });
    test('with email not Local part from 4 -> 64 characters', () {
      final result = MyValidator.isValidEmail('ddd@');
      expect(result?.isNotEmpty, true);
    });
    test('with email Emails with \'-\' before/after @', () {
      final result = MyValidator.isValidEmail('ddd-@');
      expect(result?.isNotEmpty, true);
    });
    test(
        'with email Emails with \'.\' at the beginning and at the end, @ at the end',
        () {
      final result = MyValidator.isValidEmail('.ddd@');
      expect(result?.isNotEmpty, true);
    });
    test('with email pass', () {
      final result = MyValidator.isValidEmail('eee.ddd@ex.com');
      expect(result?.isNotEmpty, null);
    });
  });

  group('test validator email', () {
    test('with password null', () {
      final result = MyValidator.isValidPassword(null);
      expect(result?.isNotEmpty, true);
    });
    test('with password length < 6', () {
      final result = MyValidator.isValidPassword('null');
      expect(result?.isNotEmpty, true);
    });
    test('with password pass', () {
      final result = MyValidator.isValidPassword('string');
      expect(result?.isNotEmpty, null);
    });
  });
}
