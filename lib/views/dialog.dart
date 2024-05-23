import 'package:chat_app/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class dialog extends StatefulWidget {





  @override
  _dialogState createState() => _dialogState();
}

class _dialogState extends State<dialog> {


  var name = '';
  var age = '';
  var email = '';
  var level = '';


  @override
  Widget build(BuildContext context) {
    CollectionReference studenttt = FirebaseFirestore.instance.collection(
        'student');

     // DocumentReference doc_ref = FirebaseFirestore.instance.collection('student')
          //.doc();
      DocumentReference student2=FirebaseFirestore.instance.collection('student').doc('MtfIuAijRMyBmF14ZwJw');









    return
      SingleChildScrollView(
        child: AlertDialog(
          title: Center(
            child: Text('Update Student', style: TextStyle(
                letterSpacing: 3,
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),),
          ),
          content:
          Container(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                TextField(
                    onChanged: (value) {
                      name = value;
                    },
                    decoration: TextInputDecoration.copyWith(
                        hintText: 'Enter name')
                ),
                TextField(
                    onChanged: (value) {
                      age = value;
                    },
                    decoration: TextInputDecoration.copyWith(
                        hintText: 'Enter age')
                ),
                TextField(
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: TextInputDecoration.copyWith(
                        hintText: 'Enter email')
                ),
                TextField(
                    onChanged: (value) {
                      level = value;
                    },
                    decoration: TextInputDecoration.copyWith(
                        hintText: 'Enter level')
                ),
                ElevatedButton(
                    onPressed: ()  {

                      student2.update({'name': name,
                                   'email': email, 'age': age,
                                    'level': level});




                        //'name': name,
                        //'email': email,
                        //'age': age,
                       // 'level': level
                      //}
                      //);

                      //student2.set(student);

                    },

                    child: Text('Submit'))


              ],
            ),
          ),


        ),
      );
  }

  Future<String> get_data(DocumentReference doc_ref) async {
    DocumentSnapshot docSnap = await doc_ref.get();
    var doc_id2 = docSnap.reference.id;
    return doc_id2;


//}
  }
}
