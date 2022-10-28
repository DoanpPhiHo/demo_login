class MyValidator {
  static String? isValidEmail(String? email) {
    if (email == null) return 'Please enter your email';
    //Maximum length 256 characters
    if (email.isEmpty || email.length > 256) {
      return 'Maximum length 256 characters';
    }

    //Contains only numbers, alphanumeric characters and dash(-), underscore(_) and period(.).
    final validCharacters = RegExp(r'^[a-zA-Z0-9_\-@\.]+$');
    if (!validCharacters.hasMatch(email)) {
      return 'Contains only numbers, alphanumeric characters and dash(-), underscore(_) and period(.).';
    }

    //not redundant @
    List<String> countOfPart = email.split('@');
    if (countOfPart.length != 2) return 'not redundant @';

    //Local part from 4 -> 64 characters
    if (countOfPart[0].length < 4 || countOfPart[0].length > 64) {
      return 'Local part from 4 -> 64 characters';
    }

    //Not available '.' after the @ part
    if (!countOfPart[1].contains('.')) {
      return 'Not available \'.\' after the @ part';
    }

    //Can't contain ..
    if (email.contains('..')) return 'Can\'t contain ..';

    //Emails with '.' at the beginning and at the end, @ at the end
    if (email.startsWith('.') || email.endsWith('.') || email.endsWith('@')) {
      return 'Emails with \'.\' at the beginning and at the end, @ at the end';
    }

    //Emails with \'-\' before/after @
    if (countOfPart[0].endsWith('-')) return 'Emails with \'-\' before/after @';
    if (countOfPart[0].endsWith('.')) return 'Emails with \'-\' before/after @';
    if (countOfPart[1].startsWith('-')) {
      return 'Emails with \'-\' before/after @';
    }
    if (countOfPart[1].startsWith('.')) {
      return 'Emails with \'-\' before/after @';
    }
    return null;
  }

  static String? isValidPassword(String? email) {
    if (email == null) return 'Please enter your password';
    //Maximum length 256 characters
    if (email.isEmpty || email.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
}
