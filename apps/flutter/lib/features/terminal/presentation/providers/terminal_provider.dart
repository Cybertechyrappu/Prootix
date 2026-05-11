import 'package:flutter_riverpod/flutter_riverpod.dart';

class TerminalSession {
  final String name;
  final String id;
  final bool isActive;

  TerminalSession({
    required this.name,
    required this.id,
    this.isActive = true,
  });
}

final terminalLinesProvider = StateNotifierProvider<TerminalLinesNotifier, List<String>>((ref) {
  return TerminalLinesNotifier();
});

class TerminalLinesNotifier extends StateNotifier<List<String>> {
  TerminalLinesNotifier() : super([
    'Prootix Linux Environment',
    'Portable Android Workstation',
    '========================================',
    '',
    'Welcome to your Linux environment.',
    'Type "help" for available commands.',
    '',
  ]);

  void addLine(String line) {
    state = [...state, line];
  }

  void clear() {
    state = [];
  }
}

final terminalSessionsProvider = StateNotifierProvider<TerminalSessionsNotifier, List<TerminalSession>>((ref) {
  return TerminalSessionsNotifier();
});

class TerminalSessionsNotifier extends StateNotifier<List<TerminalSession>> {
  int _sessionCounter = 0;

  TerminalSessionsNotifier() : super([
    TerminalSession(
      name: 'Session 1',
      id: 'session_${DateTime.now().millisecondsSinceEpoch}',
    ),
  ]);

  void newSession() {
    _sessionCounter++;
    state = [
      ...state,
      TerminalSession(
        name: 'Session ${_sessionCounter + 1}',
        id: 'session_${DateTime.now().millisecondsSinceEpoch}',
      ),
    ];
  }

  void closeSession(int index) {
    if (state.length > 1) {
      state = state.where((_, i) => i != index).toList();
    }
  }
}

final currentSessionProvider = StateProvider<int>((ref) => 0);

final isTerminalConnectedProvider = StateProvider<bool>((ref) => true);