class AppRoutes {
  static const String login = "/login";
  static const String homePasien = "/home/pasien";
  static const String homeBilling = "/home/billing";
  static const String homeRiwayat = "/home/riwayat";

  static String homeScreen(String param) {
    return "/home/$param";
  }
}
