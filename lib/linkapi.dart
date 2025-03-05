class AppLink {
  static const String server = "https://spices.seha-sa.in/api";

// ================================= Auth ========================== //

  static const String login = "$server/driver/auth/login";

// ================================= Profile ========================== //

  static const String profile = "$server/driver/profile";

//============================order =============================//

  static const String currentOrdersFetch = "$server/driver/orders/current";
  static const String historyOrdersFetch = "$server/driver/orders/history";
  static const String orderUpdateStatus = "$server/driver/orders/update-status";
}
