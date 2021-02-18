import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/models/user.dart';
import 'package:travel/providers/auth.dart';
import 'package:travel/screens/Home.dart';

class AuthBody extends StatefulWidget {
  @override
  _AuthBodyState createState() => _AuthBodyState();
}

class _AuthBodyState extends State<AuthBody> with TickerProviderStateMixin {
  final TextEditingController passCtr = TextEditingController();

  final TextEditingController emailCtr = TextEditingController();
  bool logging = false;

  var hidePass = true;

  void login() async {
    final auther = Provider.of<Auther>(context, listen: false);
    final snapshot = await auther.login(
      input['email'],
      input['password'],
    );
    if (snapshot.user == null) {
      Scaffold.of(context).hideCurrentSnackBar();
      Scaffold.of(context).showSnackBar(
          const SnackBar(content: const Text('Email doesn\'t exist')));
      setState(() {
        logging = false;
      });
    } else {
      Navigator.of(context).pushReplacementNamed(Home.route);
    }
  }

  Widget get label => Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).primaryColorDark),
        transform: Matrix4.rotationZ(-8 * pi / 180),
        // color: ,
        child: Text(
          'Travller',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 40),
        ),
      );
  final input = {
    'email': '',
    'password': '',
    'name': '',
    'phone': '',
  };
  void createAcount() async {
    final auther = Provider.of<Auther>(context, listen: false);
    print(input['email']);
    print(input['password']);

    final snapshot = await auther
        .createUserWithEmailAndPass(input['email'], input['password'])
        .catchError((value) {
      print('erorr create acount');
    });
    if (snapshot.user != null) {
      CustomUser user = CustomUser(
          id: snapshot.user.uid,
          email: snapshot.user.email,
          phone: input['phone'],
          name: input['name']);
      await auther.addUser(user).catchError((value) {
        print('erorr add acount data');
      });
      Navigator.of(context).pushReplacementNamed(Home.route);
    }
  }

  var isReg = false;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print('build authhomeBody.dart');

    final size = MediaQuery.of(context).size;
    return logging
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.pink[50],
                  Colors.pink[100],
                  Colors.pink[200],
                  Colors.pink[300]
                ],
              ),
            ),
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: label,
                    ),
                    AnimatedSize(
                      reverseDuration: Duration(milliseconds: 400),
                      duration: Duration(milliseconds: 400),
                      vsync: this,
                      child: Container(
                        width: size.width * 5 / 6,
                        // height: MediaQuery.of(context).size.height *
                        //     (isReg
                        //         ? 2 / 3
                        //         : MediaQuery.of(context).orientation ==
                        //                 Orientation.portrait
                        //             ? 1 / 3
                        //             : 3 / 5),
                        child: Card(
                          elevation: 5,
                          child: SingleChildScrollView(
                            child: Form(
                              key: formKey,
                              child: Wrap(
                                children: [
                                  if (isReg)
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: TextFormField(
                                        maxLines: 1,
                                        onSaved: (newValue) {
                                          input['name'] = newValue.trim();
                                        },
                                        validator: (value) => value.isEmpty
                                            ? 'Invalid name'
                                            : null,
                                        decoration: const InputDecoration(
                                          labelText: 'Name',
                                        ),
                                      ),
                                    ),
                                  if (isReg)
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        maxLines: 1,
                                        onSaved: (newValue) {
                                          input['phone'] = newValue.trim();
                                        },
                                        validator: (value) =>
                                            value.isEmpty || value.length < 6
                                                ? 'Invalid phone'
                                                : null,
                                        decoration: const InputDecoration(
                                          labelText: 'Phone',
                                        ),
                                      ),
                                    ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      maxLines: 1,
                                      onSaved: (newValue) {
                                        input['email'] =
                                            newValue.toLowerCase().trim();
                                      },
                                      validator: (value) =>
                                          value.isEmpty || !value.contains('@')
                                              ? 'Invalid Email'
                                              : null,
                                      decoration: const InputDecoration(
                                          labelText: 'Email',
                                          hintText: 'example@example.com'),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      maxLines: 1,
                                      obscureText: hidePass,
                                      controller: passCtr,
                                      onSaved: (newValue) =>
                                          input['password'] = newValue,
                                      validator: (value) => value.isEmpty
                                          ? 'Invalid Password'
                                          : null,
                                      decoration: InputDecoration(
                                          labelText: 'Password',
                                          suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  hidePass = !hidePass;
                                                });
                                              },
                                              icon: Icon(hidePass
                                                  ? Icons.visibility_off
                                                  : Icons.visibility))),
                                    ),
                                  ),
                                  if (isReg)
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        maxLines: 1,
                                        obscureText: true,
                                        validator: (value) {
                                          if (value.isEmpty ||
                                              value.compareTo(passCtr.text) !=
                                                  0)
                                            return 'password not match';
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                          labelText: 'confirm password',
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: size.width / 3,
                      height: 60,
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        color: Colors.white,
                        elevation: 5,
                        onPressed: () {
                          if (formKey.currentState.validate()) {
                            formKey.currentState.save();
                            isReg ? createAcount() : login();
                          }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Text(
                          isReg ? 'Create' : 'Login',
                          style: TextStyle(
                              color: Theme.of(context).primaryColorDark),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      width: size.width / 3,
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        elevation: 5,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onPressed: () {
                          setState(() {
                            isReg = !isReg;
                          });
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Text(
                          isReg ? 'Login' : 'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

class PasswordFields extends StatefulWidget {
  final TextEditingController controller;
  const PasswordFields(this.controller);
  @override
  _PasswordFieldsState createState() => _PasswordFieldsState();
}

class _PasswordFieldsState extends State<PasswordFields> {
  var visible = false;
  @override
  Widget build(BuildContext context) {
    print('build authhomebody.dart');

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
        child: TextField(
          obscureText: visible ? false : true,
          autocorrect: false,
          enableSuggestions: false,
          maxLines: 1,
          controller: widget.controller,
          minLines: 1,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'Password',
            suffixIcon: IconButton(
              icon: Icon(visible ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  visible = !visible;
                });
              },
            ),
          ),
        ));
  }
}
