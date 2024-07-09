import 'package:admin_app/core/middleware/app_middle_ware.dart';
import 'package:admin_app/view/screen/auth/login.dart';
import 'package:admin_app/view/screen/categories/add.dart';
import 'package:admin_app/view/screen/categories/edit.dart';
import 'package:admin_app/view/screen/categories/view.dart';
import 'package:admin_app/view/screen/home_screen.dart';
import 'package:admin_app/view/screen/items/add.dart';
import 'package:admin_app/view/screen/items/edit.dart';
import 'package:admin_app/view/screen/items/view.dart';
import 'package:admin_app/view/screen/orders/order_screen.dart';
import 'package:admin_app/view/screen/language.dart';
import 'package:admin_app/view/screen/orders/accepted.dart';
import 'package:admin_app/view/screen/orders/archive.dart';
import 'package:admin_app/view/screen/orders/details.dart';
import 'package:admin_app/view/screen/orders/pending.dart';
// import 'package:admin_app/view/screen/address/add_address.dart';
// import 'package:admin_app/view/screen/address/add_address_details.dart';
// import 'package:admin_app/view/screen/address/address.dart';
// import 'package:admin_app/view/screen/cart.dart';
// import 'package:admin_app/view/screen/checkout.dart';
// import 'package:admin_app/view/screen/favorite_screen.dart';
// import 'package:admin_app/view/screen/home_screen.dart';
// import 'package:admin_app/view/screen/items.dart';
// import 'package:admin_app/view/screen/notification.dart';
// import 'package:admin_app/view/screen/offers.dart';
// import 'package:admin_app/view/screen/orders/archive.dart';
// import 'package:admin_app/view/screen/orders/details.dart';
// import 'package:admin_app/view/screen/orders/pending.dart';
// import 'package:admin_app/view/screen/product_details.dart';
import 'package:get/get.dart';

import 'package:admin_app/core/constants/routes_name.dart';
// import 'package:admin_app/view/screen/screen_barrel.dart';

List<GetPage> getPages = [
  // GetPage(
  //   name: '/',
  //   page: () => Test(),
  // )

  // ========================= Auth ========================= //
  GetPage(
      name: AppRoutes.language,
      page: () => const LanguageScreen(),
      middlewares: [AppMiddleWare()]),
  // GetPage(
  //   name: AppRoutes.onboarding,
  //   page: () => const OnBoardingScreen(),
  // ),
  GetPage(
    name: AppRoutes.login,
    page: () => const LoginScreen(),
  ),
  // GetPage(
  //   name: AppRoutes.signup,
  //   page: () => const SignUpScreen(),
  // ),
  // GetPage(
  //   name: AppRoutes.forgetPassword,
  //   page: () => const CheckEmailScreen(),
  // ),
  // GetPage(
  //   name: AppRoutes.resetPassword,
  //   page: () => const ResetPasswordScreen(),
  // ),
  // GetPage(
  //   name: AppRoutes.verifyCode,
  //   page: () => const VerifyCodeScreen(),
  // ),
  // GetPage(
  //   name: AppRoutes.successSignUp,
  //   page: () => const SuccessSignUp(),
  // ),
  // GetPage(
  //   name: AppRoutes.successPasswordReset,
  //   page: () => const SuccessPasswordReset(),
  // ),
  // GetPage(
  //   name: AppRoutes.verifySignUpCode,
  //   page: () => const VerifySignUpCode(),
  // ),

  // ========================= Home ========================= //
  GetPage(name: AppRoutes.home, page: () => const HomeScreen()),
  // GetPage(
  //   name: AppRoutes.items,
  //   page: () => const ItemsScreen(),
  // ),

  // GetPage(
  //   name: AppRoutes.productDetails,
  //   page: () => const ProductDetailsScreen(),
  // ),
  // GetPage(
  //   name: AppRoutes.favorite,
  //   page: () => const FavoriteScreen(),
  // ),
  // GetPage(
  //   name: AppRoutes.cart,
  //   page: () => const CartScreen(),
  // ),
  // GetPage(
  //   name: AppRoutes.address,
  //   page: () => const AddressScreen(),
  // ),
  // GetPage(
  //   name: AppRoutes.addAddress,
  //   page: () => const AddAddressScreen(),
  // ),

  // GetPage(
  //   name: AppRoutes.addAddressDetails,
  //   page: () => const AddAddressDetailsScreen(),
  // ),

  // GetPage(name: AppRoutes.checkout, page: () => const CheckoutScreen()),

  // ========================= Order ========================= //

  GetPage(name: AppRoutes.order, page: () => const OrderScreen()),
  GetPage(
      name: AppRoutes.pendingOrders, page: () => const PendingOrdersScreen()),
  GetPage(
      name: AppRoutes.archiveOrders, page: () => const ArchiveOrdersScreen()),
  GetPage(
      name: AppRoutes.acceptedOrders, page: () => const AcceptedOrdersScreen()),
  GetPage(
      name: AppRoutes.ordersDetails, page: () => const OrdersDetailsScreen()),
  // ========================= Notification ========================= //
  // GetPage(name: AppRoutes.notification, page: () => const NotificationScreen()),

  // ========================= Offers ========================= //
  // GetPage(name: AppRoutes.offers, page: () => const OffersScreen()),

  // ========================= Category ========================= //

  GetPage(name: AppRoutes.addCategory, page: () => const AddCategoryScreen()),

  GetPage(name: AppRoutes.editCategory, page: () => const EditCategoryScreen()),

  GetPage(name: AppRoutes.viewCategory, page: () => const ViewCategoryScreen()),

  // ========================= Items ========================= //

  GetPage(name: AppRoutes.addItems, page: () => const AddItemScreen()),

  GetPage(name: AppRoutes.editItems, page: () => const EditItemScreen()),

  GetPage(name: AppRoutes.viewItems, page: () => const ViewItemsScreen()),
];
