class ApiConstants {
  static const String baseUrl = "https://food-delivery-api-cuel.onrender.com/api/v1/";

/// Auth
  static const String login = "auth/login";
  static const String signup = "auth/register";
  static const String forgetPassword = "auth/forgot-password";
  static const String logout = "auth/logout";
  static const String resendEmail = "auth/resend-email-verification";
  static const String verifyEmail = "auth/verify-email";
  static const String resetPassword = "auth/reset-password";
  static const String changePassword = "auth/change-password";
  static const String socialLogin = "auth/social-login";
  static const String otpVerification = "auth/profile";
  static const String refreshToken = "auth/refresh-token";

  /// Admin
  static const String adminDashboard = "admin/dashboard";
  static const String adminRestaurants = "admin/restaurants";
  static const String adminUsers = "admin/users";
  static const String adminOrders = "admin/orders";
  static const String adminPayments = "admin/payments";
  static const String adminReports = "admin/reports";

  /// Cart
  static const String cart = "cart";
  static const String addToCart = "cart/add";
  static const String updateCartItem = "cart/update";
  static const String removeCartItem = "cart/remove";
  static const String clearCart = "cart/clear";
  static const String applyCoupon = "cart/voucher/apply";
  static const String removeCoupon = "cart/voucher/remove";
  static const String checkout = "cart/checkout";

  /// Catalog
  static const String catalogHome = "catalog/home";
  static const String catalogSearch = "catalog/search";

  //Categories
  static const String catalogCategories = "catalog/categories";
  static const String categoriesFeatured = "catalog/categories/featured";

 //Food
  static const String catalogFoods = "catalog/foods";
  static const String foodFeatured = "catalog/foods/featured";
  //Restaurants
  static const String catalogRestaurants = "catalog/restaurants";

  ///Checkout
 static const String checkoutEstimate = "checkout/estimate";
 static const String createOrder = "checkout/create-order";
 static const String checkoutFees = "checkout/fees";
 static const String checkoutValidate = "checkout/validate";
 static const String checkoutVoucher = "checkout/voucher";
}
