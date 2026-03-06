class RegexPatterns {
  static final RegExp passwordRegex=RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&#^()_+=\-])[A-Za-z\d@$!%*?&#^()_+=\-]{8,}$');
  static final RegExp usernameRegex=RegExp(r'^[a-zA-Z][a-zA-Z0-9_.-]{2,19}$');
  static final RegExp emailRegex=RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
}