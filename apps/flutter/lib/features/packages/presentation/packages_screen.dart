import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/color_schemes.dart';
import '../providers/packages_provider.dart';

class PackagesScreen extends ConsumerStatefulWidget {
  const PackagesScreen({super.key});

  @override
  ConsumerState<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends ConsumerState<PackagesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _filter = 'all';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final packages = ref.watch(installedPackagesProvider);
    final isLoading = ref.watch(isLoadingPackagesProvider);

    return Scaffold(
      backgroundColor: ColorSchemes.background,
      appBar: AppBar(
        title: const Text('Package Manager'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(installedPackagesProvider.notifier).refresh(),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildFilterChips(),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : _buildPackagesList(packages),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showInstallDialog(context),
        icon: const Icon(Icons.download),
        label: const Text('Install'),
        backgroundColor: ColorSchemes.primary,
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search packages...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    ref.read(searchQueryProvider.notifier).state = '';
                  },
                )
              : null,
        ),
        onChanged: (value) => ref.read(searchQueryProvider.notifier).state = value,
      ),
    );
  }

  Widget _buildFilterChips() {
    final filters = ['all', 'installed', 'updates'];
    final labels = ['All', 'Installed', 'Updates'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: filters.asMap().entries.map((entry) {
          final isSelected = _filter == entry.value;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(labels[entry.key]),
              selected: isSelected,
              onSelected: (selected) {
                setState(() => _filter = entry.value);
              },
              selectedColor: ColorSchemes.primary.withOpacity(0.2),
              checkmarkColor: ColorSchemes.primary,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPackagesList(List<Package> packages) {
    if (packages.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inventory_2_outlined,
              size: 64,
              color: ColorSchemes.textDisabled,
            ),
            const SizedBox(height: 16),
            const Text(
              'No packages found',
              style: TextStyle(color: ColorSchemes.textSecondary),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: packages.length,
      itemBuilder: (context, index) {
        return _PackageCard(package: packages[index])
            .animate()
            .fadeIn(delay: (index * 50).ms)
            .slideX(begin: 0.05);
      },
    );
  }

  void _showInstallDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: ColorSchemes.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _InstallPackageSheet(),
    );
  }
}

class _PackageCard extends StatelessWidget {
  final Package package;

  const _PackageCard({required this.package});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorSchemes.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _getCategoryColor().withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              _getCategoryIcon(),
              color: _getCategoryColor(),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  package.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: ColorSchemes.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  package.description,
                  style: const TextStyle(
                    fontSize: 13,
                    color: ColorSchemes.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      package.version,
                      style: const TextStyle(
                        fontSize: 12,
                        color: ColorSchemes.textDisabled,
                        fontFamily: 'monospace',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      package.size,
                      style: const TextStyle(
                        fontSize: 12,
                        color: ColorSchemes.textDisabled,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (package.hasUpdate)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: ColorSchemes.neonOrange.withOpacity(0.15),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'Update',
                style: TextStyle(
                  fontSize: 11,
                  color: ColorSchemes.neonOrange,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Color _getCategoryColor() {
    switch (package.category) {
      case 'development':
        return ColorSchemes.neonCyan;
      case 'security':
        return ColorSchemes.neonPink;
      case 'network':
        return ColorSchemes.neonPurple;
      default:
        return ColorSchemes.neonGreen;
    }
  }

  IconData _getCategoryIcon() {
    switch (package.category) {
      case 'development':
        return Icons.code;
      case 'security':
        return Icons.security;
      case 'network':
        return Icons.wifi;
      default:
        return Icons.inventory_2;
    }
  }
}

class _InstallPackageSheet extends ConsumerStatefulWidget {
  @override
  ConsumerState<_InstallPackageSheet> createState() => _InstallPackageSheetState();
}

class _InstallPackageSheetState extends ConsumerState<_InstallPackageSheet> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Install Package',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: ColorSchemes.textPrimary,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Package name...',
                prefixIcon: Icon(Icons.search),
              ),
              autofocus: true,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Install'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}