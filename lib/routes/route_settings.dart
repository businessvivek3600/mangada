import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:madhang/presentation/profile/view/components/account_settings.dart';
import 'package:madhang/presentation/profile/view/components/change_email.dart';
import 'package:madhang/presentation/profile/view/components/delete_settings.dart';
import 'package:madhang/presentation/profile/view/components/notification_settings.dart';
import 'package:madhang/presentation/profile/view/edit_profile.dart';
import 'package:madhang/presentation/profile/view/help_center.dart';
import 'package:madhang/presentation/profile/view/settings_screen.dart';
import '../core/data/models/food_data_model.dart';
import '../presentation/auth/view/forgot_passowrd.dart';
import '../presentation/auth/view/login_screen.dart';
import '../presentation/auth/view/otp_verification_screen.dart';
import '../presentation/auth/view/register_screen.dart';
import '../presentation/cart/view/my_cart_screen.dart';
import '../presentation/category/view/category_list_screen.dart';
import '../presentation/category/view/category_screen.dart';
import '../presentation/food/view/food_details_screen.dart';
import '../presentation/food/view/food_order_screen.dart' show FoodOrderScreen;
import '../presentation/home/view/home_page.dart';
import '../presentation/main/main_screen.dart';
import '../presentation/onboardingScreen/view/on_boarding_screen.dart';
import '../presentation/profile/view/profile_screen.dart';
import '../presentation/splash/view/splash_screen.dart';
import 'route_name.dart';
import 'route_path.dart';

/// Transition builder for all screens
CustomTransitionPage<T> buildPageWithTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
        child: child,
      );
    },
  );
}

/// GoRouter Configuration
final GoRouter router = GoRouter(
  initialLocation: Paths.splash,
  routes: [
    /// Splash
    GoRoute(
      path: Paths.splash,
      name: Routes.splash,
      pageBuilder:
          (context, state) => buildPageWithTransition(
            context: context,
            state: state,
            child: SplashScreen(),
          ),
    ),
    GoRoute(
      path: Paths.onBoarding,
      name: Routes.onBoarding,
      pageBuilder:
          (context, state) => buildPageWithTransition(
            context: context,
            state: state,
            child: OnboardingScreen(),
          ),
    ),

    /// Auth
    GoRoute(
      path: Paths.login,
      name: Routes.login,
      pageBuilder:
          (context, state) => buildPageWithTransition(
            context: context,
            state: state,
            child: LoginScreen(),
          ),
    ),
    GoRoute(
      path: Paths.register,
      name: Routes.register,
      pageBuilder:
          (context, state) => buildPageWithTransition(
            context: context,
            state: state,
            child: RegisterScreen(),
          ),
    ),

    GoRoute(
      path: Paths.editProfile,
      name: Routes.editProfile,
      pageBuilder:
          (context, state) => buildPageWithTransition(
        context: context,
        state: state,
        child: EditProfileScreen(),
      ),
    ),

    GoRoute(
      path: Paths.settings,
      name: Routes.settings,
      pageBuilder:
          (context, state) => buildPageWithTransition(
        context: context,
        state: state,
        child: SettingsScreen(),
      ),
    ),
    GoRoute(
      path: Paths.accountSettings,
      name: Routes.accountSettings,
      pageBuilder:
          (context, state) => buildPageWithTransition(
        context: context,
        state: state,
        child: AccountSettingsScreen(),
      ),
    ),
    GoRoute(
      path: Paths.changeEmail,
      name: Routes.changeEmail,
      pageBuilder:
          (context, state) => buildPageWithTransition(
        context: context,
        state: state,
        child: ChangeEmailScreen(),
      ),
    ),
    GoRoute(
      path: Paths.deleteAccount,
      name: Routes.deleteAccount,
      pageBuilder:
          (context, state) => buildPageWithTransition(
        context: context,
        state: state,
        child: DeleteAccountScreen(),
      ),
    ),

    GoRoute(
      path: Paths.deleteReason,
      name: Routes.deleteReason,
      pageBuilder:
          (context, state) => buildPageWithTransition(
        context: context,
        state: state,
        child: DeleteReasonScreen(reason: state.extra as String,),
      ),
    ),
    GoRoute(
      path: Paths.notificationSettings,
      name: Routes.notificationSettings,
      pageBuilder:
          (context, state) => buildPageWithTransition(
        context: context,
        state: state,
        child: NotificationSettingsScreen(),
      ),
    ),

    GoRoute(
      path: Paths.forgotPassword,
      name: Routes.forgotPassword,
      pageBuilder:
          (context, state) => buildPageWithTransition(
            context: context,
            state: state,
            child: ForgotPassword(),
          ),
    ),

    GoRoute(
      path: Paths.otpVerification,
      name: Routes.otpVerification,
      pageBuilder:
          (context, state) => buildPageWithTransition(
            context: context,
            state: state,
            child: OtpVerificationScreen(),
          ),
    ),

    GoRoute(
      path: Paths.main,
      name: Routes.main,
      pageBuilder:
          (context, state) => buildPageWithTransition(
            context: context,
            state: state,
            child: MainScreen(), // Replace with DashboardScreen()
          ),
    ),
    GoRoute(
      path: Paths.helpCenter,
      name: Routes.helpCenter,
      pageBuilder:
          (context, state) => buildPageWithTransition(
        context: context,
        state: state,
        child: HelpCenterScreen(),
      ),
    ),
    /// Dashboard
    GoRoute(
      path: Paths.dashboard,
      name: Routes.dashboard,
      pageBuilder:
          (context, state) => buildPageWithTransition(
            context: context,
            state: state,
            child: MyHomePage(), // Replace with DashboardScreen()
          ),
      routes: [
        GoRoute(
          path: Routes.profile,
          name: Routes.profile,
          pageBuilder:
              (context, state) => buildPageWithTransition(
                context: context,
                state: state,
                child: ProfileScreen(),
              ),
        ),
        GoRoute(
          path: Routes.cart,
          name: Routes.cart,
          pageBuilder:
              (context, state) => buildPageWithTransition(
                context: context,
                state: state,
                child: MyCartScreen(), // Replace with CartScreen()
              ),
        ),
        GoRoute(
          path: Routes.orderHistory,
          name: Routes.orderHistory,
          pageBuilder:
              (context, state) => buildPageWithTransition(
                context: context,
                state: state,
                child: FoodOrderScreen(), // Replace with CartScreen()
              ),
        ),
        GoRoute(
          path: '${Routes.category}/:title',
          name: Routes.category,
          pageBuilder: (context, state) {
            final title = state.pathParameters['title']!;
            final items = state.extra as List<FoodCardData>;
            return buildPageWithTransition(
              context: context,
              state: state,
              child: CategoryScreen(
                categoryTitle: title,
                items: items,
              ),
            );
          },
        ),

        GoRoute(
          path: Routes.foodDetail,
          name: Routes.foodDetail,
          pageBuilder: (context, state) {
            final foodData = state.extra as FoodCardData;
            return buildPageWithTransition(
              context: context,
              state: state,
              child: FoodDetailScreen(data: foodData),
            );
          },
        ),


        GoRoute(
          path: Routes.categoryList,
          name: Routes.categoryList,
          pageBuilder:
              (context, state) => buildPageWithTransition(
                context: context,
                state: state,
                child:CategoryListPage(), // Replace with NotificationsScreen()
              ),
        ),
      ],
    ),
  ],
);
