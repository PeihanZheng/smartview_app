import 'package:get/get.dart';
import 'package:smarview_app/pages/authentication_module/login_page.dart';
import 'package:smarview_app/pages/authentication_module/signup_page.dart';
import 'package:smarview_app/pages/dashboard_module/home_page.dart';
import 'package:smarview_app/pages/map_module/map_page.dart';
import 'package:smarview_app/pages/splash_page.dart';

import 'widgets/settings_page.dart';

class Routes {
  static final routes = [
    GetPage(name: '/', page: () => const SplashScreen()),
    GetPage(name: '/home-page', page: () => const Homepage()),
    GetPage(name: '/signup', page: () => const SignupPage()),
    GetPage(name: '/login', page: () => const Loginpage()),
    GetPage(name: '/map-page', page: () => const MapPage()),
    GetPage(name: '/settings-page', page: () => const SettingsPage()),
  ];
}
