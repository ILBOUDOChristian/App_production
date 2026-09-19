import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';

// --- Données Mockées Optimisées ---
final mockProducts = [
  const Product(
    id: '1',
    name: 'Casque Sans Fil ANC Pro',
    description: 'Casque haute-fidélité avec réduction active du bruit et 40h d autonomie.',
    price: 199.99,
    category: 'tech',
    imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500',
    rating: 4.8,
    stock: 15,
  ),
  const Product(
    id: '2',
    name: 'Montre Connectée Sport',
    description: 'Suivi cardiaque en continu, GPS précis et étanchéité 50m.',
    price: 149.50,
    category: 'tech',
    imageUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500',
    rating: 4.6,
    stock: 22,
  ),
  const Product(
    id: '3',
    name: 'Veste Coupe-Vent Éco',
    description: 'Veste respirante et déperlante fabriquée en matières 100% recyclées.',
    price: 89.00,
    category: 'fashion',
    imageUrl: 'https://images.unsplash.com/photo-1551028719-00167b16eac5?w=500',
    rating: 4.4,
    stock: 8,
  ),
  const Product(
    id: '4',
    name: 'Lampe d Ambiance Bois Minimaliste',
    description: 'Éclairage LED chaud modulable avec pied en chêne massif durable.',
    price: 49.99,
    category: 'home',
    imageUrl: 'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=500',
    rating: 4.7,
    stock: 12,
  ),
  const Product(
    id: '5',
    name: 'Sac à Dos Urbain Ergonomique',
    description: 'Compartiment pour ordinateur 16 pouces avec rembourrage respirant.',
    price: 69.90,
    category: 'fashion',
    imageUrl: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=500',
    rating: 4.9,
    stock: 5,
  ),
];

// --- Providers Produits & Filtrage ---
final productsProvider = Provider<List<Product>>((ref) => mockProducts);

final selectedCategoryProvider = StateProvider<String>((ref) => 'all');
final searchQueryProvider = StateProvider<String>((ref) => '');

final filteredProductsProvider = Provider<List<Product>>((ref) {
  final products = ref.watch(productsProvider);
  final category = ref.watch(selectedCategoryProvider);
  final query = ref.watch(searchQueryProvider).toLowerCase();

  return products.where((p) {
    final matchesCategory = category == 'all' || p.category == category;
    final matchesQuery = p.name.toLowerCase().contains(query) ||
        p.description.toLowerCase().contains(query);
    return matchesCategory && matchesQuery;
  }).toList();
});

// --- Panier (Cart Notifier) ---
class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addItem(Product product) {
    final index = state.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      final currentItem = state[index];
      state = [
        ...state.sublist(0, index),
        currentItem.copyWith(quantity: currentItem.quantity + 1),
        ...state.sublist(index + 1),
      ];
    } else {
      state = [...state, CartItem(product: product, quantity: 1)];
    }
  }

  void removeItem(String productId) {
    state = state.where((item) => item.product.id != productId).toList();
  }

  void updateQuantity(String productId, int quantity) {
    if (quantity <= 0) {
      removeItem(productId);
      return;
    }
    state = state.map((item) {
      if (item.product.id == productId) {
        return item.copyWith(quantity: quantity);
      }
      return item;
    }).toList();
  }

  void clearCart() {
    state = [];
  }

  double get totalPrice => state.fold(0, (sum, item) => sum + item.totalPrice);
  int get totalCount => state.fold(0, (sum, item) => sum + item.quantity);
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

// --- Favoris ---
class FavoritesNotifier extends StateNotifier<List<Product>> {
  FavoritesNotifier() : super([]);

  void toggleFavorite(Product product) {
    if (isFavorite(product.id)) {
      state = state.where((p) => p.id != product.id).toList();
    } else {
      state = [...state, product];
    }
  }

  bool isFavorite(String productId) {
    return state.any((p) => p.id == productId);
  }
}

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<Product>>((ref) {
  return FavoritesNotifier();
});

// --- Paramètres (Thème & Langue) ---
class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.light);

  void toggleTheme(bool isDark) {
    state = isDark ? ThemeMode.dark : ThemeMode.light;
  }
}

final themeModeProvider =
    StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier();
});

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(const Locale('fr'));

  void setLocale(String languageCode) {
    state = Locale(languageCode);
  }
}

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});
