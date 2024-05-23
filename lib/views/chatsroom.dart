import 'package:chat_app/helper/authenticate.dart';
import 'package:chat_app/helper/constant.dart';
import 'package:chat_app/helper/helperfunctions.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/views/Student.dart';
import 'package:chat_app/views/search.dart';
import 'package:chat_app/views/signin.dart';
import 'package:chat_app/views/student_list.dart';
import 'package:chat_app/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'conversation.dart';
class chatroom extends StatefulWidget {
  const chatroom({Key? key}) : super(key: key);

  @override
  _chatroomState createState() => _chatroomState();
}

class _chatroomState extends State<chatroom> {
  authmethods auth=new authmethods();
  databasemethods db=new databasemethods();
  Stream<QuerySnapshot>? chatroomstreams;
  Widget chatroomlist() {
    return StreamBuilder(
      stream: chatroomstreams,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              'Nothing to show yet',
              style: TextStyle(fontSize: 16,color:Colors.white),

            ),
          );
        }
        return ListView.builder(
          itemCount: snapshot.requireData.size,
          itemBuilder: (context, index) {
            return listofchatrooms(
              snapshot.data!.docs[index]['chatroomid'].toString().replaceAll("_", "").replaceAll(constants.myname, ""),
              snapshot.data!.docs[index]['chatroomid'],
            );
          },
        );
      },
    );
  }

  @override
  void initState() {
    getuserinfo();
    chatroomstreams=db.getchatrooms(constants.myname);
    setState(() {

    });


    // TODO: implement initState
    super.initState();
  }
  getuserinfo() async{
    constants.myname=(await helperfunction.getusernamekey())!;
    setState(() {
      chatroomstreams=db.getchatrooms(constants.myname);


    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Student Management'),
            ),
            ListTile(
              title: const Text('Add Student'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>student()));
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Student List'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>studentlist()));
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),

      ),
      appBar: AppBar(
        title: Image.asset("assets/images/logo.png",height: 50,),
        actions: [
          GestureDetector(
            onTap: (){
              auth.signout();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>authenticate()));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),

                child: Icon(Icons.exit_to_app)),
          )
        ],

      ),
      body: chatroomlist(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: (){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>Searchscreen()));

        },
      ),
    );
  }
}
class listofchatrooms extends StatelessWidget {
  final String username;
  final String chatroomid;
  listofchatrooms(this.username,this.chatroomid);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>conversation(chatroomid)));
      },
      child: Container(
        color: Colors.black26,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        margin: EdgeInsets.only(bottom:10,top:10),
        child: Row(
          children: [
            Container(
              height: 50, // Slightly increased for better appearance
              width: 50,  // Slightly increased for better appearance
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(25), // Adjusted for better roundness
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Text(
                "${username.substring(0, 1).toUpperCase()}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24, // Increased font size for better visibility
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 12), // Slightly increased for better spacing
            Text(
              username,
              style: mediumtextstyle().copyWith(
                fontSize: 18, // Adjusted font size
                fontWeight: FontWeight.w600,
                color: Colors.white, // Ensure the text color is visible on dark background
                shadows: [
                  Shadow(
                    blurRadius: 2.0,
                    color: Colors.black54,
                    offset: Offset(1.0, 1.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),


    );
  }
}

