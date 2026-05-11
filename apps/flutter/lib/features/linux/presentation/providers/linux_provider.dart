import 'package:flutter_riverpod/flutter_riverpod.dart';

class LinuxEnvironment {
  final String name;
  final String type;
  final String status;
  final String size;
  final int packages;
  final String repository;
  final String rootfsPath;

  LinuxEnvironment({
    required this.name,
    required this.type,
    required this.status,
    required this.size,
    required this.packages,
    required this.repository,
    required this.rootfsPath,
  });
}

final linuxEnvironmentsProvider = StateProvider<List<LinuxEnvironment>>((ref) {
  return [
    LinuxEnvironment(
      name: 'Kali Rolling',
      type: 'kali',
      status: 'Running',
      size: '2.4 GB',
      packages: 47,
      repository: 'http.kali.org',
      rootfsPath: '/data/data/com.qorvode.prootix/rootfs/kali',
    ),
    LinuxEnvironment(
      name: 'Termux Main',
      type: 'termux',
      status: 'Stopped',
      size: '520 MB',
      packages: 12,
      repository: 'packages.termux.org',
      rootfsPath: '/data/data/com.qorvode.prootix/rootfs/termux',
    ),
  ];
});

final selectedEnvironmentProvider = StateProvider<int>((ref) => 0);

final environmentStatusProvider = StateProvider<Map<String, String>>((ref) => {
  'kali': 'running',
  'termux': 'stopped',
});