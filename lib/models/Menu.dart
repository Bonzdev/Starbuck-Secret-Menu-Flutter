import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class Menu {
  String id;
  String name;
  String imgUrl;
  String description;
  String recipe;
  String type;

  Menu(this.name, this.description, this.recipe, this.type, this.imgUrl);
  Menu.fromQueryDocumentSnapshot(DocumentSnapshot snapshot)
      : name = snapshot["name"],
        description = snapshot["description"],
        recipe = "",
        type = snapshot["category"],
        imgUrl = snapshot["imgurl"];

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
