import 'package:flutter_riverpod/flutter_riverpod.dart';

class Session {
  final String name;
  final String type;
  final String status;
  final String duration;
  final String memory;
  final String pid;
  final DateTime createdAt;

  Session({
    required this.name,
    required this.type,
    required this.status,
    required this.duration,
    required this.memory,
    required this.pid,
    required this.createdAt,
  });
}

final sessionsProvider = StateNotifierProvider<SessionsNotifier, List<Session>>((ref) {
  return SessionsNotifier();
});

class SessionsNotifier extends StateNotifier<List<Session>> {
  SessionsNotifier() : super([
    Session(
      name: 'Session 1',
      type: 'bash',
      status: 'Running',
      duration: '2h 34m',
      memory: '128 MB',
      pid: '12345',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Session(
      name: 'SSH - Server',
      type: 'ssh',
      status: 'Running',
      duration: '45m',
      memory: '64 MB',
      pid: '12346',
      createdAt: DateTime.now().subtract(const Duration(minutes: 45)),
    ),
  ]);

  void createSession() {
    final count = state.length + 1;
    state = [
      ...state,
      Session(
        name: 'Session $count',
        type: 'bash',
        status: 'Running',
        duration: '0m',
        memory: '32 MB',
        pid: '${12347 + count}',
        createdAt: DateTime.now(),
      ),
    ];
  }

  void stopSession(int index) {
    state = [
      ...state,
    ];
    state = state.where((s, i) => i != index).toList();
  }

  void pauseSession(int index) {
    final session = state[index];
    state = [
      ...state.sublist(0, index),
      Session(
        name: session.name,
        type: session.type,
        status: 'Paused',
        duration: session.duration,
        memory: session.memory,
        pid: session.pid,
        createdAt: session.createdAt,
      ),
      ...state.sublist(index + 1),
    ];
  }
}

final activeSessionCountProvider = Provider<int>((ref) {
  final sessions = ref.watch(sessionsProvider);
  return sessions.where((s) => s.status == 'Running').length;
});