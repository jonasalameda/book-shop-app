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
  String get drawerSearch => 'Rechercher';

  @override
  String get drawerCart => 'Mon Panier';

  @override
  String get drawerAccount => 'Mon Compte et Liste de Souhait';

  @override
  String get drawerFilters => 'Appliquer les Filtres';

  @override
  String get drawerLogout => 'Déconnexion';
}
