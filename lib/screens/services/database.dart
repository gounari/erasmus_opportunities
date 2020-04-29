import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erasmusopportunities/helpers/firebase_constants.dart';
import 'package:erasmusopportunities/models/organisation.dart';
import 'package:firebase/firebase.dart' as fb;

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });
  static final opportunity = FirebaseOpportunityConstants();

  // Collection references
  final CollectionReference organisationsCollection = Firestore.instance.collection('organisations');
  final CollectionReference opportunitiesCollection = Firestore.instance.collection(opportunity.collection);

  fb.UploadTask _uploadTask;

  uploadFile(String path, Uint8List data) async {
    try {
      _uploadTask = fb
          .storage()
          .refFromURL('gs://erasmus-opportunities.appspot.com')
          .child("opportunities_media/$path")
          .put(data);

    } catch (error) {
      print("Error uploading image: " + error);
    }
  }


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

  updateOpportunity(
      String title,
      String venueAddress,
      String venueCountry,
      List<String> participatingCountries,
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
      String description,
      Timestamp timestamp,
      Uint8List coverImage,
      Uint8List postImage,
      )
  async {
    Organisation organisation = await getUserData();
    final docRef = opportunitiesCollection.document();
    await docRef.setData({
      opportunity.title : title,
      opportunity.organisationName : organisation.name,
      opportunity.organisationUID : organisation.uid,
      opportunity.venueAddress : venueAddress,
      opportunity.venueCountry : venueCountry,
      opportunity.participatingCountries : participatingCountries,
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
      opportunity.timestamp : timestamp,
    });
    uploadFile(docRef.documentID + "_cover.jpg", coverImage);
    uploadFile(docRef.documentID + "_post.jpg", postImage);
  }

}