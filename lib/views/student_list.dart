
import 'package:chat_app/widgets/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Student.dart';
import 'dialog.dart';
class studentlist extends StatefulWidget {



  @override
  _studentlistState createState() => _studentlistState();

}

class _studentlistState extends State<studentlist> {



  @override
  Widget build(BuildContext context) {

    final Stream<QuerySnapshot> STUDENT=FirebaseFirestore.instance.collection('student').snapshots();
    return Container(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context,
                MaterialPageRoute(builder:(context)=> student()));

          },
          child: Icon(Icons.add),),
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Center(child: Text(' Student List'),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(

            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/images/student.jpg'),fit: BoxFit.cover,
              ),),
            child: Column(
                children:<Widget>[
                  Container(
                    height: 500,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: StreamBuilder<QuerySnapshot>(
                        stream: STUDENT,
                        builder:(
                            BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot,
                            ){
                          if (snapshot.hasError){
                            return Text('something went wrong');
                          }
                          if (snapshot.connectionState==ConnectionState.waiting){
                            return Loading();
                          }
                          final data=snapshot.requireData;
                          return ListView.builder(
                            itemCount: data.size,
                            itemBuilder: (Context,index){
                              return GestureDetector(
                                onTap: (){

                                },
                                child: Container(
                                    child:Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.person,
                                              color: Colors.blueAccent,),
                                            Text(data.docs[index]['name'],
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 3
                                              ),),


                                            new Spacer(),
                                            TextButton.icon(onPressed: ()  {
                                              displaydialog(context);



                                            }, icon: Icon(Icons.edit,color: Colors.blue,), label: Text('')),

                                          ],
                                        ),
                                        Row(

                                          children: [
                                            Icon(Icons.email,
                                              color: Colors.red,),
                                            Text(data.docs[index]['email'],
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 3
                                              ),),
                                            new Spacer(),
                                            TextButton.icon(onPressed: () async {
                                              await FirebaseFirestore.instance.runTransaction((Transaction mytransaction ) async {
                                                await mytransaction.delete(data.docs[index].reference);
                                              });

                                            }, icon: Icon(Icons.delete,color: Colors.red,), label: Text('')),
                                          ],
                                        ),
                                        Row(children:[
                                          Image.network(data.docs[index]['url'],height: 40,width: 80,)
                                        ] ),
                                        Divider(
                                          height: 20,
                                          thickness: 5,
                                          indent: 20,
                                          endIndent: 20,
                                        )
                                      ],


                                    )
                                ),
                              );
                              //Text('My name is ${data.docs[index]['name']} and i am ${data.docs[index]['age']} my emai is ${data.docs[index]['email']} my level ${data.docs[index]['level']}');
                            },
                          );
                        }

                    ),



                  ),


                ]),
          ),
        ),
      ),
    );
  }

  void displaydialog(BuildContext context) async {
    return showDialog(context: context,
        builder: (context){
          return dialog();
        }
    );
  }
}