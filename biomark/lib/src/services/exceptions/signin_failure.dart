class SignInFailure implements Exception {
  final String message;

  SignInFailure([this.message = "An Unknown error occurred."]);

  factory SignInFailure.code(String code) {
    switch (code) {
      case "invalid-email":
        return SignInFailure("Email is not valid. Try again.");
      case "invalid-credential":
        return SignInFailure("User credentials are invalid. Try again.");
      case "user-not-found":
        return SignInFailure(
            "No user found with this email. Please check your email or sign up.");
      case "wrong-password":
        return SignInFailure("User credentials are invalid. Please try again.");
      case "user-disabled":
        return SignInFailure(
            "This user has been disabled. Please contact support for help.");
      case "too-many-requests":
        return SignInFailure(
            "Too many unsuccessful login attempts. Please try again later.");
      default:
        return SignInFailure();
    }
  }
}
