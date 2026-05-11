import 'package:flutter_riverpod/flutter_riverpod.dart';

class SystemStats {
  final double cpuUsage;
  final double ramUsage;
  final int activeSessions;
  final int totalPackages;

  SystemStats({
    this.cpuUsage = 0,
    this.ramUsage = 0,
    this.activeSessions = 0,
    this.totalPackages = 0,
  });
}

final systemStatsProvider = StateProvider<SystemStats>((ref) {
  return SystemStats(
    cpuUsage: 12.5,
    ramUsage: 34.8,
    activeSessions: 2,
    totalPackages: 47,
  );
});

final environmentStatusProvider = StateProvider<String>((ref) => 'active');

final rootfsPathProvider = StateProvider<String>((ref) => '');

final isEnvironmentReadyProvider = StateProvider<bool>((ref) => true);