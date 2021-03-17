import 'package:firebase_database/firebase_database.dart';

class Menu {
  String id;
  String name;
  String imgUrl;
  String description;
  String recipe;
  String type;

  Menu(this.name, this.description, this.recipe, this.type, this.imgUrl);
  Menu.fromMap(Map<dynamic, dynamic> snapshot)
      : id = snapshot["id"],
        name = snapshot["name"],
        description = snapshot["description"],
        recipe = "",
        type = snapshot["category"],
        imgUrl = snapshot["imgurl"];

  Menu.fromSnapshot(DataSnapshot snapshot)
      : id = snapshot.key,
        name = snapshot.value["name"],
        description = snapshot.value["description"],
        recipe = "",
        type = snapshot.value["category"],
        imgUrl = snapshot.value["imgurl"];

  toJson() {
    return {
      "id": id,
      "imgUrl": imgUrl,
      "name": name,
      "description": description,
      "type": type,
      "recipe": ""
    };
  }
}
