import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class databasemethods{
getUser(String username) async{
   return await FirebaseFirestore.instance.collection("users").where("name", isEqualTo: username ).get();

}
getUseremail(String userEmail) async{
  print("inside getUseremail and the value of userEmail is ${userEmail}");
  return await FirebaseFirestore.instance.collection("users").where("email", isEqualTo: userEmail.trim() ).get();

}
uploaduserinfo(userMap){
  FirebaseFirestore.instance.collection("users").add(userMap);

}
createchatroom(String ChatRoomId,chatroommap){
  FirebaseFirestore.instance.collection("ChatRoom").doc(ChatRoomId).set(chatroommap).catchError((e){
    print(e.toString());

  });
}
getconversaionmessages(String chatroomid,messageMap){
  FirebaseFirestore.instance.collection("ChatRoom").doc((chatroomid)).collection("chats").add(messageMap).catchError((e){
    print(e.toString());
  });
}
actuallygetconversationmessage(String chatroomid){
  return FirebaseFirestore.instance.collection("ChatRoom").doc(chatroomid).collection("chats").orderBy("time",descending: false)
  .snapshots();
}
getchatrooms(String username){
  return FirebaseFirestore.instance.collection("ChatRoom").where("users",arrayContains: username).snapshots();
}


}