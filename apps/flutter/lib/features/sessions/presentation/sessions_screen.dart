import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/color_schemes.dart';
import '../providers/sessions_provider.dart';

class SessionsScreen extends ConsumerWidget {
  const SessionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessions = ref.watch(sessionsProvider);

    return Scaffold(
      backgroundColor: ColorSchemes.background,
      appBar: AppBar(
        title: const Text('Sessions'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => ref.read(sessionsProvider.notifier).createSession(),
          ),
        ],
      ),
      body: sessions.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: sessions.length,
              itemBuilder: (context, index) {
                final session = sessions[index];
                return _SessionCard(
                  session: session,
                  onPause: () {},
                  onStop: () => ref.read(sessionsProvider.notifier).stopSession(index),
                  onResume: () {},
                );
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 64,
            color: ColorSchemes.textDisabled,
          ),
          const SizedBox(height: 16),
          const Text(
            'No active sessions',
            style: TextStyle(
              fontSize: 18,
              color: ColorSchemes.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Start a new session from the terminal',
            style: TextStyle(
              color: ColorSchemes.textDisabled,
            ),
          ),
        ],
      ),
    );
  }
}

class _SessionCard extends StatelessWidget {
  final Session session;
  final VoidCallback onPause;
  final VoidCallback onStop;
  final VoidCallback onResume;

  const _SessionCard({
    required this.session,
    required this.onPause,
    required this.onStop,
    required this.onResume,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ColorSchemes.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: _getStatusColor(),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                session.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: ColorSchemes.textPrimary,
                ),
              ),
              const Spacer(),
              Text(
                session.status,
                style: TextStyle(
                  color: _getStatusColor(),
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildInfoChip(Icons.terminal, session.type),
              const SizedBox(width: 12),
              _buildInfoChip(Icons.schedule, session.duration),
              const SizedBox(width: 12),
              _buildInfoChip(Icons.memory, session.memory),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              if (session.status == 'Running')
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onPause,
                    icon: const Icon(Icons.pause, size: 18),
                    label: const Text('Pause'),
                  ),
                ),
              if (session.status == 'Paused')
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onResume,
                    icon: const Icon(Icons.play_arrow, size: 18),
                    label: const Text('Resume'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorSchemes.accent,
                    ),
                  ),
                ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onStop,
                  icon: const Icon(Icons.stop, size: 18),
                  label: const Text('Stop'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: ColorSchemes.error,
                    side: const BorderSide(color: ColorSchemes.error),
                  ),
                ),
              ),
            ],
          ),
        ],
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

  Color _getStatusColor() {
    switch (session.status) {
      case 'Running':
        return ColorSchemes.accent;
      case 'Paused':
        return ColorSchemes.neonOrange;
      case 'Stopped':
        return ColorSchemes.textDisabled;
      default:
        return ColorSchemes.textSecondary;
    }
  }
}