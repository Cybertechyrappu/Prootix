import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/color_schemes.dart';
import '../providers/linux_provider.dart';

class LinuxScreen extends ConsumerWidget {
  const LinuxScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final environments = ref.watch(linuxEnvironmentsProvider);
    final selectedEnv = ref.watch(selectedEnvironmentProvider);

    return Scaffold(
      backgroundColor: ColorSchemes.background,
      appBar: AppBar(
        title: const Text('Linux Environments'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: environments.length,
        itemBuilder: (context, index) {
          final env = environments[index];
          return _EnvironmentCard(
            environment: env,
            isSelected: selectedEnv == index,
            onTap: () => ref.read(selectedEnvironmentProvider.notifier).state = index,
            onStart: () {},
            onStop: () {},
            onConfigure: () {},
          ).animate().fadeIn(delay: (index * 100).ms).slideX(begin: 0.1);
        },
      ),
    );
  }
}

class _EnvironmentCard extends StatelessWidget {
  final LinuxEnvironment environment;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onStart;
  final VoidCallback onStop;
  final VoidCallback onConfigure;

  const _EnvironmentCard({
    required this.environment,
    required this.isSelected,
    required this.onTap,
    required this.onStart,
    required this.onStop,
    required this.onConfigure,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: ColorSchemes.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? ColorSchemes.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _getEnvColor().withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getEnvIcon(),
                    color: _getEnvColor(),
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        environment.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: ColorSchemes.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: _getStatusColor(),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            environment.status,
                            style: const TextStyle(
                              fontSize: 13,
                              color: ColorSchemes.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert, color: ColorSchemes.textSecondary),
                  onSelected: (value) {
                    switch (value) {
                      case 'start': onStart(); break;
                      case 'stop': onStop(); break;
                      case 'configure': onConfigure(); break;
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(value: 'start', child: Text('Start')),
                    const PopupMenuItem(value: 'stop', child: Text('Stop')),
                    const PopupMenuItem(value: 'configure', child: Text('Configure')),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                _buildInfoChip(Icons.storage, environment.size),
                const SizedBox(width: 12),
                _buildInfoChip(Icons.inventory_2, '${environment.packages} packages'),
                const SizedBox(width: 12),
                _buildInfoChip(Icons.cloud, environment.repository),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onStart,
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Start'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorSchemes.accent,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onStop,
                    icon: const Icon(Icons.stop),
                    label: const Text('Stop'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: ColorSchemes.surfaceVariant,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: ColorSchemes.textSecondary),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: ColorSchemes.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Color _getEnvColor() {
    if (environment.type == 'kali') {
      return ColorSchemes.neonPink;
    } else if (environment.type == 'termux') {
      return ColorSchemes.neonGreen;
    }
    return ColorSchemes.primary;
  }

  IconData _getEnvIcon() {
    if (environment.type == 'kali') {
      return Icons.security;
    } else if (environment.type == 'termux') {
      return Icons.terminal;
    }
    return Icons.cloud;
  }

  Color _getStatusColor() {
    switch (environment.status.toLowerCase()) {
      case 'running':
        return ColorSchemes.accent;
      case 'stopped':
        return ColorSchemes.textDisabled;
      case 'installing':
        return ColorSchemes.neonOrange;
      default:
        return ColorSchemes.textSecondary;
    }
  }
}