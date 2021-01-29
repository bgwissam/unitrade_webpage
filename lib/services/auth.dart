import 'package:firebase_auth/firebase_auth.dart';
import 'package:unitrade_website/models/users.dart' as localUser;
import 'package:unitrade_website/services/database.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  DatabaseService db = new DatabaseService();

 
  localUser.Users _userFromFirebase(User user) {
    return user != null ? localUser.Users(uid: user.uid) : null;
  }

   //get current user
  Stream<localUser.Users> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }


  //Register new User
  Future registerWithEmailandPassword(
      {String emailAddress,
      String password,
      String fullName,
      List<String> roles}) async {
    try {
      var result = await _auth.createUserWithEmailAndPassword(
          email: emailAddress, password: password);

      User user = result.user;

      if (user != null) {
        await db
            .setUserData(
                uid: user.uid, fullName: fullName, emailAddress: emailAddress, roles: roles)
            .then((value) {
          print(value);
        });
      }
    } catch (e) {
      print('Could not register error: ' + e.toString());
      return e.toString();
    }
  }

  //Sign in current User
  Future signInWithUserNameandPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      var user = result.user;
      
      return user;
     
    } catch (e) {
      print('The error is: $e');
      return e.toString();
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print('${this.runtimeType} couldn\'t sign out: ${e.toString()}');
      return null;
    }
  }

} //end of class
