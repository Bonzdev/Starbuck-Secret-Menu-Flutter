import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:starbucksecret/models/Menu.dart';

class MenuDao {
  Stream<QuerySnapshot> getAllMenu() {
    return FirebaseFirestore.instance.collection("menus").snapshots();
  }

  Stream<QuerySnapshot> queryByName(search,category) {
    return FirebaseFirestore.instance
        .collection("menus")
        .orderBy("name")
        .where("category",isEqualTo: category)
        .startAt([search]).endAt([search + '\uf8ff']).snapshots();
  }

  Stream<DocumentSnapshot> getMenus(String id) {
    return FirebaseFirestore.instance.collection('menus').doc(id).snapshots();
  }

  Future<List> ambilData() async {
    final listMenu = [];
    await FirebaseFirestore.instance
        .collection('menus')
        .get()
        .then((QuerySnapshot snapshot) => {
              snapshot.docs.forEach((element) {
                listMenu.add(Menu.fromQueryDocumentSnapshot(element).toJson());
              })
            });
    return listMenu;
  }
}
