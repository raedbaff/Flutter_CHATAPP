import 'package:chat_app/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class authmethods{
final FirebaseAuth _auth=FirebaseAuth.instance;
Userclass? _userfromfirebaseuser(User user){
  return user !=null ? Userclass(userId: user.uid) : null;
}
Future signInwithEmailandPassword(String email,String password) async{
  try {

    UserCredential result=await _auth.signInWithEmailAndPassword(email: email.trim(), password: password);

    User? firebaseuser=result.user;
    return _userfromfirebaseuser(firebaseuser!);

  }
  catch(e){
    print(e);

  }
}
Future signupwithemailandpassword(String email,String password) async{
  try {
    UserCredential result=await _auth.createUserWithEmailAndPassword(email: email, password: password);
    User? firebaseuser=result.user;
    return _userfromfirebaseuser(firebaseuser!);
  }
  catch(e){
    print(e);

  }

}
Future resetpassword(String email) async {
  try {
    return await _auth.sendPasswordResetEmail(email: email);
  }
  catch (e) {
    print(e);
  }
}

Future signout () async {
    try {
      return await _auth.signOut();
    }
    catch(e){
      print(e);
    }
}
}