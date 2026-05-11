class AppConstants {
  static const String appName = 'Prootix';
  static const String appVersion = '1.0.0';
  static const String packageName = 'com.qorvode.prootix';

  static const String termuxRepoUrl = 'https://packages.termux.org/apt/termux-main';
  static const String kaliRepoUrl = 'https://http.kali.org/kali';

  static const int minSdkVersion = 24;
  static const int targetSdkVersion = 34;
  static const int compileSdkVersion = 34;

  static const List<String> supportedAbis = [
    'arm64-v8a',
    'armeabi-v7a',
    'x86_64',
  ];

  static const String prootixDataDir = '/data/data/com.qorvode.prootix/files';
  static const String rootfsDir = '$prootixDataDir/rootfs';
  static const String sessionsDir = '$prootixDataDir/sessions';
  static const String cacheDir = '$prootixDataDir/cache';
}

enum EnvironmentType {
  minimalTerminal('Minimal Terminal', 'Shell, Python, Node.js, Git, SSH', '300MB–800MB'),
  kaliMinimal('Kali Minimal', 'Kali base, networking tools, pentesting basics', '1–2GB'),
  kaliFull('Full Kali Desktop', 'XFCE, GUI apps, X11, full Kali toolset', '4–10GB+');

  final String title;
  final String description;
  final String size;

  const EnvironmentType(this.title, this.description, this.size);
}

enum SessionState {
  active,
  paused,
  stopped,
  error,
}

enum DownloadState {
  pending,
  downloading,
  paused,
  completed,
  failed,
}