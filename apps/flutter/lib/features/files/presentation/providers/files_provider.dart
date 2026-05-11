import 'package:flutter_riverpod/flutter_riverpod.dart';

class FileItem {
  final String name;
  final String path;
  final String size;
  final String modified;
  final bool isDirectory;
  final bool isHidden;

  FileItem({
    required this.name,
    required this.path,
    required this.size,
    required this.modified,
    this.isDirectory = false,
    this.isHidden = false,
  });
}

final currentPathProvider = StateProvider<String>((ref) => '/');

final currentFilesProvider = StateProvider<List<FileItem>>((ref) => [
  FileItem(name: 'rootfs', path: '/rootfs', size: '2.4 GB', modified: 'Today', isDirectory: true),
  FileItem(name: 'sessions', path: '/sessions', size: '32 MB', modified: 'Yesterday', isDirectory: true),
  FileItem(name: 'cache', path: '/cache', size: '128 MB', modified: '2 days ago', isDirectory: true),
  FileItem(name: 'packages', path: '/packages', size: '1.2 GB', modified: 'Today', isDirectory: true),
  FileItem(name: 'config.yaml', path: '/config.yaml', size: '4 KB', modified: '1 week ago'),
  FileItem(name: 'environment.log', path: '/environment.log', size: '256 KB', modified: 'Today'),
]);

final isLoadingFilesProvider = StateProvider<bool>((ref) => false);

final selectedFileProvider = StateProvider<String?>((ref) => null);

final sortOrderProvider = StateProvider<String>((ref) => 'name');

final showHiddenFilesProvider = StateProvider<bool>((ref) => false);