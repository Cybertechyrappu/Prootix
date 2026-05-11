import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedEnvironmentProvider = StateProvider<int>((ref) => -1);

final onboardingCompletedProvider = StateProvider<bool>((ref) => false);

final installationProgressProvider = StateProvider<double>((ref) => 0.0);

final isInstallingProvider = StateProvider<bool>((ref) => false);