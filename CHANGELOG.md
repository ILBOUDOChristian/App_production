# Journal des Modifications (CHANGELOG)

Toutes les modifications notables apportées à ce projet sont documentées dans ce fichier conformément aux principes de [Keep a Changelog](https://keepachangelog.com/).

---

## [1.2.0] - 2026-09-19

### Ajouté
- Suite de tests complète : 12 tests unitaires, 5 tests de widgets et 2 tests d intégration.
- Pipeline CI/CD GitHub Actions pour l analyse statique et l exécution automatique des tests.
- Support natif de l internationalisation (i18n) avec fichiers ARB (Français et Anglais).
- Gestion de l accessibilité via balises `Semantics` sur l ensemble des éléments interactifs.
- Mode sombre réactif avec bascule instantanée dans l écran Paramètres.

### Optimisé
- Performance constante à 60 FPS grâce aux constructeurs `const`, clés stables `ValueKey` et rendu optimisé de la grille.
- Lazy-loading et gestion des erreurs de chargement des images distantes.

---

## [1.1.0] - 2026-09-18

### Ajouté
- Écran des Favoris avec persistance locale réactive via Riverpod.
- Écran des Paramètres permettant la configuration du thème et de la langue.
- Barre de navigation inférieure `NavigationBar` (Material 3).

### Modifié
- Refactorisation du modèle de données `Product` avec sérialisation `toJson` et `fromJson`.
- Découpage en composants réutilisables (`ProductCard`).

---

## [1.0.0] - 2026-09-15

### Ajouté
- Initialisation de l architecture modulaire Feature-First.
- Écran Catalogue avec filtrage par catégorie (High-Tech, Mode, Maison) et barre de recherche.
- Écran Détail du produit affichant le prix, la note, la description et la disponibilité en stock.
- Gestion du Panier (ajout, incrémentation, décrémentation, calcul automatique du total).
