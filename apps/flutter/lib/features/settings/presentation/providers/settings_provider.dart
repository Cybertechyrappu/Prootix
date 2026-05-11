import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeModeProvider = StateProvider<String>((ref) => 'dark');

final darkModeProvider = StateProvider<bool>((ref) => true);

final notificationsEnabledProvider = StateProvider<bool>((ref) => true);

final autoStartEnabledProvider = StateProvider<bool>((ref) => false);

final fontSizeProvider = StateProvider<double>((ref) => 14.0);

final terminalFontProvider = StateProvider<String>((ref) => 'monospace');