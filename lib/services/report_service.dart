import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_solution_challenge/models/report.dart';
import 'package:google_solution_challenge/services/storage_service.dart';

class ReportService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StorageService _storageService = StorageService();
  String mediaUrl = '';

  Future<Report> addStatus(
      String status,
      GeoPoint location,
      String address,
      String user,
      DateTime createdAt,
      ) async {

    var ref = _firestore.collection("Status");


    var documentRef = await ref.add({
      'status': status,
      'location': location,
      "address": address,
      'user': user,
      'createdAt': createdAt,
    });

    return Report(
      id: documentRef.id,
      status: status,
      location: location,
      address: address,
      user: user,
      createdAt: createdAt,
    );
  }

  //status göstermek için
  Stream<QuerySnapshot> getStatus() {
    var ref = _firestore
        .collection("Status")
        .orderBy('createdAt', descending: true)
        .snapshots();

    return ref;
  }

  //status silmek için
  Future<void> removeStatus(String docId) {
    var ref = _firestore.collection("Status").doc(docId).delete();

    return ref;
  }
}
