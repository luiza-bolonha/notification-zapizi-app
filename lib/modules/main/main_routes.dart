import 'package:flutter_project_model/modules/auth/view/auth_view.dart';
import 'package:get/get.dart';

class MainRoutes {
  static const auth = '/';
  static const home = '/home';
}

final getPages = [
  GetPage(name: MainRoutes.auth, page: () => const AuthView()),
];