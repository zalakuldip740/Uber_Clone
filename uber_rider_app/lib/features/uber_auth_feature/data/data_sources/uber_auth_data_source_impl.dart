import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uber_rider_app/features/uber_auth_feature/data/data_sources/uber_auth_data_source.dart';
import 'package:uber_rider_app/features/uber_auth_feature/presentation/pages/uber_auth_otp_verification_page.dart';

class UberAuthDataSourceImpl extends UberAuthDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final FirebaseStorage firebaseStorage;
  var verId = "".obs;

  UberAuthDataSourceImpl(
      {required this.firestore,
      required this.auth,
      required this.firebaseStorage});

  @override
  Future<bool> uberAuthIsSignIn() async {
    if (auth.currentUser == null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Future<void> uberAuthPhoneVerification(String phoneNumber) async {
    return await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {},
      verificationFailed: (FirebaseAuthException e) {
        Get.snackbar('error', e.code.toString(),
            snackPosition: SnackPosition.BOTTOM);
      },
      codeSent: (String verificationId, int? forceResendingToken) async {
        verId.value = verificationId;
        Get.closeAllSnackbars();
        Get.snackbar('done', "otp sent to $phoneNumber");
        Get.to(() => const OtpVerificationPage());
      },
      codeAutoRetrievalTimeout: (String verificationId) async {},
    );
  }

  @override
  Future<void> uberAuthOtpVerification(String otp) async {
    try {
      final AuthCredential authCredential = PhoneAuthProvider.credential(
          verificationId: verId.value, smsCode: otp);
      await auth.signInWithCredential(authCredential);
      // Get.to(() => const UberHomePage());
    } on FirebaseAuthException catch (e) {
      Get.snackbar('error', e.code.toString());
    }
  }

  @override
  Future<String> uberAuthGetUserUid() async {
    return auth.currentUser!.uid;
  }

  @override
  Future<bool> uberAuthCheckUserStatus(String docId) async {
    final riderCollection = firestore.collection("riders");
    var doc = await riderCollection.doc(docId).get();
    return doc.exists;
  }

  @override
  Future<void> uberAuthSignOut() async {
    return await auth.signOut();
  }

  @override
  Future<String> uberAddProfileImg(String riderId) async {
    final profileImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    File _profileImage = File(profileImage!.path);
    await firebaseStorage
        .ref('UserProfileImages/$riderId')
        .putFile(_profileImage);
    return await firebaseStorage
        .ref('UserProfileImages/$riderId')
        .getDownloadURL();
  }
}
