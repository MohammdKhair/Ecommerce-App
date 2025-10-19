import 'package:ecommerce_app/core/constant/app_routes.dart';
import 'package:ecommerce_app/core/middleware/mymiddleware.dart';
import 'package:ecommerce_app/screens/address/address_add/view/address_add.dart';
import 'package:ecommerce_app/screens/address/address_add_details/view/address_add_details.dart';
import 'package:ecommerce_app/screens/address/address_view/view/address_view.dart';
import 'package:ecommerce_app/screens/auth/forget_password/forgetpassword/view/forgetpassword.dart';
import 'package:ecommerce_app/screens/auth/forget_password/resetpassword/view/resetpassword.dart';
import 'package:ecommerce_app/screens/auth/forget_password/verifycode/view/verifycode.dart';
import 'package:ecommerce_app/screens/auth/login/view/login.dart';
import 'package:ecommerce_app/screens/auth/signup/view/signup.dart';
import 'package:ecommerce_app/screens/auth/forget_password/success_resetpassword/view/success_resetpassword.dart';
import 'package:ecommerce_app/screens/auth/success_signup/view/success_signup.dart';
import 'package:ecommerce_app/screens/auth/verifycode_signup/view/verifycode_signup.dart';
import 'package:ecommerce_app/screens/cart/view/cart.dart';
import 'package:ecommerce_app/screens/checkout/view/checkout.dart';
import 'package:ecommerce_app/screens/favorite/view/favorite.dart';
import 'package:ecommerce_app/screens/home_screen/view/home_screen.dart';
import 'package:ecommerce_app/screens/items/view/items.dart';
import 'package:ecommerce_app/screens/itemsdetails/view/itemsdetails.dart';
import 'package:ecommerce_app/screens/language/view/language.dart';
import 'package:ecommerce_app/screens/onbording/view/onboarding.dart';
import 'package:ecommerce_app/screens/orders/archive/view/orders_archive.dart';
import 'package:ecommerce_app/screens/orders/details/view/orders_details.dart';
import 'package:ecommerce_app/screens/orders/pending/view/orders_pending.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

List<GetPage<dynamic>>? routes = [
  // Language
  GetPage(
      name: AppRoute.language,
      page: () => const Language(),
      middlewares: [MyMiddleWare()]),
  // OnBoarding
  GetPage(name: AppRoute.onBoarding, page: () => const OnBoarding()),
  // Auth
  GetPage(name: AppRoute.login, page: () => const Login()),
  GetPage(name: AppRoute.signUp, page: () => const SignUp()),
  GetPage(name: AppRoute.forgetPassword, page: () => const ForgetPassword()),
  GetPage(name: AppRoute.verifyCode, page: () => const VerifyCode()),
  GetPage(
      name: AppRoute.verifyCodeSignUp, page: () => const VerifyCodeSignUp()),
  GetPage(name: AppRoute.resetPassword, page: () => const ResetPassword()),
  GetPage(
      name: AppRoute.successResetPassword,
      page: () => const SuccessResetPassword()),
  GetPage(name: AppRoute.successSignUp, page: () => const SuccessSignUp()),
  // Home
  GetPage(name: AppRoute.homeScreen, page: () => const HomeScreen()),
  GetPage(name: AppRoute.items, page: () => const Items()),
  GetPage(name: AppRoute.itemsDetails, page: () => const ItemsDetails()),
  GetPage(name: AppRoute.favorite, page: () => const Favorite()),
  GetPage(name: AppRoute.cart, page: () => const Cart()),
  GetPage(name: AppRoute.checkout, page: () => const Checkout()),
  // Address
  GetPage(name: AppRoute.addressView, page: () => const AddressView()),
  GetPage(name: AppRoute.addressAdd, page: () => const AddressAdd()),
  GetPage(
      name: AppRoute.addressAddDetails, page: () => const AddressAddDetails()),
  // Orders
  GetPage(name: AppRoute.ordersPending, page: () => const OrdersPending()),
  GetPage(name: AppRoute.ordersArchive, page: () => const OrdersArchive()),
  GetPage(name: AppRoute.ordersDetails, page: () => const OrdersDetails()),
];
