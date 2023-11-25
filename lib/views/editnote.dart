import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class EditNotePg extends StatefulWidget {
  const EditNotePg({super.key});

  @override
  State<EditNotePg> createState() => _EditNotePgState();
}

class _EditNotePgState extends State<EditNotePg> {
  TextEditingController _editTitlenote = TextEditingController();
  TextEditingController _editBodynote = TextEditingController();

  User? userId = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: "Edit Note".text.xl2.bold.white.make(),
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.all(30),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/imgs/notepa.jpg"),
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                controller: _editTitlenote
                  ..text = "${Get.arguments['NoteTitle'].toString()}",
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                  borderSide: BorderSide(style: BorderStyle.solid),
                )),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                style: TextStyle(fontSize: 18),
                controller: _editBodynote
                  ..text = "${Get.arguments['NoteBody'].toString()}",
                maxLines: null,
                decoration: InputDecoration(),
              ),
              SizedBox(
                height: 20,
              ),
              CupertinoButton.filled(
                  child: Text("Update"),
                  onPressed: () async {
                    var _updateBodynote = _editBodynote;
                    var _updateTitlenote = _editTitlenote;
                    if (_updateBodynote != null) {
                      try {
                        await FirebaseFirestore.instance
                            .collection("Notes")
                            .doc(Get.arguments['docId'].toString())
                            .update({
                          'NoteTitle': _editTitlenote.text.trim(),
                          'NoteBody': _editBodynote.text.trim(),
                        }).then((value) => {
                                  Get.back(),
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Note Updated")))
                                });
                      } catch (e) {
                        print("Error $e");
                      }
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
