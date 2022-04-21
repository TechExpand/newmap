


class LGA {
  int ?id;
  String ?name;
  String ?shortcut;


  LGA(
      {this.shortcut,
        this.id,
        this.name,
      });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      'id': id,
      "shortcut": shortcut,
    };
  }

  factory LGA.fromJson(jsonData) => LGA(
    name: jsonData["name"],
    shortcut: jsonData["shortcut"],
    id: jsonData['id'],
  );

}
