import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/views/auth_screen/login_screen.dart';
import 'package:emart_app/consts/views/home_screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  var isloading = false.obs;

  //text controllers
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

//Login Method
  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

//SignUp Method
  Future<UserCredential?> signupMethod({email, password, context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

//storing data method
  storeUserData({name, password, email}) async {
    DocumentReference store =
        firestore.collection(usersCollection).doc(currentUser!.uid);
    store.set({
      'name': name,
      'password': password,
      'email': email,
      'imageUrl': '',
      'id': currentUser!.uid,
      'cart_count' : "00",
      'wishlist_count' : "00",
      'order_count' : "00",
    });
  }

//sign out method
  signOutMethod(context) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

}

// ------------------------------------------
//Google Sign In Method
class AuthService{
  //Determine if the user is authenticated
  handleAuthState(){
    return StreamBuilder(
      stream: auth.authStateChanges(),
      builder: (BuildContext context, snapshot){
        if(snapshot.hasData){
          return const HomeScreen();
        }else{
          return const LoginScreen();
        }

      },
    );
  }
  //Google Sign In
  Future<bool> googleLoginMethod() async {
    bool result = false;
    try{
      //Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      //Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      //Create a new credential
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken
      );
      //Once signed in, return the UserCredential
       UserCredential userCredential = await auth.signInWithCredential(credential);
       User? currentUser = userCredential.user;

      if(currentUser != null){
        // add the data to firestore
          await firestore.collection(usersCollection).doc(currentUser!.uid).set(
            {
              'name': currentUser.displayName,
              'id': currentUser.uid,
              'imageUrl': currentUser.photoURL,
              'email': currentUser.email,
              'order_count': '',
              'password': '',
              'wishlist': '',
              'cart_count': ''
            },SetOptions(merge: true),
          );


       // if(user != null){
       //   if(userCredential.additionalUserInfo!.isNewUser){
       //     // add the data to firestore
       //     await firestore.collection('users').doc(user!.uid).set(
       //       {
       //         'name': user.displayName,
       //         'id': user.uid,
       //         'imageUrl': user.photoURL,
       //       },SetOptions(merge: true),
       //     );
       //   }
         return result;
       }

    } catch (e) {
      print(e);
    }

    return result;

  }


  //signout from google account
  googleSignOut(){
    auth.signOut();
  }

}