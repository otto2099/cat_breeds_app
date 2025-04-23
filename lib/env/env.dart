import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  late EnvMode m;

  static final Env _instance = Env._internal();
  Env._internal();

  factory Env(EnvMode mode) {
    _instance.m = mode;
    return _instance;
  }

  static String get fileName => ".env";

  String get theCatApi {
    final url = dotenv.env['THE_CAT_API'];
    if (url == null || url.isEmpty) {
      throw Exception('THE_CAT_API not defined in the environment file.');
    }
    return url;
  }
}

enum EnvMode { production, qA, dev }
