// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get hello => 'Hello!';

  @override
  String greeting(Object name) {
    return 'Welcome, $name!';
  }

  @override
  String get appTitle => 'Library Of Ruina';

  @override
  String get tryAgain => 'Try Again';

  @override
  String get drawerSearch => 'Search';

  @override
  String get drawerCart => 'My Cart';

  @override
  String get drawerAccount => 'My Account and Wishlist';

  @override
  String get drawerFilters => 'Apply Filters';

  @override
  String get drawerFindUs => 'Where to find us';

  @override
  String get drawerLogout => 'Logout';

  @override
  String get loginEmail => 'Email';

  @override
  String get loginPassword => 'Password';

  @override
  String get loginBtn => 'Login';

  @override
  String get loginNew => 'New to Ruina?';

  @override
  String get loginNewAccount => 'Create an Account';

  @override
  String get loginEmptyTitle => 'Empty Fields';

  @override
  String get loginEmptyContent => 'Please enter both email and password';

  @override
  String get loginUserNotregister => 'User is not registered';

  @override
  String get loginUserInexistentContent =>
      'Sorry to inform you, we do not have an account registered to this email please check again or register today!';

  @override
  String get loginWrongPasswordTitle => 'Incorrect Password';

  @override
  String get loginWrongPasswordContent =>
      'Oops! Seems like it was the wrong password';

  @override
  String get registerFName => 'First Name';

  @override
  String get registerLName => 'Last Name';

  @override
  String get registerPhone => 'PhoneNumber';

  @override
  String get registerConfirmPassword => 'ConfirmPassword';

  @override
  String get registerBtn => 'Register';

  @override
  String get registerHaveAccount => 'Already have an account?';

  @override
  String get registerSuccess => 'Registration Successful!';

  @override
  String get registerSuccessContent =>
      'Your account has been created. Please login.';

  @override
  String get bookQuantity => 'Currently in stock';

  @override
  String get bookPrice => 'Price';

  @override
  String accountGreeting(Object name) {
    return 'We are delighted to see you back $name!';
  }

  @override
  String get accountWishList => 'Here is your wishList';

  @override
  String get accountLogOut => 'LogOut';

  @override
  String get cart => 'Your Cart :';

  @override
  String get cartEmpty => 'Your cart is currently empty.';

  @override
  String get cartSubtotal => 'Subtotal';

  @override
  String get cartFederal => 'Federal Taxes';

  @override
  String get cartProvincial => 'Provincial Taxes';

  @override
  String get cartCheckout => 'Complete my order';

  @override
  String get cartOrderReceived => 'We have received your order';

  @override
  String cartThankYou(Object totalCart) {
    return 'Thank you for choosing the library of Ruina \n Your total is \$$totalCart';
  }

  @override
  String get cartPayment => 'Proceed with payment';

  @override
  String get cartError => 'Error';

  @override
  String get cartOutOfStock =>
      'Some of the items in your cart are currently out of stock please try again later';

  @override
  String get paymentCard => 'Card Number';

  @override
  String get paymentCardExpiry => 'Expiry (MM/YY)';

  @override
  String get paymentSuccess => 'Payment Successful!';

  @override
  String get paymentEnd => 'Back to my page';

  @override
  String get pay => 'Pay';

  @override
  String get payError => 'Please fill in all fields';

  @override
  String get mapsFindUs => 'Join us here to pickup or enjoy a book';
}
