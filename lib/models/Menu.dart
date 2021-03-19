import 'package:cloud_firestore/cloud_firestore.dart';

class Menu {
  String id;
  String name;
  String imgUrl;
  String description;
  List<dynamic> recipe;
  String type;

  Menu(this.name, this.description, this.recipe, this.type, this.imgUrl);
  Menu.fromQueryDocumentSnapshot(DocumentSnapshot snapshot)
      : id = snapshot.id,
        name = snapshot["name"],
        description = snapshot["description"],
        recipe = snapshot['recipe'],
        type = snapshot["category"],
        imgUrl = snapshot["imgurl"];

  toJson() {
    return {
      "id": id,
      "imgurl": imgUrl,
      "name": name,
      "description": description,
      "category": type,
      "recipe": recipe
    };
  }
}
