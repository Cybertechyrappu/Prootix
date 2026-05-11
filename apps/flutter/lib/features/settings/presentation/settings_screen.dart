import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/color_schemes.dart';
import 'providers/settings_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(notificationsEnabledProvider);
    final autoStart = ref.watch(autoStartEnabledProvider);
    final darkMode = ref.watch(darkModeProvider);

    return Scaffold(
      backgroundColor: ColorSchemes.background,
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSection('Appearance', [
            _buildSwitchTile(
              icon: Icons.dark_mode,
              title: 'Dark Mode',
              subtitle: 'Use dark theme throughout the app',
              value: darkMode,
              onChanged: (value) => ref.read(darkModeProvider.notifier).state = value,
            ),
          ]),
          const SizedBox(height: 24),
          _buildSection('Behavior', [
            _buildSwitchTile(
              icon: Icons.notifications,
              title: 'Notifications',
              subtitle: 'Show notifications for terminal sessions',
              value: notifications,
              onChanged: (value) => ref.read(notificationsEnabledProvider.notifier).state = value,
            ),
            _buildSwitchTile(
              icon: Icons.play_arrow,
              title: 'Auto Start',
              subtitle: 'Start Linux environment on app launch',
              value: autoStart,
              onChanged: (value) => ref.read(autoStartEnabledProvider.notifier).state = value,
            ),
          ]),
          const SizedBox(height: 24),
          _buildSection('Storage', [
            _buildTile(
              icon: Icons.folder,
              title: 'Storage Location',
              subtitle: '/data/data/com.qorvode.prootix',
              onTap: () {},
            ),
            _buildTile(
              icon: Icons.delete_outline,
              title: 'Clear Cache',
              subtitle: 'Remove temporary files',
              onTap: () => _showClearCacheDialog(context),
            ),
          ]),
          const SizedBox(height: 24),
          _buildSection('Environment', [
            _buildTile(
              icon: Icons.cloud,
              title: 'Repository Mirrors',
              subtitle: 'Configure package sources',
              onTap: () {},
            ),
            _buildTile(
              icon: Icons.sync,
              title: 'Sync Settings',
              subtitle: 'Backup and restore configuration',
              onTap: () {},
            ),
          ]),
          const SizedBox(height: 24),
          _buildSection('About', [
            _buildTile(
              icon: Icons.info_outline,
              title: 'Version',
              subtitle: '1.0.0 (Build 1)',
              onTap: null,
            ),
            _buildTile(
              icon: Icons.code,
              title: 'Source Code',
              subtitle: 'View on GitHub',
              onTap: () {},
            ),
            _buildTile(
              icon: Icons.bug_report,
              title: 'Report Issue',
              subtitle: 'Submit a bug report',
              onTap: () {},
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: ColorSchemes.primary,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: ColorSchemes.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: ColorSchemes.primary.withOpacity(0.15),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: ColorSchemes.primary, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: ColorSchemes.textPrimary,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: ColorSchemes.textSecondary,
          fontSize: 13,
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: ColorSchemes.primary,
      ),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: ColorSchemes.primary.withOpacity(0.15),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: ColorSchemes.primary, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: ColorSchemes.textPrimary,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: ColorSchemes.textSecondary,
          fontSize: 13,
        ),
      ),
      trailing: onTap != null
          ? const Icon(Icons.chevron_right, color: ColorSchemes.textSecondary)
          : null,
      onTap: onTap,
    );
  }

  void _showClearCacheDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ColorSchemes.surface,
        title: const Text('Clear Cache'),
        content: const Text('This will remove all temporary files. Your Linux environment will not be affected.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }
}