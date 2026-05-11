import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/color_schemes.dart';
import '../providers/files_provider.dart';

class FilesScreen extends ConsumerStatefulWidget {
  const FilesScreen({super.key});

  @override
  ConsumerState<FilesScreen> createState() => _FilesScreenState();
}

class _FilesScreenState extends ConsumerState<FilesScreen> {
  final TextEditingController _pathController = TextEditingController();
  String _currentPath = '/';

  @override
  void dispose() {
    _pathController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final files = ref.watch(currentFilesProvider);
    final isLoading = ref.watch(isLoadingFilesProvider);

    return Scaffold(
      backgroundColor: ColorSchemes.background,
      appBar: AppBar(
        title: const Text('File Manager'),
        actions: [
          IconButton(
            icon: const Icon(Icons.create_new_folder),
            onPressed: () => _showCreateFolderDialog(context),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _loadDirectory(_currentPath),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildPathBar(),
          const Divider(height: 1),
          _buildQuickAccess(),
          const Divider(height: 1),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : _buildFilesList(files),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showUploadDialog(context),
        backgroundColor: ColorSchemes.primary,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildPathBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: ColorSchemes.surface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.folder, color: ColorSchemes.primary, size: 18),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  value: _getRootFromPath(_currentPath),
                  underline: const SizedBox(),
                  dropdownColor: ColorSchemes.surface,
                  items: const [
                    DropdownMenuItem(value: '/', child: Text('Android')),
                    DropdownMenuItem(value: '/rootfs', child: Text('Linux')),
                  ],
                  onChanged: (value) {
                    if (value != null) _navigateTo(value);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: ColorSchemes.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.folder_open, color: ColorSchemes.textSecondary, size: 18),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _currentPath,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        color: ColorSchemes.textPrimary,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward, size: 18),
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAccess() {
    final shortcuts = [
      {'icon': Icons.home, 'label': 'Home', 'path': '/data/data/com.qorvode.prootix'},
      {'icon': Icons.download, 'label': 'Downloads', 'path': '/storage/emulated/0/Download'},
      {'icon': Icons.sd_storage, 'label': 'SD Card', 'path': '/storage'},
      {'icon': Icons.terminal, 'label': 'Rootfs', 'path': '/data/data/com.qorvode.prootix/rootfs'},
    ];

    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: shortcuts.length,
        itemBuilder: (context, index) {
          final shortcut = shortcuts[index];
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => _navigateTo(shortcut['path'] as String),
              child: Container(
                width: 80,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ColorSchemes.surface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      shortcut['icon'] as IconData,
                      color: ColorSchemes.primary,
                      size: 24,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      shortcut['label'] as String,
                      style: const TextStyle(
                        fontSize: 11,
                        color: ColorSchemes.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFilesList(List<FileItem> files) {
    if (files.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.folder_open, size: 64, color: ColorSchemes.textDisabled),
            const SizedBox(height: 16),
            const Text(
              'No files found',
              style: TextStyle(color: ColorSchemes.textSecondary),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () => _showUploadDialog(context),
              icon: const Icon(Icons.upload),
              label: const Text('Upload File'),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: files.length,
      itemBuilder: (context, index) {
        return _FileCard(
          file: files[index],
          onTap: () {
            if (files[index].isDirectory) {
              _navigateTo(files[index].path);
            }
          },
          onDelete: () => _deleteFile(files[index]),
        );
      },
    );
  }

  void _navigateTo(String path) {
    setState(() => _currentPath = path);
    ref.read(currentPathProvider.notifier).state = path;
    ref.read(isLoadingFilesProvider.notifier).state = true;
    Future.delayed(const Duration(milliseconds: 300), () {
      ref.read(isLoadingFilesProvider.notifier).state = false;
    });
  }

  void _loadDirectory(String path) {
    ref.read(isLoadingFilesProvider.notifier).state = true;
    Future.delayed(const Duration(milliseconds: 500), () {
      ref.read(isLoadingFilesProvider.notifier).state = false;
    });
  }

  void _deleteFile(FileItem file) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ColorSchemes.surface,
        title: const Text('Delete File'),
        content: Text('Are you sure you want to delete "${file.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: ColorSchemes.error),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showCreateFolderDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ColorSchemes.surface,
        title: const Text('Create Folder'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Folder name',
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _showUploadDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: ColorSchemes.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.folder, color: ColorSchemes.primary),
              title: const Text('Browse Files'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.archive, color: ColorSchemes.neonPurple),
              title: const Text('Extract Archive'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.cloud_upload, color: ColorSchemes.neonGreen),
              title: const Text('Download from URL'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  String _getRootFromPath(String path) {
    if (path.startsWith('/data/data/com.qorvode.prootix/rootfs')) return '/rootfs';
    if (path.startsWith('/storage')) return '/storage';
    return '/';
  }
}

class _FileCard extends StatelessWidget {
  final FileItem file;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _FileCard({
    required this.file,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: ColorSchemes.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _getFileColor().withOpacity(0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            _getFileIcon(),
            color: _getFileColor(),
            size: 24,
          ),
        ),
        title: Text(
          file.name,
          style: const TextStyle(
            color: ColorSchemes.textPrimary,
            fontWeight: FontWeight.w500,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          '${file.size} • ${file.modified}',
          style: const TextStyle(
            color: ColorSchemes.textSecondary,
            fontSize: 12,
          ),
        ),
        trailing: PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert, color: ColorSchemes.textSecondary),
          onSelected: (value) {
            switch (value) {
              case 'delete': onDelete(); break;
              case 'rename': break;
              case 'copy': break;
              case 'move': break;
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'rename', child: Text('Rename')),
            const PopupMenuItem(value: 'copy', child: Text('Copy')),
            const PopupMenuItem(value: 'move', child: Text('Move')),
            const PopupMenuItem(value: 'delete', child: Text('Delete')),
          ],
        ),
        onTap: onTap,
      ),
    );
  }

  IconData _getFileIcon() {
    if (file.isDirectory) return Icons.folder;
    final ext = file.name.split('.').last.toLowerCase();
    switch (ext) {
      case 'pdf': return Icons.picture_as_pdf;
      case 'jpg': case 'jpeg': case 'png': case 'gif': return Icons.image;
      case 'mp3': case 'wav': case 'flac': return Icons.audio_file;
      case 'mp4': case 'mkv': case 'avi': return Icons.video_file;
      case 'zip': case 'tar': case 'gz': case 'xz': return Icons.archive;
      case 'txt': case 'md': return Icons.description;
      case 'sh': case 'bash': return Icons.terminal;
      default: return Icons.insert_drive_file;
    }
  }

  Color _getFileColor() {
    if (file.isDirectory) return ColorSchemes.neonCyan;
    final ext = file.name.split('.').last.toLowerCase();
    switch (ext) {
      case 'pdf': return ColorSchemes.error;
      case 'jpg': case 'jpeg': case 'png': case 'gif': return ColorSchemes.neonGreen;
      case 'mp3': case 'wav': case 'flac': return ColorSchemes.neonPurple;
      case 'mp4': case 'mkv': case 'avi': return ColorSchemes.neonOrange;
      case 'zip': case 'tar': case 'gz': case 'xz': return ColorSchemes.neonCyan;
      default: return ColorSchemes.textSecondary;
    }
  }
}