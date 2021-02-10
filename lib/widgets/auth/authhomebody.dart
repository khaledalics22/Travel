import 'package:flutter/material.dart';
import 'package:travel/screens/signout.dart';

class AuthBody extends StatelessWidget {
  final TextEditingController passCtr = TextEditingController();
  final TextEditingController emailCtr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
            ),
            Text(
              'Travel',
              style: TextStyle(
                color: Theme.of(context).primaryColorDark,
                fontSize: 50,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
              child: TextField(
                maxLines: 1,
                keyboardType: TextInputType.emailAddress,
                controller: emailCtr,
                minLines: 1,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    suffixIcon: Icon(Icons.email)),
              ),
            ),
            PasswordFields(passCtr),
            SizedBox(
              height: 40,
            ),
            Container(
              width: 200,
              height: 60,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: RaisedButton(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  onPressed: () {},
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                  color: Colors.white),
            ),
            Container(
              width: 200,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: RaisedButton(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  onPressed: () {
                    Navigator.of(context).pushNamed(SignOut.route);
                  },
                  child: Text(
                    'Create acount',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  color: Theme.of(context).primaryColorDark),
            ),
          ],
        ),
      ),
    );
  }
}

class PasswordFields extends StatefulWidget {
  TextEditingController controller;
  PasswordFields(this.controller);
  @override
  _PasswordFieldsState createState() => _PasswordFieldsState();
}

class _PasswordFieldsState extends State<PasswordFields> {
  var visible = false;
  @override
  Widget build(BuildContext context) {
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
            border: OutlineInputBorder(),
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
