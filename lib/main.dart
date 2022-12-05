// ignore_for_file: use_build_context_synchronously, unused_local_variable, avoid_print, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );
  runApp(const FirstFirebaseP());
}

class FirstFirebaseP extends StatefulWidget {
  const FirstFirebaseP({super.key});

  @override
  State<FirstFirebaseP> createState() => _FirstFirebasePState();
}

class _FirstFirebasePState extends State<FirstFirebaseP> {
  List users = [];

  CollectionReference useref = FirebaseFirestore.instance.collection('users');

  getData() async {
    var responseusers = await useref.get();

    responseusers.docs.forEach((element) {
      setState(() {
        users.add(element.data());
      });
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(),
        body: ListView.builder(
          itemBuilder: ((context, indexSnapshot) {
            return Text('${users[indexSnapshot]['name']}');
          }),
          itemCount: users.length,
        ),
      ),
    );
  }
}
