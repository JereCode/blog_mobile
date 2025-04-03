class Category {
  int? id;
  String? name;
  String? description;

  Category({
    this.id,
    this.name,
    this.description,
  });

  Category copyWith({
    int? id,
    String? name,
    String? description,
  }) =>
      Category(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
      );

  factory Category.fromMap(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    description: json["description"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "description": description,
  };
}