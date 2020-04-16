import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erasmusopportunities/models/organisation.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // Collection references
  final CollectionReference organisationsCollection = Firestore.instance.collection('organisations');
  final CollectionReference opportunitiesCollection = Firestore.instance.collection('opportunities');

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

  Future updateOpportunity(
      String title,
      String venueLocation,
      String type,
//      DateTime startDate,
//      DateTime endDate,
//      int lowAge,
//      int highAge,
//      String topic,
//      DateTime applicationDeadline,
//      double participationCost,
//      double reimbursementLimit,
//      String applicationLink,
//      String difficulties,
//      String description
      )
  async {
    print('in updateOpportunity');
    Organisation organisation = await getUserData();
    return await opportunitiesCollection.document().setData({
      'title' : title,
      'venueLocation' : venueLocation,
      'type' : type,
    });
  }


}