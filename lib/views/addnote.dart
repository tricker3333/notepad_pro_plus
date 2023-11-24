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
  TextEditingController _addnote = TextEditingController();

  User? userId = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              controller: _addnote,
              maxLines: null,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(style: BorderStyle.solid))),
            ),
            CupertinoButton.filled(
                child: Text("Add"),
                onPressed: () async {
                  var _noteadd = _addnote.text.trim();
                  if (_noteadd != "") {
                    try {
                      await FirebaseFirestore.instance
                          .collection("Notes")
                          .doc()
                          .set({
                        "createdAt": DateTime.now(),
                        "Note": _noteadd,
                        "UserID": userId?.email,
                      });
                      Get.back();
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text("Note Added")));
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
    );
  }
}
