class NewCity {
  final int id;
  final String name;

  NewCity({required this.id, required this.name});

  factory NewCity.fromJson(Map<String, dynamic> json) {
    return NewCity(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
    };
  }
}
