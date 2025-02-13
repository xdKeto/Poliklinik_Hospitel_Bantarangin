class AppRoutes {
  static String homeScreen(String param, {bool isExpand = false}) {
    return '/home/$param?isExpand=$isExpand';
  }
  static const String login = "/login";
}
