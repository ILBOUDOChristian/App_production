import 'package:flutter_test/flutter_test.dart';
import 'package:app_production/models/product.dart';
import 'package:app_production/providers/app_providers.dart';
import 'package:flutter/material.dart';

void main() {
  group('Product Model & Logic Tests', () {
    const sampleProduct = Product(
      id: 'p1',
      name: 'Produit Test',
      description: 'Description du produit test',
      price: 50.0,
      category: 'tech',
      imageUrl: 'https://example.com/p1.jpg',
      rating: 4.5,
      stock: 10,
    );

    test('1. Product fromJson deserialise correctement', () {
      final json = {
        'id': 'p1',
        'name': 'Produit Test',
        'description': 'Description du produit test',
        'price': 50.0,
        'category': 'tech',
        'imageUrl': 'https://example.com/p1.jpg',
        'rating': 4.5,
        'stock': 10,
      };
      final p = Product.fromJson(json);
      expect(p.id, equals('p1'));
      expect(p.price, equals(50.0));
      expect(p.stock, equals(10));
    });

    test('2. Product toJson serialise fidelement les attributs', () {
      final json = sampleProduct.toJson();
      expect(json['id'], equals('p1'));
      expect(json['name'], equals('Produit Test'));
      expect(json['category'], equals('tech'));
    });

    test('3. CartItem calcule exactement le totalPrice', () {
      const item = CartItem(product: sampleProduct, quantity: 3);
      expect(item.totalPrice, equals(150.0));
    });

    test('4. CartItem copyWith met a jour la quantite sans muter le produit', () {
      const item = CartItem(product: sampleProduct, quantity: 1);
      final updated = item.copyWith(quantity: 5);
      expect(updated.quantity, equals(5));
      expect(updated.product.id, equals(sampleProduct.id));
    });
  });

  group('CartNotifier Unit Tests', () {
    const prodA = Product(
      id: 'a',
      name: 'A',
      description: 'Desc A',
      price: 20.0,
      category: 'tech',
      imageUrl: '',
      rating: 4.0,
      stock: 5,
    );

    test('5. addItem ajoute un nouveau produit au panier', () {
      final notifier = CartNotifier();
      notifier.addItem(prodA);
      expect(notifier.state.length, equals(1));
      expect(notifier.totalCount, equals(1));
      expect(notifier.totalPrice, equals(20.0));
    });

    test('6. addItem incremente la quantite si le produit existe deja', () {
      final notifier = CartNotifier();
      notifier.addItem(prodA);
      notifier.addItem(prodA);
      expect(notifier.state.length, equals(1));
      expect(notifier.totalCount, equals(2));
      expect(notifier.totalPrice, equals(40.0));
    });

    test('7. updateQuantity modifie fidelement la quantite', () {
      final notifier = CartNotifier();
      notifier.addItem(prodA);
      notifier.updateQuantity('a', 4);
      expect(notifier.totalCount, equals(4));
      expect(notifier.totalPrice, equals(80.0));
    });

    test('8. updateQuantity a zero supprime l article du panier', () {
      final notifier = CartNotifier();
      notifier.addItem(prodA);
      notifier.updateQuantity('a', 0);
      expect(notifier.state, isEmpty);
      expect(notifier.totalCount, equals(0));
    });

    test('9. clearCart vide completement le panier', () {
      final notifier = CartNotifier();
      notifier.addItem(prodA);
      notifier.clearCart();
      expect(notifier.state, isEmpty);
      expect(notifier.totalPrice, equals(0.0));
    });
  });

  group('FavoritesNotifier & Settings Unit Tests', () {
    const prodB = Product(
      id: 'b',
      name: 'B',
      description: 'Desc B',
      price: 15.0,
      category: 'fashion',
      imageUrl: '',
      rating: 4.2,
      stock: 3,
    );

    test('10. toggleFavorite ajoute puis retire un produit des favoris', () {
      final favNotifier = FavoritesNotifier();
      expect(favNotifier.isFavorite('b'), isFalse);

      favNotifier.toggleFavorite(prodB);
      expect(favNotifier.isFavorite('b'), isTrue);
      expect(favNotifier.state.length, equals(1));

      favNotifier.toggleFavorite(prodB);
      expect(favNotifier.isFavorite('b'), isFalse);
      expect(favNotifier.state, isEmpty);
    });

    test('11. ThemeModeNotifier commute correctement entre clair et sombre', () {
      final themeNotifier = ThemeModeNotifier();
      expect(themeNotifier.state, equals(ThemeMode.light));

      themeNotifier.toggleTheme(true);
      expect(themeNotifier.state, equals(ThemeMode.dark));

      themeNotifier.toggleTheme(false);
      expect(themeNotifier.state, equals(ThemeMode.light));
    });

    test('12. LocaleNotifier met a jour la langue de l application', () {
      final localeNotifier = LocaleNotifier();
      expect(localeNotifier.state.languageCode, equals('fr'));

      localeNotifier.setLocale('en');
      expect(localeNotifier.state.languageCode, equals('en'));
    });
  });
}
