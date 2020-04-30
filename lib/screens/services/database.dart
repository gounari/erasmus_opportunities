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

  Future<Uri> uploadFile(String path, Uint8List data) async {
    try {
      var ref = fb
          .storage()
          .refFromURL('gs://erasmus-opportunities.appspot.com')
          .child("opportunities_media/$path");
      await ref.put(data).future;

      return ref.getDownloadURL();

    } catch (error) {
      print('Error uploading media $error');
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
      List<String> topics,
      DateTime applicationDeadline,
      String participationCost,
      String reimbursementLimit,
      String applicationLink,
      List provideForDisabilities,
      String description,
      Uint8List coverImage,
      Uint8List postImage,
      Uint8List postVideo,
      )
  async {
    Organisation organisation = await getUserData();
    final docRef = opportunitiesCollection.document();
    String coverImageUri;
    await uploadFile(docRef.documentID + "_cover.jpg", coverImage)
        .then((value) => coverImageUri = value.toString())
        .catchError((error) => print('Error getting cover image uri $error'));

    String postImageUri;
    await uploadFile(docRef.documentID + "_post.jpg", postImage)
        .then((value) => postImageUri = value.toString())
        .catchError((error) => print('Error getting post image uri $error'));

    String postVideoUri;
    await uploadFile(docRef.documentID + "_video.mp4", postVideo)
        .then((value) => postVideoUri = value.toString())
        .catchError((error) => print('Error getting post video uri $error'));


    await docRef.setData({
      opportunity.title : title,
      opportunity.organisationName : organisation.name,
      opportunity.organisationUID : organisation.uid,
      opportunity.venueAddress : venueAddress.trim(),
      opportunity.venueCountry : venueCountry,
      opportunity.participatingCountries : participatingCountries,
      opportunity.type : type,
      opportunity.startDate : startDate,
      opportunity.endDate : endDate,
      opportunity.lowAge : int.parse(lowAge),
      opportunity.highAge : int.parse(highAge),
      opportunity.topics : topics,
      opportunity.applicationDeadline : applicationDeadline,
      opportunity.participationCost : double.parse(participationCost),
      opportunity.reimbursementLimit : double.parse(reimbursementLimit),
      opportunity.applicationLink : applicationLink,
      opportunity.provideForDisabilities : provideForDisabilities,
      opportunity.description : description,
      opportunity.timestamp : Timestamp.now(),
      opportunity.coverImage : coverImageUri,
      opportunity.postImage : postImageUri,
      opportunity.postVideo : postVideoUri,
    }).catchError((err) => print('Opportunity data upload: $err'));
  }

}