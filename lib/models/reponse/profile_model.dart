class ProfileModel {
  final String email;
  final String name;

  ProfileModel({
    required this.email,
    required this.name,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      email: json["email"],
      name: json["name"],
    );
  }
  Map<String, dynamic> toJson() => {
        'email': email,
        'name': name,
      };
}
