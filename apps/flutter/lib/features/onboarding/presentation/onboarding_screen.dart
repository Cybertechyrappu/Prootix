import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/color_schemes.dart';
import '../providers/onboarding_provider.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedEnv = ref.watch(selectedEnvironmentProvider);

    return Scaffold(
      backgroundColor: ColorSchemes.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              _buildHeader()
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .slideY(begin: -0.2, end: 0),
              const SizedBox(height: 48),
              _buildSubtitle()
                  .animate()
                  .fadeIn(delay: 200.ms, duration: 600.ms),
              const SizedBox(height: 40),
              _buildEnvironmentCards(context, ref)
                  .animate()
                  .fadeIn(delay: 400.ms, duration: 600.ms),
              const Spacer(),
              _buildInstallButton(context, ref, selectedEnv)
                  .animate()
                  .fadeIn(delay: 600.ms, duration: 600.ms)
                  .slideY(begin: 0.2, end: 0),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: ColorSchemes.primary.withOpacity(0.15),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.terminal,
                color: ColorSchemes.primary,
                size: 32,
              ),
            ),
            const SizedBox(width: 16),
            const Text(
              'Prootix',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: ColorSchemes.textPrimary,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'Turn your Android device into a\nportable Linux workstation.',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: ColorSchemes.textPrimary,
            height: 1.3,
          ),
        ),
      ],
    );
  }

  Widget _buildSubtitle() {
    return Text(
      'Choose your environment',
      style: TextStyle(
        fontSize: 18,
        color: ColorSchemes.textSecondary,
      ),
    );
  }

  Widget _buildEnvironmentCards(BuildContext context, WidgetRef ref) {
    final environments = [
      _EnvironmentOption(
        title: 'Minimal Terminal',
        description: 'Shell, Python, Node.js, Git, SSH, utilities',
        size: '300MB–800MB',
        icon: Icons.terminal,
        color: ColorSchemes.neonGreen,
      ),
      _EnvironmentOption(
        title: 'Kali Minimal',
        description: 'Kali base, networking tools, pentesting basics',
        size: '1–2GB',
        icon: Icons.security,
        color: ColorSchemes.neonPink,
      ),
      _EnvironmentOption(
        title: 'Full Kali Desktop',
        description: 'XFCE, GUI apps, X11, full Kali toolset',
        size: '4–10GB+',
        icon: Icons.desktop_windows,
        color: ColorSchemes.neonPurple,
      ),
    ];

    return Column(
      children: environments.asMap().entries.map((entry) {
        final index = entry.key;
        final env = entry.value;
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _EnvironmentCard(
            option: env,
            isSelected: ref.read(selectedEnvironmentProvider) == index,
            onTap: () => ref.read(selectedEnvironmentProvider.notifier).state = index,
          ).animate().fadeIn(delay: (500 + index * 100).ms).slideX(begin: 0.1),
        );
      }).toList(),
    );
  }

  Widget _buildInstallButton(
    BuildContext context,
    WidgetRef ref,
    int selectedEnv,
  ) {
    final environments = ['Minimal Terminal', 'Kali Minimal', 'Full Kali Desktop'];
    final selectedName = selectedEnv >= 0 && selectedEnv < environments.length
        ? environments[selectedEnv]
        : 'Select Environment';

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: selectedEnv >= 0
            ? () => context.go('/home')
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorSchemes.primary,
          disabledBackgroundColor: ColorSchemes.surfaceVariant,
        ),
        child: Text(
          selectedEnv >= 0 ? 'Install $selectedName' : 'Select an environment',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _EnvironmentOption {
  final String title;
  final String description;
  final String size;
  final IconData icon;
  final Color color;

  _EnvironmentOption({
    required this.title,
    required this.description,
    required this.size,
    required this.icon,
    required this.color,
  });
}

class _EnvironmentCard extends StatelessWidget {
  final _EnvironmentOption option;
  final bool isSelected;
  final VoidCallback onTap;

  const _EnvironmentCard({
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: ColorSchemes.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? ColorSchemes.primary : Colors.transparent,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: ColorSchemes.primary.withOpacity(0.2),
                    blurRadius: 20,
                    spreadRadius: -2,
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: option.color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                option.icon,
                color: option.color,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    option.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: ColorSchemes.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    option.description,
                    style: TextStyle(
                      fontSize: 13,
                      color: ColorSchemes.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: ColorSchemes.surfaceVariant,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    option.size,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: ColorSchemes.textSecondary,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? ColorSchemes.primary
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? ColorSchemes.primary
                          : ColorSchemes.textDisabled,
                      width: 2,
                    ),
                  ),
                  child: isSelected
                      ? const Icon(
                          Icons.check,
                          size: 16,
                          color: ColorSchemes.onPrimary,
                        )
                      : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}