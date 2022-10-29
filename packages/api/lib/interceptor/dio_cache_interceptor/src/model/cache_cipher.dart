import 'cache_options.dart';

/// Encrypt content/headers method.
typedef Encrypt = Future<List<int>> Function(List<int> bytes);

/// Decrypt content/headers method.
typedef Decrypt = Future<List<int>> Function(List<int> bytes);

class CacheCipher {
  const CacheCipher({required this.decrypt, required this.encrypt});

  /// Optional method to decrypt cache content
  final Decrypt decrypt;

  /// Optional method to encrypt cache content
  final Encrypt encrypt;

  static Future<List<int>?> decryptContent(
    CacheOptions options,
    List<int>? bytes,
  ) {
    final checkedCipher = options.cipher;
    if (bytes != null && checkedCipher != null) {
      return checkedCipher.decrypt(bytes);
    }
    return Future.value(bytes);
  }

  static Future<List<int>?> encryptContent(
    CacheOptions options,
    List<int>? bytes,
  ) {
    final checkedCipher = options.cipher;
    if (bytes != null && checkedCipher != null) {
      return checkedCipher.encrypt(bytes);
    }
    return Future.value(bytes);
  }
}
