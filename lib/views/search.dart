import 'package:chat_app/helper/constant.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/helper/helperfunctions.dart';
import 'package:chat_app/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'conversation.dart';
class Searchscreen extends StatefulWidget {
  const Searchscreen({Key? key}) : super(key: key);

  @override
  _SearchscreenState createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  databasemethods db=new databasemethods();
   QuerySnapshot? searchsnapshot;
  Widget searchList(){
    return searchsnapshot!= null ? ListView.builder(
        itemCount: searchsnapshot!.size,
        shrinkWrap: true,
        itemBuilder: (context,index){
          return searchresult(username: searchsnapshot!.docs[index]['name'],
              useremail: searchsnapshot!.docs[index]['email']
          );
        }): Container();
  }
  initiatesearch(){
    db.getUser(searchtext.text).then((val) {
      setState(() {
        searchsnapshot=val;

      });

    }
      );
  }
  createchatroom({
    required String username}){
    String chatroomid=getchatroomid(username,constants.myname);
    List<String> users=[username,constants.myname];
    Map<String,dynamic> chatroommap={
      "users":users,
      "chatroomid":chatroomid
    };
    databasemethods().createchatroom(chatroomid, chatroommap);
    Navigator.push(context,MaterialPageRoute(builder: (context)=>conversation(chatroomid)));
  }
  Widget searchresult({required String username,
  required String useremail}){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
      child: Row(

        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(username, style: mediumtextstyle(),),
              Text(useremail, style: mediumtextstyle(),),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: (){
              createchatroom(username: username);

            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(30)
              ),
              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
              child: Text("Message",style: mediumtextstyle(),),
            ),
          )
        ],
      ),
    );
  }

   void initState(){
     getuserinfo();
    super.initState();
  }
  getuserinfo(){
    getuserinfo() async{
      constants.myname=(await helperfunction.getusernamekey())!;
      setState(() {

      });
    }
  }
  TextEditingController searchtext=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/images/logo.png",height: 50,),
        actions: [
          GestureDetector(
            onTap: (){

            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),

                child: Icon(Icons.exit_to_app)),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              color: Color(0x54FFFFFF),
              padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),

              child: Row(
                children: [
                  Expanded(child: TextField(
                    controller: searchtext,
                    style: TextStyle(

                      color: Colors.white
                    ),
                    decoration: InputDecoration(
                      hintText: "seach username",
                      hintStyle: TextStyle(
                        color: Colors.white54
                      ),
                      border: InputBorder.none
                    ),
                  )
                  ),
                  GestureDetector(
                    onTap: (){
                      initiatesearch();
                      },

                    child: Container(
                        height:40,
                        width: 40,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0x36FFFFFF),
                              const Color(0x0FFFFFFF)
                            ]
                          ),
                          borderRadius: BorderRadius.circular(40)
                        ),
                        child: Image.asset("assets/images/search_white.png")),
                  ),
                ],
              ),
            ),
            searchList(),
          ],
        ),
      ),
    );
  }
}

getchatroomid(String a,String b){
  if(a.substring(0,1).codeUnitAt(0)>b.substring(0,1).codeUnitAt(0)){
    return"$b\_$a";
  }
  else{
    return "$a\_$b";
  }
}

