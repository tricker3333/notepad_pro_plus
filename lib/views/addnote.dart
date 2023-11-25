import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNotePg extends StatefulWidget {
  const AddNotePg({super.key});

  @override
  State<AddNotePg> createState() => _AddNotePgState();
}

class _AddNotePgState extends State<AddNotePg> {
  final TextEditingController _addBodynote = TextEditingController();
  final TextEditingController _addTitlenote = TextEditingController();

  User? userId = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.all(30),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/imgs/notepa.jpg"),
                  fit: BoxFit.cover),
              shape: BoxShape.rectangle),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                controller: _addTitlenote,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                    hintText: "Title",
                    hintStyle:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.black,
                      style: BorderStyle.solid,
                    ))),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _addBodynote,
                maxLines: null,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  hintStyle: TextStyle(fontSize: 18),
                  hintText: "Body",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CupertinoButton.filled(
                  child: Text("Add"),
                  onPressed: () async {
                    var _noteTitleadd = _addTitlenote.text.trim();
                    var _noteBodyadd = _addBodynote.text.trim();
                    if (_noteBodyadd != "") {
                      try {
                        await FirebaseFirestore.instance
                            .collection("Notes")
                            .doc()
                            .set({
                          "createdAt": DateTime.now(),
                          "NoteTitle": _noteTitleadd,
                          "NoteBody": _noteBodyadd,
                          "UserID": userId?.email,
                        });
                        Get.back();
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Note Added")));
                      } catch (e) {
                        print("Error $e");
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("The Note is Empty")));
                      print("Empty Note");
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
