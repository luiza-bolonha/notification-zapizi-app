import 'package:flutter_project_model/modules/auth/view/auth_view.dart';
import 'package:flutter_project_model/modules/home/view/home_view.dart';
import 'package:get/get.dart';

class MainRoutes {
  static const auth = '/';
  static const home = '/home';
}

final getPages = [
  GetPage(name: MainRoutes.auth, page: () => const AuthView()),
  GetPage(name: MainRoutes.home, page: () => const HomeView()),
];