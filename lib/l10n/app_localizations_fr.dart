// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Production App';

  @override
  String get catalogTitle => 'Catalogue Produits';

  @override
  String get searchHint => 'Rechercher un produit...';

  @override
  String get filterAll => 'Tous';

  @override
  String get filterTech => 'High-Tech';

  @override
  String get filterFashion => 'Mode';

  @override
  String get filterHome => 'Maison';

  @override
  String get cartTitle => 'Mon Panier';

  @override
  String get cartEmpty => 'Votre panier est vide';

  @override
  String get cartTotal => 'Total';

  @override
  String get checkoutButton => 'Passer la commande';

  @override
  String get favoritesTitle => 'Mes Favoris';

  @override
  String get favoritesEmpty => 'Aucun favori pour le moment';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get languageLabel => 'Langue';

  @override
  String get themeLabel => 'Mode Sombre';

  @override
  String get addToCart => 'Ajouter au panier';

  @override
  String get addedToCart => 'Produit ajouté au panier !';

  @override
  String get productDetails => 'Détails du produit';

  @override
  String get stockLabel => 'En stock';

  @override
  String get priceLabel => 'Prix';
}
