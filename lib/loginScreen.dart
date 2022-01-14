// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_sign/controllerLogin.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

final GoogleSignIn gSignIn = GoogleSignIn();

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  loginUIController() {
    return Consumer<ControllerLogin>(
      builder: (context, model, child) {
        //if user already loggedin
        if (model.userDetailsModel != null) {
          return Center(
              // user details
              child: alreadyLoggedInScreen(model));
        }
        //if user not already loggedin
        else {
          // show NotLoggedInsign in screen
          return notLoggedInScreen();
        }
      },
    );
  }

  notLoggedInScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 20),
          child: Image.asset('asset/sign_in.jpg'),
        ),
        const SizedBox(
          height: 10.00,
        ),
        GestureDetector(
          onTap: () {
            Provider.of<ControllerLogin>(context, listen: false)
                .allowUserToLogin();
          },
          child: Card(
            elevation: 6,
            child: Container(
              height: 60.00,
              width: 280,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Image.asset('asset/google_logo.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2),
                    child: Text(
                      'Google',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 25,
                          color: Colors.red.shade700),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  alreadyLoggedInScreen(ControllerLogin model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage:
              Image.network(model.userDetailsModel!.photoURL ?? "No Image")
                  .image,
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.person,
              color: Colors.black,
            ),
            Text(model.userDetailsModel!.displayName ?? "",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.email,
              color: Colors.black,
            ),
            Text(model.userDetailsModel!.email ?? "",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        ActionChip(
            backgroundColor: Colors.black,
            avatar: const Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
            label: const Padding(
              padding: EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: Text('Logout',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            onPressed: () {
              Provider.of<ControllerLogin>(context, listen: false)
                  .allowUserToLogout();
            })
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: loginUIController(),
    );
  }
}
