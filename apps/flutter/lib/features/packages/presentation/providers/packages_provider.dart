import 'package:flutter_riverpod/flutter_riverpod.dart';

class Package {
  final String name;
  final String description;
  final String version;
  final String size;
  final String category;
  final bool hasUpdate;
  final bool isInstalled;

  Package({
    required this.name,
    required this.description,
    required this.version,
    required this.size,
    required this.category,
    this.hasUpdate = false,
    this.isInstalled = false,
  });
}

final installedPackagesProvider = StateNotifierProvider<InstalledPackagesNotifier, List<Package>>((ref) {
  return InstalledPackagesNotifier();
});

class InstalledPackagesNotifier extends StateNotifier<List<Package>> {
  InstalledPackagesNotifier() : super([
    Package(
      name: 'python',
      description: 'Python programming language interpreter',
      version: '3.11.4',
      size: '12 MB',
      category: 'development',
      isInstalled: true,
    ),
    Package(
      name: 'nodejs',
      description: 'Node.js JavaScript runtime',
      version: '20.10.0',
      size: '28 MB',
      category: 'development',
      isInstalled: true,
    ),
    Package(
      name: 'git',
      description: 'Distributed version control system',
      version: '2.43.0',
      size: '8 MB',
      category: 'development',
      isInstalled: true,
    ),
    Package(
      name: 'nmap',
      description: 'Network exploration tool and security scanner',
      version: '7.94',
      size: '15 MB',
      category: 'security',
      isInstalled: true,
      hasUpdate: true,
    ),
    Package(
      name: 'metasploit-framework',
      description: 'Penetration testing framework',
      version: '6.3.45',
      size: '180 MB',
      category: 'security',
      isInstalled: true,
    ),
  ]);

  void refresh() {
    state = [...state];
  }

  void install(String name) {
    state = [
      ...state,
      Package(
        name: name,
        description: 'New package',
        version: '1.0.0',
        size: '10 MB',
        category: 'other',
        isInstalled: true,
      ),
    ];
  }

  void uninstall(String name) {
    state = state.where((p) => p.name != name).toList();
  }
}

final searchQueryProvider = StateProvider<String>((ref) => '');

final isLoadingPackagesProvider = StateProvider<bool>((ref) => false);

final selectedCategoryProvider = StateProvider<String>((ref) => 'all');