import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );
  runApp(FirstFirebaseP());
}

class FirstFirebaseP extends StatefulWidget {
  const FirstFirebaseP({super.key});

  @override
  State<FirstFirebaseP> createState() => _FirstFirebasePState();
}

class _FirstFirebasePState extends State<FirstFirebaseP> {
  var username, password, email;
  GlobalKey<FormState> formState = new GlobalKey<FormState>();

  signIn() async {
    var formdata = formState.currentState;

    if (formdata!.validate()) {
      debugPrint('Valid');
      formdata.save();
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          debugPrint('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          debugPrint('The account already exists for that email.');
        } else {
          debugPrint(e.toString());
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    } else {
      debugPrint('Not Valid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: [
            SizedBox(
              height: 100,
            ),
            Form(
              key: formState,
              child: Column(
                children: [
                  TextFormField(
                    onSaved: (newValue) {
                      username = newValue;
                    },
                    validator: (val) {
                      if (val!.length > 100) {
                        return 'big user name';
                      } else if (val.length < 3) {
                        return 'small user name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'UserName',
                    ),
                  ),
                  TextFormField(
                    onSaved: (newValue) {
                      email = newValue;
                    },
                    validator: (val) {
                      if (val!.length > 100) {
                        return 'big email';
                      } else if (val.length < 3) {
                        return 'small email';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'UserName',
                    ),
                  ),
                  TextFormField(
                    onSaved: (newValue) {
                      password = newValue;
                    },
                    validator: (val) {
                      if (val!.length > 100) {
                        return 'big password';
                      } else if (val.length < 3) {
                        return 'small password';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'UserName',
                    ),
                  ),
                  SizedBox(),
                  GestureDetector(
                    onTap: () async {
                      debugPrint("youssef");
                      await signIn();
                    },
                    child: Container(
                        color: Colors.red,
                        width: 100,
                        height: 100,
                        child: Text('Sign In')),
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
