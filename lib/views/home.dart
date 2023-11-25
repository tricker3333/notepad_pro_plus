import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notepad_pro_plus/views/addnote.dart';
import 'package:notepad_pro_plus/views/editnote.dart';
import 'package:notepad_pro_plus/views/login.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePg extends StatefulWidget {
  const HomePg({super.key});

  @override
  State<HomePg> createState() => _HomePgState();
}

class _HomePgState extends State<HomePg> {
  User? userId = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: 'Home'.text.white.bold.xl2.make(),
        actions: [
          InkWell(
            child: const Icon(Icons.logout_rounded),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Get.off(() => const LoginPg());
            },
          )
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/imgs/not.jpg"), fit: BoxFit.cover)),
        padding: EdgeInsets.all(15),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Notes")
              .where("UserID", isEqualTo: userId?.email)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              print("Something Went Wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CupertinoActivityIndicator());
            }
            if (snapshot.data!.docs.isEmpty) {
              return Text("not Found");
              //Container(
              //     child: Column(
              //   children: [
              //     Icon(Icons.work_off_rounded),
              //     Align(child: "Data not Found ".text.xl4.violet500.make()),
              //   ],
              // ));
            }
            // ignore: unnecessary_null_comparison
            if (snapshot != null && snapshot.data != null) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var _createdId = snapshot.data!.docs[index]["createdAt"];
                  var _notesTitle = snapshot.data!.docs[index]["NoteTitle"];
                  var _notesBody = snapshot.data!.docs[index]["NoteBody"];
                  var _usermail = snapshot.data!.docs[index]["UserID"];
                  var _noteId = snapshot.data!.docs[index].id;
                  return Card(
                    child: ListTile(
                      subtitle: Text(
                        _notesBody,
                        style: TextStyle(fontSize: 18),
                      ),
                      title: Text(
                        _notesTitle,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w400),
                      ),
                      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                        InkWell(
                            onTap: () {
                              print(_noteId);
                              print(_createdId);
                              Get.to(() => EditNotePg(), arguments: {
                                'NoteTitle': _notesTitle,
                                'NoteBody': _notesBody,
                                'docId': _noteId,
                              });
                            },
                            child: Icon(Icons.edit)),
                        SizedBox(
                          width: 15,
                        ),
                        InkWell(
                            onTap: () {
                              ScaffoldMessenger.of(context).showMaterialBanner(
                                  MaterialBanner(
                                      content: Text(
                                          "Are you Sure to Delete this Item"),
                                      actions: <Widget>[
                                    TextButton(
                                        onPressed: () {}, child: Text("Yes")),
                                    TextButton(
                                        onPressed: () =>
                                            ScaffoldMessenger.of(context)
                                                .hideCurrentMaterialBanner(),
                                        child: Text("No"))
                                  ]));
                            },
                            child: Icon(Icons.delete))
                      ]),
                    ),
                  );
                },
              );
            }
            return Container(child: CupertinoActivityIndicator());
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Get.to(() => AddNotePg());
          }),
    );
  }
}
