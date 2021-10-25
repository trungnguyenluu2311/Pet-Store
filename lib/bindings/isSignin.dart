import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/screens/login_screen.dart';
import 'package:flutter_project/screens/main_screen.dart';

class IsSignIn extends StatelessWidget {
  final Future<FirebaseApp> _initalization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initalization,
      builder: (context, snapshot) {
        //if has error
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error: ${snapshot.error}"),
            ),
          );
        }
        //conect firebase done
        if (snapshot.connectionState == ConnectionState.done) {
          //Streambuilder check login state
          return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, streamSnapshot) {
                //if has error
                if(snapshot.hasError)
                {
                  return Scaffold(
                    body: Center(
                      child: Text("Error ${streamSnapshot.error}"),
                    ),
                  );
                }
                if(streamSnapshot.connectionState==ConnectionState.active)
                {
                  Object? _user = streamSnapshot.data;
                  if(_user == null)
                  {
                    return LoginScreen();
                  }
                  else
                  {
                    return MainScreen();
                  }
                }

                return Scaffold(
                  body: Center(
                    child: Text(
                      " Checking authention .... ",
                      // style: Constants.regularHeading,
                    ),
                  ),
                );
              });
        }

        return Scaffold(
          body: Center(
            child: Text(" "
                "Some thing here "),
          ),
        );
      },
    );
  }
}
