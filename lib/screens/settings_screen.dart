import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/app_providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);
    final isDark = themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        children: [
          Semantics(
            label: 'Interrupteur pour activer ou désactiver le mode sombre',
            child: SwitchListTile(
              title: const Text('Mode Sombre'),
              subtitle: Text(isDark ? 'Activé' : 'Désactivé'),
              secondary: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
              value: isDark,
              onChanged: (val) {
                ref.read(themeModeProvider.notifier).toggleTheme(val);
              },
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Langue'),
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
