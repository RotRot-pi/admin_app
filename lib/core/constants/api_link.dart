class ApiLink {
  static String server = "http://10.0.2.2/ecommerce_from_host/admin";
  static String categoriesImageFolder =
      "http://10.0.2.2/ecommerce_from_host/upload/categories/";
  static String itemsImageFolder =
      "http://10.0.2.2/ecommerce_from_host/upload/items/";

  // ====================== Test ======================== //
  static String test = "$server/test.php";

  // ====================== Auth ===================== //
  static String signUp = "$server/auth/signup.php";
  static String login = "$server/auth/login.php";
  static String verifySignUpCode = "$server/auth/verifycode.php";
  static String resentVerifyCode = "$server/auth/resentverifycode.php";

  // ====================== Forget Password ===================== //
  static String checkemail = "$server/forget_password/checkemail.php";
  static String resetPassword = "$server/forget_password/reset_password.php";
  static String verifyCode = "$server/forget_password/verifycode.php";

  // ====================== Home ======================== //
  static String home = "$server/home.php";
  static String search = "$server/search.php";

  static String items = "$server/items/items.php";

  // ====================== Favorite ======================= //
  static String addFavorite = "$server/favorite/addtofavorite.php";
  static String removeFavorite = "$server/favorite/removefromfavorite.php";
  static String deleteFavorite = "$server/favorite/deletefavorite.php";
  static String favoriteView = "$server/favorite/view.php";

  // ====================== Cart ======================= //
  // static String addCart = "$server/cart/addtocart.php";
  // static String removeFromCart = "$server/cart/removefromcart.php";
  // //static String deleteCart = "$server/cart/deletecart.php";
  // static String cartView = "$server/cart/view.php";

  static String cartView = "$server/cart/view.php";
  static String addCart = "$server/cart/add.php";
  static String deleteCart = "$server/cart/delete.php";
  static String getCountCart = "$server/cart/getcountitems.php";

  // ====================== Address ======================= //
  static String addressView = "$server/address/view.php";
  static String addAddress = "$server/address/add.php";
  static String deleteAddress = "$server/address/delete.php";
  static String updateAddress = "$server/address/update.php";

  // ====================== Coupon ======================= //
  static String checkCoupon = "$server/coupon/checkCoupon.php";

  // ====================== Order ======================= //
  static String viewAcceptedOrder = "$server/order/view_accepted.php";
  static String viewPendingOrder = "$server/order/view_pending.php";
  static String viewArchiveOrder = "$server/order/archive.php";
  static String orderDetails = "$server/order/details.php";
  static String approveOrder = "$server/order/approve.php";
  static String orderPrepare = "$server/order/prepare.php";

  // ====================== Notification ======================= //
  static String notificationView = "$server/notification/view.php";

  // ====================== Offers ======================= //

  static String offers = "$server/offers.php";

  // ====================== Category ======================= //

  static String addCategory = "$server/categories/add.php";
  static String editCategory = "$server/categories/edit.php";
  static String deleteCategory = "$server/categories/delete.php";
  static String viewCategory = "$server/categories/view.php";

  // ====================== Items ======================= //

  static String addItems = "$server/items/add.php";
  static String editItems = "$server/items/edit.php";
  static String deleteItems = "$server/items/delete.php";
  static String viewItems = "$server/items/view.php";
}







// class ApiLink {
//   static String server = "http://ramyecommerce.000webhostapp.com";

//   static String test = "$server/test.php";

//   // ====================== Auth ===================== //
//   static String signUp = "$server/auth/signup.php";
//   static String login = "$server/auth/login.php";
//   static String verifySignUpCode = "$server/auth/verifycode.php";

//   // ====================== Forget Password ===================== //
//   static String checkemail = "$server/forget_password/checkemail.php";
//   static String resetPassword = "$server/forget_password/reset_password.php";
//   static String verifyCode = "$server/forget_password/verifycode.php";
// }