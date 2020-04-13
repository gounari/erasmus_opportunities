import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // Collection reference
  final CollectionReference organisationsCollection = Firestore.instance.collection('organisations');

  Future updateUserData(String name, String email, String location) async {
    return await organisationsCollection.document(uid).setData({
      'name' : name,
      'email' : email,
      'location' : location,
    });
  }


}