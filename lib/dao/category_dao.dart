import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:starbucksecret/models/Category.dart';

class CategoryDao {
  Stream<QuerySnapshot> getAllCategory() {
    return FirebaseFirestore.instance.collection("categories").orderBy("position").snapshots();
  }

  Stream<QuerySnapshot> queryByName(search) {
    return FirebaseFirestore.instance
        .collection("categories")
        .orderBy("name")
        .startAt([search]).endAt([search + '\uf8ff']).snapshots();
  }

  Stream<DocumentSnapshot> getCategory(String id) {
    return FirebaseFirestore.instance
        .collection('categories')
        .doc(id)
        .snapshots();
  }

  Future<List> ambilData() async {
    final listMenu = [];
    await FirebaseFirestore.instance
        .collection('categories')
        .get()
        .then((QuerySnapshot snapshot) => {
              snapshot.docs.forEach((element) {
                listMenu
                    .add(Category.fromQueryDocumentSnapshot(element).toJson());
              })
            });
    return listMenu;
  }
}
