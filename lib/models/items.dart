class Items {
  int? id;
  late String name;
  late String description;
  late String image;

  Items({
    this.id,
    required this.name,
    required this.description,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
    };
  }

  Items.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    description = map['description'];
    image = map['image'];
  }
}