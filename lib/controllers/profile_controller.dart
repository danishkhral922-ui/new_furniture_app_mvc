import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String userName = 'Loading...';
  String userEmail = 'Loading...';

  ProfileProvider() {
    fetchUserData();
  }

  void fetchUserData() {
    String? uid = _auth.currentUser?.uid;
    if (uid != null) {
      userEmail = _auth.currentUser?.email ?? 'No Email';

      _firestore.collection('users').doc(uid).snapshots().listen((snapshot) {
        if (snapshot.exists && snapshot.data() != null) {
          userName = snapshot.data()?['name'] ?? 'No Name';
        } else {
          userName = _auth.currentUser?.displayName ?? 'User';
        }
        notifyListeners();
      }, onError: (error) {});
    }
  }

  Future<void> updateProfile(BuildContext context, String newName) async {
    try {
      String? uid = _auth.currentUser?.uid;
      if (uid != null) {
        await _firestore.collection('users').doc(uid).set({
          'name': newName,
          'email': userEmail,
          'updatedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));

        await _auth.currentUser?.updateDisplayName(newName);

        userName = newName;
        notifyListeners();

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Success: Profile updated successfully!'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: Failed to save data: $e'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }
}
