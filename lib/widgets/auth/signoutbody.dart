import 'package:flutter/material.dart';
import 'package:travel/screens/Home.dart';
import 'package:travel/screens/auth.dart';

class SignOutBody extends StatelessWidget {
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
              height: 40,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
              child: TextField(
                maxLines: 1,
                controller: emailCtr,
                minLines: 1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
              child: TextField(
                maxLines: 1,
                keyboardType: TextInputType.phone,
                controller: emailCtr,
                minLines: 1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'phone',
                ),
              ),
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
            PasswordFields(passCtr, 'Password', true),
            PasswordFields(passCtr, 'Confirm password', false),
            Container(
              width: 200,
              height: 70,
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: RaisedButton(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                onPressed: () {
                  Navigator.of(context).popUntil((route) {
                    print('route is ${route.toString()}');
                    if (Auth.route.contains(route.settings.name)) {
                      print('route is ${route.toString()}');
                      Navigator.of(context).popAndPushNamed(Home.route);
                      return true;
                    }
                    return false;
                  });
                },
                child: Text(
                  'CREATE',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Theme.of(context).primaryColorDark,
              ),
            ),
            // RaisedButton.icon(onPressed: (){}, icon: Icon(Icons.f), label: null)
          ],
        ),
      ),
    );
  }
}

class PasswordFields extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool iconed;
  PasswordFields(this.controller, this.label, this.iconed);
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
            labelText: widget.label,
            suffixIcon: widget.iconed
                ? IconButton(
                    icon:
                        Icon(visible ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        visible = !visible;
                      });
                    },
                  )
                : null,
          ),
        ));
  }
}
