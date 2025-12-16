import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr')
  ];

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello!'**
  String get hello;

  /// No description provided for @greeting.
  ///
  /// In en, this message translates to:
  /// **'Welcome, {name}!'**
  String greeting(Object name);

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Library Of Ruina'**
  String get appTitle;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @drawerSearch.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get drawerSearch;

  /// No description provided for @drawerCart.
  ///
  /// In en, this message translates to:
  /// **'My Cart'**
  String get drawerCart;

  /// No description provided for @drawerAccount.
  ///
  /// In en, this message translates to:
  /// **'My Account and Wishlist'**
  String get drawerAccount;

  /// No description provided for @drawerFilters.
  ///
  /// In en, this message translates to:
  /// **'Apply Filters'**
  String get drawerFilters;

  /// No description provided for @drawerFindUs.
  ///
  /// In en, this message translates to:
  /// **'Where to find us'**
  String get drawerFindUs;

  /// No description provided for @drawerLogout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get drawerLogout;

  /// No description provided for @loginEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get loginEmail;

  /// No description provided for @loginPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get loginPassword;

  /// No description provided for @loginBtn.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginBtn;

  /// No description provided for @loginNew.
  ///
  /// In en, this message translates to:
  /// **'New to Ruina?'**
  String get loginNew;

  /// No description provided for @loginNewAccount.
  ///
  /// In en, this message translates to:
  /// **'Create an Account'**
  String get loginNewAccount;

  /// No description provided for @loginEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Empty Fields'**
  String get loginEmptyTitle;

  /// No description provided for @loginEmptyContent.
  ///
  /// In en, this message translates to:
  /// **'Please enter both email and password'**
  String get loginEmptyContent;

  /// No description provided for @loginUserNotregister.
  ///
  /// In en, this message translates to:
  /// **'User is not registered'**
  String get loginUserNotregister;

  /// No description provided for @loginUserInexistentContent.
  ///
  /// In en, this message translates to:
  /// **'Sorry to inform you, we do not have an account registered to this email please check again or register today!'**
  String get loginUserInexistentContent;

  /// No description provided for @loginWrongPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Incorrect Password'**
  String get loginWrongPasswordTitle;

  /// No description provided for @loginWrongPasswordContent.
  ///
  /// In en, this message translates to:
  /// **'Oops! Seems like it was the wrong password'**
  String get loginWrongPasswordContent;

  /// No description provided for @registerFName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get registerFName;

  /// No description provided for @registerLName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get registerLName;

  /// No description provided for @registerPhone.
  ///
  /// In en, this message translates to:
  /// **'PhoneNumber'**
  String get registerPhone;

  /// No description provided for @registerConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'ConfirmPassword'**
  String get registerConfirmPassword;

  /// No description provided for @registerBtn.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get registerBtn;

  /// No description provided for @registerHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get registerHaveAccount;

  /// No description provided for @registerSuccess.
  ///
  /// In en, this message translates to:
  /// **'Registration Successful!'**
  String get registerSuccess;

  /// No description provided for @registerSuccessContent.
  ///
  /// In en, this message translates to:
  /// **'Your account has been created. Please login.'**
  String get registerSuccessContent;

  /// No description provided for @bookQuantity.
  ///
  /// In en, this message translates to:
  /// **'Currently in stock'**
  String get bookQuantity;

  /// No description provided for @bookPrice.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get bookPrice;

  /// No description provided for @accountGreeting.
  ///
  /// In en, this message translates to:
  /// **'We are delighted to see you back {name}!'**
  String accountGreeting(Object name);

  /// No description provided for @accountWishList.
  ///
  /// In en, this message translates to:
  /// **'Here is your wishList'**
  String get accountWishList;

  /// No description provided for @accountLogOut.
  ///
  /// In en, this message translates to:
  /// **'LogOut'**
  String get accountLogOut;

  /// No description provided for @cart.
  ///
  /// In en, this message translates to:
  /// **'Your Cart :'**
  String get cart;

  /// No description provided for @cartEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your cart is currently empty.'**
  String get cartEmpty;

  /// No description provided for @cartSubtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get cartSubtotal;

  /// No description provided for @cartFederal.
  ///
  /// In en, this message translates to:
  /// **'Federal Taxes'**
  String get cartFederal;

  /// No description provided for @cartProvincial.
  ///
  /// In en, this message translates to:
  /// **'Provincial Taxes'**
  String get cartProvincial;

  /// No description provided for @cartCheckout.
  ///
  /// In en, this message translates to:
  /// **'Complete my order'**
  String get cartCheckout;

  /// No description provided for @cartOrderReceived.
  ///
  /// In en, this message translates to:
  /// **'We have received your order'**
  String get cartOrderReceived;

  /// No description provided for @cartThankYou.
  ///
  /// In en, this message translates to:
  /// **'Thank you for choosing the library of Ruina \n Your total is \${totalCart}'**
  String cartThankYou(Object totalCart);

  /// No description provided for @cartPayment.
  ///
  /// In en, this message translates to:
  /// **'Proceed with payment'**
  String get cartPayment;

  /// No description provided for @cartError.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get cartError;

  /// No description provided for @cartOutOfStock.
  ///
  /// In en, this message translates to:
  /// **'Some of the items in your cart are currently out of stock please try again later'**
  String get cartOutOfStock;

  /// No description provided for @paymentCard.
  ///
  /// In en, this message translates to:
  /// **'Card Number'**
  String get paymentCard;

  /// No description provided for @paymentCardExpiry.
  ///
  /// In en, this message translates to:
  /// **'Expiry (MM/YY)'**
  String get paymentCardExpiry;

  /// No description provided for @paymentSuccess.
  ///
  /// In en, this message translates to:
  /// **'Payment Successful!'**
  String get paymentSuccess;

  /// No description provided for @paymentEnd.
  ///
  /// In en, this message translates to:
  /// **'Back to my page'**
  String get paymentEnd;

  /// No description provided for @pay.
  ///
  /// In en, this message translates to:
  /// **'Pay'**
  String get pay;

  /// No description provided for @payError.
  ///
  /// In en, this message translates to:
  /// **'Please fill in all fields'**
  String get payError;

  /// No description provided for @mapsFindUs.
  ///
  /// In en, this message translates to:
  /// **'Join us here to pickup or enjoy a book'**
  String get mapsFindUs;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
