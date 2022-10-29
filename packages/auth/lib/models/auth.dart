class AuthModel {
  final int? id;
  final int? ext;
  final int? iat;
  final String? userName;

  AuthModel({
    this.id,
    this.ext,
    this.iat,
    this.userName,
  });
  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        ext: json['ext'] as int?,
        iat: json['iat'] as int?,
        userName: json['userName'] as String?,
        id: json['id'] as int?,
      );
}
