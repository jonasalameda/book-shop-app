// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get hello => 'Bonjour!';

  @override
  String greeting(Object name) {
    return 'Bienvenu, $name!';
  }

  @override
  String get appTitle => 'Bibliotheque de Ruina';

  @override
  String get drawerSearch => 'Rechercher';

  @override
  String get drawerCart => 'Mon Panier';

  @override
  String get drawerAccount => 'Mon Compte et Liste de Souhait';

  @override
  String get drawerFilters => 'Appliquer les Filtres';

  @override
  String get drawerFindUs => 'Où nous trouver';

  @override
  String get drawerLogout => 'Déconnexion';

  @override
  String accountGreeting(Object name) {
    return 'On est Content de te revoir $name!';
  }

  @override
  String get accountWishList => 'Voici votre liste de souhaites';

  @override
  String get accountLogOut => 'Déconnexion';

  @override
  String get cart => 'Votre Panier :';

  @override
  String get cartEmpty => 'Votre panier est vide au moment';

  @override
  String get cartSubtotal => 'Soustotal';

  @override
  String get cartFederal => 'Taxes Federales';

  @override
  String get cartProvincial => 'Taxes Provinciales';

  @override
  String get cartCheckout => 'Complete my order';

  @override
  String get mapsFindUs =>
      'Rejoignez-nous ici pour récupérer ou savourer un livre';
}
