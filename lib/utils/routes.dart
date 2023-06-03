import 'package:get/get.dart';
import 'package:veterna_poultry/pages/cart_page.dart';
import 'package:veterna_poultry/pages/chat_room.dart';
import 'package:veterna_poultry/pages/checkout_payment_page.dart';
import 'package:veterna_poultry/pages/forget_password_page.dart';
import 'package:veterna_poultry/pages/login_page.dart';
import 'package:veterna_poultry/pages/navigation/nav_bar.dart';
import 'package:veterna_poultry/pages/profile/change_passsword_page.dart';
import 'package:veterna_poultry/pages/profile/change_profile_page.dart';
import 'package:veterna_poultry/pages/register_page.dart';
import 'package:veterna_poultry/pages/tab/tab_view.dart';
import 'package:veterna_poultry/utils/pages.dart';
import 'package:veterna_poultry/utils/widget_tree.dart';

class AppRoutes {
  static const INITIAL = AppPages.LOGIN;
  static final pages = [
    GetPage(name: PagePath.HOME, page: () => const NavBar()),
    GetPage(name: PagePath.LOGIN, page: () => const LoginPage()),
    GetPage(name: PagePath.FORGOT_PASSWORD, page: () => const ForgotPage()),
    GetPage(name: PagePath.REGISTER, page: () => const RegisterPage()),
    GetPage(name: PagePath.WIDGET_TREE, page: () => const WidgetTree()),
    GetPage(name: PagePath.CHAT_ROOM, page: () => const ChatroomPage()),
    GetPage(name: PagePath.CART_PRODUCTS, page: () => const CartPage()),
    GetPage(
        name: PagePath.CHANGE_PROFILE, page: () => const ChangeProfilePage()),
    GetPage(
        name: PagePath.CHANGE_PASSWORD, page: () => const ChangePasswordPage()),
    GetPage(name: PagePath.CHECKOUT_PAYMENT, page: () => CheckoutPaymentPage()),
    GetPage(name: PagePath.ORDER, page: () => const TabViewPage()),
  ];
}
