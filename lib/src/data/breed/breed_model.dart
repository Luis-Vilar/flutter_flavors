import 'dart:convert';

class BreedModel {
  final String name;
  final String temperament;
  final String origin;
  BreedModel({
    required this.name,
    required this.temperament,
    required this.origin,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'temperament': temperament,
      'origin': origin,
    };
  }

  factory BreedModel.fromMap(Map<String, dynamic> map) {
    return BreedModel(
      name: map['name'] as String,
      temperament: map['temperament'] as String,
      origin: map['origin'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BreedModel.fromJson(String source) =>
      BreedModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'BreedModel(name: $name, temperament: $temperament, origin: $origin)';
}
