class AppLinks {
  static const server = "http://192.168.1.8/ecommerce";

  //======================== Images =============================//
  static const imageCategories = "$server/upload/categories";
  static const imageItems = "$server/upload/items";
  //======================== Auth =============================//
  static const login = "$server/auth/login.php";
  static const signup = "$server/auth/signup.php";
  static const verifycodesignup = "$server/auth/verifycodesignup.php";
  static const resend = "$server/auth/resend.php";
  //======================== ForgetPassword =============================//
  static const checkemail = "$server/forgetpassword/checkemail.php";
  static const verifycode = "$server/forgetpassword/verifycode.php";
  static const resetpassword = "$server/forgetpassword/resetpassword.php";
  //======================== home =============================//
  static const home = "$server/home/home.php";
  //======================== Items =============================//
  static const items = "$server/items/items.php";
  static const search = "$server/items/search.php";
  //======================== Favorite =============================//
  static const favoriteAdd = "$server/favorite/add.php";
  static const favoriteRemove = "$server/favorite/remove.php";
  static const favoriteView = "$server/favorite/view.php";
  static const deletefromfavorite = "$server/favorite/delete_from_favorite.php";
  //======================== Cart =============================//
  static const cartView = "$server/cart/view.php";
  static const cartAdd = "$server/cart/add.php";
  static const cartDelete = "$server/cart/delete.php";
  static const cartGetCount = "$server/cart/get_count_items.php";
  //========================= Address =============================//
  static const addressView = "$server/address/view.php";
  static const addressAdd = "$server/address/add.php";
  static const addressEdit = "$server/address/edit.php";
  static const addressDelete = "$server/address/delete.php";
  //======================== Coupon =============================//
  static const checkCoupon = "$server/coupon/checkcoupon.php";
  //======================== Orders =============================//
  static const checkout = "$server/orders/checkout.php";
  static const ordersPending = "$server/orders/pending.php";
  static const ordersDetails = "$server/orders/details.php";
  static const ordersDelete = "$server/orders/delete.php";
  static const ordersArchive = "$server/orders/archive.php";
  static const ordersRating = "$server/orders/rating.php";
  //======================== Notification =============================//
  static const notification = "$server/notification/notification.php";
  //======================== Offers =============================//
  static const offers = "$server/offers/offers.php";
  
}
