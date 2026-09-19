import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/app_localizations.dart';
import '../providers/app_providers.dart';
import '../widgets/product_card.dart';

class CatalogScreen extends ConsumerWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final products = ref.watch(filteredProductsProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final theme = Theme.of(context);

    final categories = [
      {'id': 'all', 'label': l10n?.filterAll ?? 'Tous'},
      {'id': 'tech', 'label': l10n?.filterTech ?? 'High-Tech'},
      {'id': 'fashion', 'label': l10n?.filterFashion ?? 'Mode'},
      {'id': 'home', 'label': l10n?.filterHome ?? 'Maison'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n?.catalogTitle ?? 'Catalogue Produits',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Barre de recherche avec Semantics
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Semantics(
              label: l10n?.searchHint ?? 'Rechercher un produit...',
              textField: true,
              child: TextField(
                decoration: InputDecoration(
                  hintText: l10n?.searchHint ?? 'Rechercher un produit...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  ref.read(searchQueryProvider.notifier).state = value;
                },
              ),
            ),
          ),

          // Filtres par catégorie
          SizedBox(
            height: 48,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: categories.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final cat = categories[index];
                final isSelected = selectedCategory == cat['id'];
                return Semantics(
                  label: 'Filtre ${cat['label']}',
                  selected: isSelected,
                  button: true,
                  child: ChoiceChip(
                    label: Text(cat['label']!),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        ref.read(selectedCategoryProvider.notifier).state = cat['id']!;
                      }
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),

          // Grille des produits optimisée (60fps avec clé stable)
          Expanded(
            child: products.isEmpty
                ? Center(child: Text(l10n?.noProductsFound ?? 'Aucun produit trouvé'))
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.72,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ProductCard(
                        key: ValueKey(product.id),
                        product: product,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
