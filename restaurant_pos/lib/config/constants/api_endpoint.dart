class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://10.0.2.2:3000/";
  // base url = 192.168.56.1
  // static const String baseUrl = "http://192.168.0.104:3000/";

  // ====================== Auth Routes ======================
  static const String login = "users/login";
  static const String register = "users/register";
  static const String uploadImage = "users/uploadImage";
  static const String getUserDetails = "users/getUserData";

  // ====================== Menu Routes ======================
  static const String createMenu = "menus/createMenu";
  static const String getAllMenus = "menus/getAllMenus";
  static const String menuImageUpload = "menus/menuImageUpload";
  static const String deleteMenu = "menus/";
  static const String updateMenu = "menus/";

  static const String imageUrl = "http://10.0.2.2:3000/uploads/";

  // ====================== Order Routes ======================
  static const String createOrder = "orders/";
  static const String getAllOrders = "orders/";
  static const String deleteOrder = "orders/";
  static const String updateOrder = "orders/";
  static const String updateOrderStatus = "orders/";
}
