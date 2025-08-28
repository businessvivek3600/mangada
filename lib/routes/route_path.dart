import 'route_name.dart';

class Paths {
  /// Splash
  static const String splash = '/${Routes.splash}';
  static const String onBoarding = '/${Routes.onBoarding}';

  /// Auth
  static const String login = '/${Routes.login}';
  static const String register = '/${Routes.register}';
  static const String forgotPassword = '/${Routes.forgotPassword}';
  static const String otpVerification = '/${Routes.otpVerification}';

  /// Dashboard
  static const String main = '/${Routes.main}';
  static const String dashboard = '/${Routes.dashboard}';

  /// Profile / Settings / Notifications
  static const String profile = '/${Routes.profile}';
  static const String settings = '/${Routes.settings}';
  static const String notificationSettings = '/${Routes.notificationSettings}';
  static const String notifications = '/${Routes.notifications}';
  static const String editProfile = '/${Routes.editProfile}';
  static const String accountSettings = '/${Routes.accountSettings}';
  static const String changeEmail = '/${Routes.changeEmail}';
  static const String deleteAccount = '/${Routes.deleteAccount}';
  static const String deleteReason = '/${Routes.deleteReason}';


  /// App Pages
  static const String helpCenter = '/${Routes.helpCenter}';
  static const String about = '/${Routes.about}';
  static const String contactUs = '/${Routes.contactUs}';
  static const String termsAndConditions = '/${Routes.termsAndConditions}';
  static const String privacyPolicy = '/${Routes.privacyPolicy}';

  /// Ecommerce / Shop
  static const String discover = '/${Routes.discover}';
  static String productDetails(String id) =>
      '/${Routes.productDetails}/$id';
  static const String cart = '/${Routes.cart}';
  static const String checkout = '/${Routes.checkout}';
  static const String orderConfirmation = '/${Routes.orderConfirmation}';
  static const String orderHistory = '/${Routes.orderHistory}';
  static const String wishlist = '/${Routes.wishlist}';
  static const String search = '/${Routes.search}';
  static String category(String title) => '/${Routes.category}/$title';
  static const String foodDetail = '/${Routes.foodDetail}';
  static const String categoryList = '/${Routes.categoryList}';
}
