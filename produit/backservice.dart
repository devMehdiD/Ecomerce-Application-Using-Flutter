import 'package:cloud_firestore/cloud_firestore.dart';

class BackendService {
  Future<List<DocumentSnapshot>> gesproduit(String pattren) async =>
      FirebaseFirestore.instance
          .collection("listprduit")
          .where('name', isGreaterThanOrEqualTo: pattren)
          .get()
          .then((value) {
        return value.docs;
      });
  Future<List<DocumentSnapshot>> getphonesfromfirebase(String pattren) async =>
      FirebaseFirestore.instance
          .collection("phone")
          .where('name', isGreaterThanOrEqualTo: pattren)
          .get()
          .then((value) {
        return value.docs;
      });
  Future<List<DocumentSnapshot>> getwatchfromfirebase(String pattren) async =>
      FirebaseFirestore.instance
          .collection("watches")
          .where('name', isGreaterThanOrEqualTo: pattren)
          .get()
          .then((value) {
        return value.docs;
      });
  Future<List<DocumentSnapshot>> getrobefromfirebase(String pattren) async =>
      FirebaseFirestore.instance
          .collection("robe")
          .where('name', isGreaterThanOrEqualTo: pattren)
          .get()
          .then((value) {
        return value.docs;
      });
  Future<List<DocumentSnapshot>> getsacfromfirebase(String pattren) async =>
      FirebaseFirestore.instance
          .collection("sac")
          .where('name', isGreaterThanOrEqualTo: pattren)
          .get()
          .then((value) {
        return value.docs;
      });
  Future<List<DocumentSnapshot>> getchemisefromfirebase(String pattren) async =>
      FirebaseFirestore.instance
          .collection("chemise")
          .where('name', isGreaterThanOrEqualTo: pattren)
          .get()
          .then((value) {
        return value.docs;
      });
  Future<List<DocumentSnapshot>> gettrousersfromfirebase(
          String pattren) async =>
      FirebaseFirestore.instance
          .collection("pontalon")
          .where('name', isGreaterThanOrEqualTo: pattren)
          .get()
          .then((value) {
        return value.docs;
      });
  Future<List<DocumentSnapshot>> getlaptopfromfirebase(String pattren) async =>
      FirebaseFirestore.instance
          .collection("laptop")
          .where('name', isGreaterThanOrEqualTo: pattren)
          .get()
          .then((value) {
        return value.docs;
      });
  Future<List<DocumentSnapshot>> getjeketfromfirebase(String pattren) async =>
      FirebaseFirestore.instance
          .collection("jaket")
          .where('name', isGreaterThanOrEqualTo: pattren)
          .get()
          .then((value) {
        return value.docs;
      });
  Future<List<DocumentSnapshot>> getcostumefromfirebase(String pattren) async =>
      FirebaseFirestore.instance
          .collection("costume")
          .where('name', isGreaterThanOrEqualTo: pattren)
          .get()
          .then((value) {
        return value.docs;
      });
}
