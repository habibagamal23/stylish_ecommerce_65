class ApiConstants {
  static const String apiBaseUrl = "https://dummyjson.com";

  static const String login = "$apiBaseUrl/auth/login";

  static const String catigoryList = "$apiBaseUrl/products/category-list";

  static const String currentuser = "$apiBaseUrl/user/me";
  static const String user = '$apiBaseUrl users';
  static const String products  ="$apiBaseUrl/products";
  static const String productsbycategory  ="$apiBaseUrl/products/category";

  static const String cart = "$apiBaseUrl/carts";
  static const String userCart = "$apiBaseUrl$cart/user";
  static const String addCart = "$apiBaseUrl$cart/add";


/// strip
  static const String urlStripCreatPyment = "https://api.stripe.com/v1/payment_intents";
  static const String tokenstrip =  "sk_test_51QLO18KCYYcZnriZy6tOCTMspmHTC38AV7zMSfFD73CdQACvjgwNmwIDkFi8SI7D8xDrSfAMmaJlRTwv9PqqIOTI00iZvgjjVX";
  static const String urlephmralKey = "https://api.stripe.com/v1/ephemeral_keys";


}
