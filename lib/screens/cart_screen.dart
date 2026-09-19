import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/app_localizations.dart';
import '../providers/app_providers.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final cartItems = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n?.cartTitle ?? 'Mon Panier',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          if (cartItems.isNotEmpty)
            Semantics(
              label: 'Vider le panier',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: () {
                  cartNotifier.clearCart();
                },
              ),
            ),
        ],
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_bag_outlined, size: 80, color: theme.colorScheme.outline),
                  const SizedBox(height: 16),
                  Text(l10n?.cartEmpty ?? 'Votre panier est vide', style: theme.textTheme.titleMedium),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: cartItems.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Semantics(
                  label: 'Article ${item.product.name}, quantité ${item.quantity}',
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        item.product.imageUrl,
                        width: 56,
                        height: 56,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 56,
                          height: 56,
                          color: theme.colorScheme.surfaceContainerHighest,
                          child: const Icon(Icons.broken_image, size: 24),
                        ),
                      ),
                    ),
                    title: Text(item.product.name, maxLines: 1, overflow: TextOverflow.ellipsis),
                    subtitle: Text('${item.product.price.toStringAsFixed(2)} ${l10n?.currency ?? "€"}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Semantics(
                          label: 'Diminuer la quantité de ${item.product.name}',
                          button: true,
                          child: IconButton(
                            icon: const Icon(Icons.remove_circle_outline, size: 20),
                            onPressed: () {
                              cartNotifier.updateQuantity(item.product.id, item.quantity - 1);
                            },
                          ),
                        ),
                        Text('${item.quantity}', style: const TextStyle(fontWeight: FontWeight.bold)),
                        Semantics(
                          label: 'Augmenter la quantité de ${item.product.name}',
                          button: true,
                          child: IconButton(
                            icon: const Icon(Icons.add_circle_outline, size: 20),
                            onPressed: () {
                              cartNotifier.updateQuantity(item.product.id, item.quantity + 1);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: cartItems.isEmpty
          ? null
          : Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(l10n?.cartTotal ?? 'Total', style: theme.textTheme.titleMedium),
                        Text(
                          '${cartNotifier.totalPrice.toStringAsFixed(2)} ${l10n?.currency ?? "€"}',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: Semantics(
                        label: l10n?.checkoutButton ?? 'Passer la commande',
                        button: true,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(l10n?.orderConfirmed ?? 'Commande validée avec succès !'),
                              ),
                            );
                            cartNotifier.clearCart();
                          },
                          child: Text(
                            l10n?.checkoutButton ?? 'Passer la commande',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
