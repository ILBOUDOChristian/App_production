import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/app_localizations.dart';
import '../providers/app_providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);
    final isDark = themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n?.settingsTitle ?? 'Paramètres',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          Semantics(
            label: 'Interrupteur du mode sombre, actuellement ${isDark ? l10n?.enabled ?? "Activé" : l10n?.disabled ?? "Désactivé"}',
            child: SwitchListTile(
              title: Text(l10n?.themeLabel ?? 'Mode Sombre'),
              subtitle: Text(isDark ? (l10n?.enabled ?? 'Activé') : (l10n?.disabled ?? 'Désactivé')),
              secondary: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
              value: isDark,
              onChanged: (val) {
                ref.read(themeModeProvider.notifier).toggleTheme(val);
              },
            ),
          ),
          const Divider(),
          Semantics(
            label: 'Sélecteur de langue',
            child: ListTile(
              title: Text(l10n?.languageLabel ?? 'Langue'),
              subtitle: Text(locale.languageCode == 'fr' ? 'Français' : 'English'),
              leading: const Icon(Icons.language),
              trailing: DropdownButton<String>(
                value: locale.languageCode,
                underline: const SizedBox(),
                items: const [
                  DropdownMenuItem(value: 'fr', child: Text('Français (FR)')),
                  DropdownMenuItem(value: 'en', child: Text('English (EN)')),
                ],
                onChanged: (code) {
                  if (code != null) {
                    ref.read(localeProvider.notifier).setLocale(code);
                  }
                },
              ),
            ),
          ),
          const Divider(),
          const AboutListTile(
            icon: Icon(Icons.info_outline),
            applicationName: 'App Production-Ready',
            applicationVersion: 'v1.2.0',
            applicationLegalese: '© 2026 - Production Ready Flutter Project',
          ),
        ],
      ),
    );
  }
}
