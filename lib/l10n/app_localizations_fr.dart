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
    return 'Bienvenue, $name!';
  }

  @override
  String get appTitle => 'Bibliothèque de Ruina';

  @override
  String get tryAgain => 'Réessayer';

  @override
  String get drawerSearch => 'Rechercher';

  @override
  String get drawerCart => 'Mon Panier';

  @override
  String get drawerAccount => 'Mon Compte et Liste de Souhaits';

  @override
  String get drawerFilters => 'Appliquer les Filtres';

  @override
  String get drawerFindUs => 'Où nous trouver';

  @override
  String get drawerLogout => 'Déconnexion';

  @override
  String get loginEmail => 'Courriel';

  @override
  String get loginPassword => 'Mot de passe';

  @override
  String get loginBtn => 'Connexion';

  @override
  String get loginNew => 'Nouveau chez Ruina?';

  @override
  String get loginNewAccount => 'Créer un compte';

  @override
  String get loginEmptyTitle => 'Champs vides';

  @override
  String get loginEmptyContent =>
      'Veuillez entrer votre courriel et mot de passe';

  @override
  String get loginUserNotregister => 'L\'utilisateur n\'est pas enregistré';

  @override
  String get loginUserInexistentContent =>
      'Désolé de vous informer que nous n\'avons pas de compte enregistré à ce courriel. Veuillez vérifier à nouveau ou vous inscrire dès aujourd\'hui!';

  @override
  String get loginWrongPasswordTitle => 'Mot de passe incorrect';

  @override
  String get loginWrongPasswordContent =>
      'Oups! Il semble que le mot de passe soit incorrect';

  @override
  String get registerFName => 'Prénom';

  @override
  String get registerLName => 'Nom de famille';

  @override
  String get registerPhone => 'Numéro de téléphone';

  @override
  String get registerConfirmPassword => 'Confirmer le mot de passe';

  @override
  String get registerBtn => 'S\'inscrire';

  @override
  String get registerHaveAccount => 'Vous avez déjà un compte?';

  @override
  String get registerSuccess => 'Inscription réussie!';

  @override
  String get registerSuccessContent =>
      'Votre compte a été créé. Veuillez vous connecter.';

  @override
  String get bookQuantity => 'Actuellement en stock';

  @override
  String get bookPrice => 'Prix';

  @override
  String accountGreeting(Object name) {
    return 'Nous sommes ravis de vous revoir $name!';
  }

  @override
  String get accountWishList => 'Voici votre liste de souhaits';

  @override
  String get accountLogOut => 'Déconnexion';

  @override
  String get cart => 'Votre panier :';

  @override
  String get cartEmpty => 'Votre panier est actuellement vide.';

  @override
  String get cartSubtotal => 'Sous-total';

  @override
  String get cartFederal => 'Taxes fédérales';

  @override
  String get cartProvincial => 'Taxes provinciales';

  @override
  String get cartCheckout => 'Compléter ma commande';

  @override
  String get cartOrderReceived => 'Nous avons reçu votre commande';

  @override
  String cartThankYou(Object totalCart) {
    return 'Merci d\'avoir choisi la bibliothèque de Ruina\nVotre total est de $totalCart';
  }

  @override
  String get cartPayment => 'Procéder au paiement';

  @override
  String get cartError => 'Erreur';

  @override
  String get cartOutOfStock =>
      'Certains articles dans votre panier sont actuellement en rupture de stock. Veuillez réessayer plus tard';

  @override
  String get paymentCard => 'Numéro de carte';

  @override
  String get paymentCardExpiry => 'Expiration (MM/AA)';

  @override
  String get paymentSuccess => 'Paiement réussi!';

  @override
  String get paymentEnd => 'Retour à ma page';

  @override
  String get pay => 'Payer';

  @override
  String get payError => 'S\'il vous plait de remplir tout les champs';

  @override
  String get mapsFindUs =>
      'Rejoignez-nous ici pour récupérer ou profiter d\'un livre';
}
