import 'package:chat_app/helper/constant.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class conversation extends StatefulWidget {
  final String chatroomid;
  conversation(this.chatroomid);


  @override
  _conversationState createState() => _conversationState();
}

class _conversationState extends State<conversation> {
  databasemethods db=new databasemethods();
  TextEditingController messageController=new TextEditingController();
   Stream<QuerySnapshot>? chatmessagestream;

  Widget messagelist(){
    return StreamBuilder<QuerySnapshot>(
        stream:chatmessagestream,
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot) {
          return ListView.builder(
              itemCount: snapshot.requireData.size,
              itemBuilder: (context, index) {
                return Message(snapshot.data!.docs[index]['message'],snapshot.data!.docs[index]['sentBy']==constants.myname);
              });
        },
    );

  }
  sendmessage(){
    if(messageController.text.isNotEmpty){
      Map<String,dynamic>messageMap={
        "message":messageController.text,
        "sentBy":constants.myname,
        "time":DateTime.now().millisecondsSinceEpoch

    };
      db.getconversaionmessages(widget.chatroomid, messageMap);
      messageController.text="";


  }

  }
  @override
  void initState() {
    chatmessagestream=db.actuallygetconversationmessage(widget.chatroomid);
      setState(() {

      });


    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Image.asset("assets/images/logo.png",height: 50,),
      ),
      body: Container(
        child: Stack(

          children: [
            messagelist(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Color(0x54FFFFFF),
                padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),

                child: Row(
                  children: [
                    Expanded(child: TextField(
                      controller: messageController,
                      style: TextStyle(

                          color: Colors.white
                      ),
                      decoration: InputDecoration(
                          hintText: "Type Message ..",
                          hintStyle: TextStyle(
                              color: Colors.white54
                          ),
                          border: InputBorder.none
                      ),
                    )
                    ),
                    GestureDetector(
                      onTap: (){
                        sendmessage();
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
                          child: Image.asset("assets/images/send.png")),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class Message extends StatelessWidget {
  final String message;
  final bool issentbyme;
  Message(this.message,this.issentbyme);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: issentbyme? 0:24,right: issentbyme?24:0),
      width:MediaQuery.of(context).size.width,
      alignment: issentbyme ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(

            colors: issentbyme ? [
              const Color(0xff007EF4),
              const Color(0xff2A75BC)
            ] : [const Color(0x1AFFFFFF),
            const Color(0x1AFFFFFF)]
          ),
          borderRadius: issentbyme? BorderRadius.only(topLeft: Radius.circular(23),topRight: Radius.circular(23),bottomLeft: Radius.circular(23)):
              BorderRadius.only(topLeft: Radius.circular(23),topRight: Radius.circular(23),bottomRight: Radius.circular(23))
        ),
        child: Text(message,style: TextStyle(
          color: Colors.white,
          fontSize: 17,),
      )),
    );
  }
}

