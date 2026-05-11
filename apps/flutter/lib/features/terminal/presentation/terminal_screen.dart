import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/color_schemes.dart';
import '../providers/terminal_provider.dart';

class TerminalScreen extends ConsumerStatefulWidget {
  const TerminalScreen({super.key});

  @override
  ConsumerState<TerminalScreen> createState() => _TerminalScreenState();
}

class _TerminalScreenState extends ConsumerState<TerminalScreen> {
  final TextEditingController _inputController = TextEditingController();
  final FocusNode _inputFocusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _inputController.dispose();
    _inputFocusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lines = ref.watch(terminalLinesProvider);
    final sessions = ref.watch(terminalSessionsProvider);
    final currentSession = ref.watch(currentSessionProvider);

    return Scaffold(
      backgroundColor: ColorSchemes.terminalBackground,
      appBar: AppBar(
        backgroundColor: ColorSchemes.surface,
        title: const Text('Terminal'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => ref.read(terminalSessionsProvider.notifier).newSession(),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) => _handleMenuAction(value),
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'clear', child: Text('Clear')),
              const PopupMenuItem(value: 'copy', child: Text('Copy All')),
              const PopupMenuItem(value: 'paste', child: Text('Paste')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          if (sessions.length > 1) _buildTabBar(sessions, currentSession),
          Expanded(
            child: _buildTerminalView(lines),
          ),
          _buildInputBar(),
        ],
      ),
    );
  }

  Widget _buildTabBar(List<TerminalSession> sessions, int currentSession) {
    return Container(
      height: 40,
      color: ColorSchemes.surface,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: sessions.length,
        itemBuilder: (context, index) {
          final session = sessions[index];
          final isSelected = index == currentSession;
          return GestureDetector(
            onTap: () => ref.read(currentSessionProvider.notifier).state = index,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: isSelected ? ColorSchemes.surfaceVariant : Colors.transparent,
                border: Border(
                  bottom: BorderSide(
                    color: isSelected ? ColorSchemes.primary : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    session.name,
                    style: TextStyle(
                      color: isSelected ? ColorSchemes.primary : ColorSchemes.textSecondary,
                    ),
                  ),
                  if (sessions.length > 1) ...[
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => ref.read(terminalSessionsProvider.notifier).closeSession(index),
                      child: Icon(
                        Icons.close,
                        size: 16,
                        color: ColorSchemes.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTerminalView(List<String> lines) {
    return GestureDetector(
      onTap: () => _inputFocusNode.requestFocus(),
      child: Container(
        color: ColorSchemes.terminalBackground,
        child: ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.all(16),
          itemCount: lines.length,
          itemBuilder: (context, index) {
            return Text(
              lines[index],
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 14,
                color: ColorSchemes.terminalGreen,
                height: 1.4,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInputBar() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ColorSchemes.surface,
        border: Border(
          top: BorderSide(color: ColorSchemes.surfaceVariant),
        ),
      ),
      child: Row(
        children: [
          const Text(
            '\$ ',
            style: TextStyle(
              color: ColorSchemes.primary,
              fontFamily: 'monospace',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: TextField(
              controller: _inputController,
              focusNode: _inputFocusNode,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 14,
                color: ColorSchemes.textPrimary,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter command...',
                hintStyle: TextStyle(color: ColorSchemes.textDisabled),
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              onSubmitted: _executeCommand,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: ColorSchemes.primary),
            onPressed: () => _executeCommand(_inputController.text),
          ),
        ],
      ),
    );
  }

  void _executeCommand(String command) {
    if (command.isEmpty) return;
    
    ref.read(terminalLinesProvider.notifier).addLine('\$ $command');
    ref.read(terminalLinesProvider.notifier).addLine('Executing command...');
    
    _inputController.clear();
  }

  void _handleMenuAction(String action) {
    switch (action) {
      case 'clear':
        ref.read(terminalLinesProvider.notifier).clear();
        break;
      case 'copy':
        break;
      case 'paste':
        _inputController.text = 'paste from clipboard';
        break;
    }
  }
}