import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  String name;
  String img;
  String total;

  Category(this.name, this.img, this.total);
  Category.fromQueryDocumentSnapshot(DocumentSnapshot snapshot)
      : name = snapshot["name"],
        img = snapshot["img"],
        total = snapshot['total'];

  toJson() {
    return {"img": img, "name": name, "total": total};
  }
}
