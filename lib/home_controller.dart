import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser() => users.doc('1').set({
    'full_name': "Mary Jane",
    'age': 18
  },);
}
