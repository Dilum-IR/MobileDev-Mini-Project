class UserHandler {
  static var currentUser;
  static var id;
  static var email;
  static var name;
  static var userType;

  static String capitalizeFirstLetter(String name) {
    if (name.isEmpty) {
      return name;
    }
    return name[0].toUpperCase() + name.substring(1);
  }
}
