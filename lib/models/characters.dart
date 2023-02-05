class Characters {
  int? id;
  late String name;
  late int object;
  late int image;

  Characters({
    this.id,
    required this.name,
    required this.object,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'object': object,
      'image': image,
    };
  }

  Characters.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    object = map['object'];
    image = map['image'];
  }
}