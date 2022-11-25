import 'dart:convert';

class Pokemon {
  int? id;

  String number;

  String name;

  String category;

  bool isFavourite;

  String imageUrl;

  int height;

  int weight;

  int hp;

  int attack;

  int defence;

  int specialAttack;

  int specialDefence;

  int speed;

  Pokemon(
      {this.id,
      required this.speed,
      required this.imageUrl,
      required this.number,
      required this.name,
      required this.category,
      this.isFavourite = false,
      required this.height,
      required this.attack,
      required this.defence,
      required this.hp,
      required this.specialAttack,
      required this.specialDefence,
      required this.weight});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'number': number});
    result.addAll({'name': name});
    result.addAll({'category': category});
    result.addAll({'isFavourite': isFavourite});
    result.addAll({'imageUrl': imageUrl});
    result.addAll({'height': height});
    result.addAll({'weight': weight});
    result.addAll({'hp': hp});
    result.addAll({'attack': attack});
    result.addAll({'defence': defence});
    result.addAll({'specialAttack': specialAttack});
    result.addAll({'specialDefence': specialDefence});
    result.addAll({'speed': speed});

    return result;
  }

  factory Pokemon.fromMap(Map<String, dynamic> map) {
    return Pokemon(
      id: map['id']?.toInt(),
      number: map['number'] ?? '',
      name: map['name'] ?? '',
      category: map['category'] ?? '',
      isFavourite: map['isFavourite'] ?? false,
      imageUrl: map['imageUrl'] ?? '',
      height: map['height']?.toInt() ?? 0,
      weight: map['weight']?.toInt() ?? 0,
      hp: map['hp']?.toInt() ?? 0,
      attack: map['attack']?.toInt() ?? 0,
      defence: map['defence']?.toInt() ?? 0,
      specialAttack: map['specialAttack']?.toInt() ?? 0,
      specialDefence: map['specialDefence']?.toInt() ?? 0,
      speed: map['speed']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  Pokemon.fromJson(Map map)
      : id = map['id']?.toInt(),
        number = map['number'],
        name = map['name'],
        category = map['category'],
        isFavourite = map['isFavourite'],
        imageUrl = map['imageUrl'],
        height = map['height'],
        weight = map['weight'],
        hp = map['hp'],
        attack = map['attack'],
        defence = map['defence'],
        specialAttack = map['specialAttack'],
        specialDefence = map['specialDefence'],
        speed = map['speed'];

  // factory Pokemon.fromJson(String source) =>
  //     Pokemon.fromMap(json.decode(source));
}
