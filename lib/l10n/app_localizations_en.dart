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
  String get drawerSearch => 'Search';

  @override
  String get drawerCart => 'My Cart';

  @override
  String get drawerAccount => 'My Account and Wishlist';

  @override
  String get drawerFilters => 'Apply Filters';

  @override
  String get drawerLogout => 'Logout';

  @override
  String accountGreeting(Object name) {
    return 'We are delighted to see you back $name!';
  }

  @override
  String get accountWishList => 'Here is your wishList';

  @override
  String get accountLogOut => 'LogOut';
}
