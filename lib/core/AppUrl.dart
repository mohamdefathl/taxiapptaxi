class AppApiUrl {
  static const String server = "http://192.168.0.103:8000/";
  // static const String server = "http://192.168.0.103:8000/";
  
  static const String auth = "${server}customer/login/";
  static const String authWithToken = "${server}customer/user/";

  static const String taxiOrders = "${server}order/driver-taxi-orders/";
  
  static const String taxiUpdateOrderState = "${server}taxi/update-order/";


}
