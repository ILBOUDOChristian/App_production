import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/app_localizations.dart';
import '../providers/app_providers.dart';
import '../widgets/product_card.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final favorites = ref.watch(favoritesProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n?.favoritesTitle ?? 'Mes Favoris',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: favorites.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 80, color: theme.colorScheme.outline),
                  const SizedBox(height: 16),
                  Text(
                    l10n?.favoritesEmpty ?? 'Aucun favori pour le moment',
                    style: theme.textTheme.titleMedium,
                  ),
                ],
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.72,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final product = favorites[index];
                return ProductCard(
                  key: ValueKey('fav_${product.id}'),
                  product: product,
                );
              },
            ),
    );
  }
}
