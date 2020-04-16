import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erasmusopportunities/helpers/firebase_constants.dart';
import 'package:erasmusopportunities/models/organisation.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });
  static final opportunity = FirebaseOpportunityConstants();

  // Collection references
  final CollectionReference organisationsCollection = Firestore.instance.collection('organisations');
  final CollectionReference opportunitiesCollection = Firestore.instance.collection(opportunity.collection);

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
      DateTime startDate,
      DateTime endDate,
      String lowAge,
      String highAge,
      String topic,
      DateTime applicationDeadline,
      String participationCost,
      String reimbursementLimit,
      String applicationLink,
      List provideForDisabilities,
      String description
      )
  async {
    Organisation organisation = await getUserData();
    return await opportunitiesCollection.document().setData({
      opportunity.title : title,
      opportunity.organisationName : organisation.name,
      opportunity.organisationUID : organisation.uid,
      opportunity.venueLocation : venueLocation,
      opportunity.type : type,
      opportunity.startDate : startDate,
      opportunity.endDate : endDate,
      opportunity.lowAge : int.parse(lowAge),
      opportunity.highAge : int.parse(highAge),
      opportunity.topic : topic,
      opportunity.applicationDeadline : applicationDeadline,
      opportunity.participationCost : double.parse(participationCost),
      opportunity.reimbursementLimit : double.parse(reimbursementLimit),
      opportunity.applicationLink : applicationLink,
      opportunity.provideForDisabilities : provideForDisabilities,
      opportunity.description : description,
    });
  }

}