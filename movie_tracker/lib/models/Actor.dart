class Actor {
  final int id;
  final String name;
  final String profilePath;
  final String birthday;


  Actor({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.birthday,
  });

  factory Actor.fromJson(Map<String, dynamic> json) {
    return Actor(
    id: json['id'],
    name: json['name'] ?? "",
    profilePath: json['profile_path'] ?? '',
    birthday:json['birthday'] ?? '',
   
  );
  }
}


