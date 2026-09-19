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
    Locale('fr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In fr, this message translates to:
  /// **'App Production-Ready'**
  String get appTitle;

  /// No description provided for @catalogTitle.
  ///
  /// In fr, this message translates to:
  /// **'Catalogue Produits'**
  String get catalogTitle;

  /// No description provided for @searchHint.
  ///
  /// In fr, this message translates to:
  /// **'Rechercher un produit...'**
  String get searchHint;

  /// No description provided for @filterAll.
  ///
  /// In fr, this message translates to:
  /// **'Tous'**
  String get filterAll;

  /// No description provided for @filterTech.
  ///
  /// In fr, this message translates to:
  /// **'High-Tech'**
  String get filterTech;

  /// No description provided for @filterFashion.
  ///
  /// In fr, this message translates to:
  /// **'Mode'**
  String get filterFashion;

  /// No description provided for @filterHome.
  ///
  /// In fr, this message translates to:
  /// **'Maison'**
  String get filterHome;

  /// No description provided for @cartTitle.
  ///
  /// In fr, this message translates to:
  /// **'Mon Panier'**
  String get cartTitle;

  /// No description provided for @cartEmpty.
  ///
  /// In fr, this message translates to:
  /// **'Votre panier est vide'**
  String get cartEmpty;

  /// No description provided for @cartTotal.
  ///
  /// In fr, this message translates to:
  /// **'Total'**
  String get cartTotal;

  /// No description provided for @checkoutButton.
  ///
  /// In fr, this message translates to:
  /// **'Passer la commande'**
  String get checkoutButton;

  /// No description provided for @orderConfirmed.
  ///
  /// In fr, this message translates to:
  /// **'Commande validée avec succès !'**
  String get orderConfirmed;

  /// No description provided for @favoritesTitle.
  ///
  /// In fr, this message translates to:
  /// **'Mes Favoris'**
  String get favoritesTitle;

  /// No description provided for @favoritesEmpty.
  ///
  /// In fr, this message translates to:
  /// **'Aucun favori pour le moment'**
  String get favoritesEmpty;

  /// No description provided for @settingsTitle.
  ///
  /// In fr, this message translates to:
  /// **'Paramètres'**
  String get settingsTitle;

  /// No description provided for @languageLabel.
  ///
  /// In fr, this message translates to:
  /// **'Langue'**
  String get languageLabel;

  /// No description provided for @themeLabel.
  ///
  /// In fr, this message translates to:
  /// **'Mode Sombre'**
  String get themeLabel;

  /// No description provided for @addToCart.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter au panier'**
  String get addToCart;

  /// No description provided for @addedToCart.
  ///
  /// In fr, this message translates to:
  /// **'ajouté au panier !'**
  String get addedToCart;

  /// No description provided for @productDetails.
  ///
  /// In fr, this message translates to:
  /// **'Détails du produit'**
  String get productDetails;

  /// No description provided for @stockLabel.
  ///
  /// In fr, this message translates to:
  /// **'En stock'**
  String get stockLabel;

  /// No description provided for @priceLabel.
  ///
  /// In fr, this message translates to:
  /// **'Prix'**
  String get priceLabel;

  /// No description provided for @descriptionLabel.
  ///
  /// In fr, this message translates to:
  /// **'Description'**
  String get descriptionLabel;

  /// No description provided for @currency.
  ///
  /// In fr, this message translates to:
  /// **'€'**
  String get currency;

  /// No description provided for @noProductsFound.
  ///
  /// In fr, this message translates to:
  /// **'Aucun produit trouvé'**
  String get noProductsFound;

  /// No description provided for @enabled.
  ///
  /// In fr, this message translates to:
  /// **'Activé'**
  String get enabled;

  /// No description provided for @disabled.
  ///
  /// In fr, this message translates to:
  /// **'Désactivé'**
  String get disabled;

  /// No description provided for @remove.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer'**
  String get remove;

  /// No description provided for @add.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter'**
  String get add;
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
    'that was used.',
  );
}
