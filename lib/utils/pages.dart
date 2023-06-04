class AppPages {
  static const HOME = PagePath.HOME;
  static const LOGIN = PagePath.LOGIN;
  static const FORGOT_PASSWORD = PagePath.FORGOT_PASSWORD;
  static const REGISTER = PagePath.REGISTER;
  static const CART_PRODUCTS = PagePath.CART_PRODUCTS;
  static const WIDGET_TREE = PagePath.REGISTER;
  static const CHANGE_PROFILE = PagePath.CHANGE_PROFILE;
  static const CHANGE_PASSWORD = PagePath.CHANGE_PASSWORD;
  static const CHAT_ROOM = PagePath.CHAT_ROOM;
  static const CHECKOUT_PAYMENT = PagePath.CHECKOUT_PAYMENT;
  static const ORDER = PagePath.ORDER;
  static const DETAIL_ORDER = PagePath.DETAIL_ORDER;
}

abstract class PagePath {
  static const HOME = '/';
  static const LOGIN = '/login';
  static const FORGOT_PASSWORD = '/forgot-password';
  static const REGISTER = '/register';
  static const CART_PRODUCTS = '/cart-products';
  static const CHANGE_PROFILE = '/change-profile';
  static const CHANGE_PASSWORD = '/change-password';
  static const WIDGET_TREE = '/widget-tree';
  static const CHAT_ROOM = '/chat-room';
  static const CHECKOUT_PAYMENT = '/checkout-payment';
  static const ORDER = '/order';
  static const DETAIL_ORDER = '/detail-order';
}
