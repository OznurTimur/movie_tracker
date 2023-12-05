class Actor {
  final int id;
  final String name;
  final String profilePath;
  final String birthday;
  final String biography;


  Actor({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.birthday,
    required this.biography,
  });

  factory Actor.fromJson(Map<String, dynamic> json) {
  return Actor(
    id: json['id'],
    name: json['name'] ?? "",
    profilePath: json['profile_path'] ?? '',
    birthday: json['birthday'] ?? '',
    biography: json['biography'] ?? '',
  );
}
}


