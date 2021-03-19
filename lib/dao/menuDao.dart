import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:starbucksecret/models/Menu.dart';
import 'package:firebase_database/firebase_database.dart';

class MenuDao {
  final _menuRef = FirebaseDatabase.instance.reference().child('menus');
  List<Menu> menus = [
    Menu(
        "Skittles Frappuccino",
        "Skittles are one of the most popular and well marketed fruit flavored sweets. They’re colorful, delicious and fun to eat! What’s not to love!",
        "Strawberries and Crème Frappuccino|No classic syrup|Add Vanilla Syrup (2 pumps tall, 3 pumps grande, 4 pumps venti)|Add Raspberry Syrup (½ pump tall, 1 pump grande, 1.5 pumps venti)",
        "Frappucino",
        "https://assets.rebelmouse.io/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpbWFnZSI6Imh0dHBzOi8vYXNzZXRzLnJibC5tcy8xODMxMjEwOC9vcmlnaW4uanBnIiwiZXhwaXJlc19hdCI6MTY1OTA1MTUzNH0.dDjYX4M1Cd7LyZz9HmD3sK7G7JmOc5XQZ9IO7uXdt-Q/img.jpg?width=980"),
    Menu("candi2 Cane Frappucino", "ss", "", "Frappucino",
        "https://assets.rebelmouse.io/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpbWFnZSI6Imh0dHBzOi8vYXNzZXRzLnJibC5tcy8xODMxMjEwOC9vcmlnaW4uanBnIiwiZXhwaXJlc19hdCI6MTY1OTA1MTUzNH0.dDjYX4M1Cd7LyZz9HmD3sK7G7JmOc5XQZ9IO7uXdt-Q/img.jpg?width=980")
  ];
  Stream<QuerySnapshot> getAllMenu() {
    return FirebaseFirestore.instance.collection("menus").snapshots();
  }

  Menu getMenu(String id) {
    Menu menu = menus[0];
    return menu;
  }

  searchByName(String searchText) {
    return FirebaseFirestore.instance
        .collection('menus')
        .orderBy('name')
        .startAt([searchText])
        .endAt([searchText + '\uf8ff'])
        .limit(100)
        .snapshots();
  }

  List<Menu> _userListFromQuerySnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Menu.fromQueryDocumentSnapshot(doc);
    }).toList();
  }

// Stream<List<Menu>>
  queryByName(search) {
    return FirebaseFirestore.instance
        .collection("menus")
        .orderBy("name")
        .startAt([search])
        .endAt([search + '\uf8ff'])
        .limit(10)
        .snapshots();
    // .map(_userListFromQuerySnapshot);
  }

  Stream<DocumentSnapshot> getMenus(String id) {
    return FirebaseFirestore.instance.collection('menus').doc(id).snapshots();
  }
}
