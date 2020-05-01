import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceCrudFireStore {
  final _db = Firestore.instance;

//How start Class
//  Service service = new Service();

// Class responsible for returning all data for all users
// Example of use:
//  service.getUsers.then((onValue) {
//    onValue.documents.forEach((f) => print(f.data));
//  });
  Future<QuerySnapshot> get getUsers async =>
      await Firestore.instance.collection("user").getDocuments();

// Class responsible for adding a user
// Example of use:
//  service.addUser({'email':'email@email.com'});
  Future<void> addUser(data) async {
    _db.collection("user").add(data).then(
      (result) {
        print("Usuario Id: " + result.documentID);
      },
    );
  }

// Class responsible for taking a user id and returning their cards
// Example of use:
//  service.getCardsUser('jseGCXq0n5tJ728Tsypa').then((onValue) {
//    onValue.documents.forEach((f) => print(f.data));
//  });
  Future<QuerySnapshot> getCardsUser(String idUser) async {
    return await Firestore.instance
        .collection('user')
        .document(idUser)
        .collection('card')
        .getDocuments();
  }

  void updateCardInfo(String idUser, String idCard, Map<String, dynamic> map) {
    _db
        .collection('user')
        .document(idUser)
        .collection('card')
        .document(idCard)
        .updateData(map);
  }

  Future<void> addCard(String idUser, Map<String, dynamic> data) async {
    _db.collection("user").document(idUser).collection("card").add(data).then(
      (result) {
        print("cartao adicionado");
      },
    );
  }

  void updateCardInfo(String idUser, String idCard, Map<String, dynamic> map) {
    _db
        .collection('user')
        .document(idUser)
        .collection('card')
        .document(idCard)
        .updateData(map);
  }
}
