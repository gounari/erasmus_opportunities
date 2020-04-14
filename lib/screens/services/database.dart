import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erasmusopportunities/models/organisation.dart';

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

  Future getUserData() async {
    Organisation user;
    await organisationsCollection.document(uid).get()
        .then((doc) => {
          if (!doc.exists) {
            print('No such document!')
          } else {
            print('Document data: ${doc.data}'),

            user = Organisation(
              uid: doc.documentID,
              name: doc.data['name'],
              email: doc.data['email'],
              location: doc.data['location'],
            ),
          }
    }).catchError((error) => {
      print('Error getting document $error')
    });
    return user;
  }


}