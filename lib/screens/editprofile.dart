import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:travel/models/user.dart';
import 'package:travel/providers/auth.dart';

class EditProfile extends StatefulWidget {
  static final String route = '/edit-profile';
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  void saveInfo(BuildContext context) async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      await auther.updateUser(user);
      key.currentState.showSnackBar(SnackBar(content: Text('Updated')));
    }
  }

  var auther;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    if (user == null) user = Provider.of<Auther>(context, listen: false).user;
    birthDateCtr.text = DateFormat('yyyy-MM-dd')
        .format(DateTime.fromMillisecondsSinceEpoch(user.birthdate));
    // user.visitedPlaces = List<String>();
    auther = Provider.of<Auther>(context, listen: false);
    return Scaffold(
      key: key,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          Container(
              padding: const EdgeInsets.only(right: 8.0),
              alignment: Alignment.center,
              child: FlatButton(
                child: Text(
                  'save',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  saveInfo(context);
                },
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: user.phone != null ? user.phone : '',
                    // controller: phoneCtr,
                    onSaved: (newValue) => user.phone = newValue.trim(),
                    validator: (value) {
                      if (value.length < 5) return 'invalid phone';
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'phone',
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Colors.grey,
                        )),
                    keyboardType: TextInputType.phone,
                  ),
                ),
                TextFormField(
                  initialValue: user.phone != null ? user.phone : '',
                  // controller: phoneCtr,
                  onSaved: (newValue) => user.bio = newValue.trim(),
                  decoration: InputDecoration(
                    labelText: 'Bio',
                  ),
                  keyboardType: TextInputType.phone,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) {
                      try {
                        final date = DateTime.parse(value);
                        if (date.millisecondsSinceEpoch >
                            DateTime.now().millisecondsSinceEpoch)
                          return 'invalid input';
                      } catch (e) {
                        return 'invalid date';
                      }
                      return null;
                    },
                    // initialValue: DateFormat('yyyy-MM-dd').format(
                    //     DateTime.fromMillisecondsSinceEpoch(
                    //         user.birthdate != null
                    //             ? user.birthdate
                    //             : DateTime.now().millisecondsSinceEpoch)),
                    controller: birthDateCtr,
                    onSaved: (newValue) => user.birthdate =
                        DateTime.parse(newValue).millisecondsSinceEpoch,
                    decoration: InputDecoration(
                        labelText: 'Birthday',
                        hintText: 'yyyy-MM-dd (format)',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.date_range),
                          onPressed: () {
                            openDatePicker();
                          },
                        ),
                        prefixIcon: Icon(
                          Icons.date_range,
                          color: Colors.grey,
                        )),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    // controller: posCtr,
                    initialValue: user.position != null ? user.position : 'h',
                    onSaved: (newValue) => user.position = newValue.trim(),
                    decoration: InputDecoration(
                        labelText: 'Position',
                        prefixIcon: Icon(
                          Icons.work,
                          color: Colors.grey,
                        )),
                    keyboardType: TextInputType.text,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    // controller: educCtr,
                    initialValue: user.education != null ? user.education : '',
                    onSaved: (newValue) => user.education = newValue.trim(),
                    decoration: InputDecoration(
                        labelText: 'Education',
                        prefixIcon: Icon(
                          Icons.school,
                          color: Colors.grey,
                        )),
                    keyboardType: TextInputType.text,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: placeCtr,
                    decoration: InputDecoration(
                        labelText: 'Visited places',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.check),
                          onPressed: () {
                            setState(() {
                              if (user.visitedPlaces == null) {
                                user.visitedPlaces = [];
                                print(user.visitedPlaces.length);
                              }
                              user.visitedPlaces.add(placeCtr.text.trim());
                              placeCtr.clear();
                            });
                          },
                        ),
                        prefixIcon: Icon(
                          Icons.place,
                          color: Colors.grey,
                        )),
                    keyboardType: TextInputType.text,
                  ),
                ),
                placesListWiget(),
              ],
              mainAxisSize: MainAxisSize.min,
            ),
          ),
        ),
      ),
    );
  }

  Widget placesListWiget() => Flexible(
        child: Container(
          // height: MediaQuery.of(context).size.height / 2,
          margin: const EdgeInsets.only(left: 50),
          child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (_, idx) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(user.visitedPlaces[idx]),
                  IconButton(
                    iconSize: 15,
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        user.visitedPlaces.removeAt(idx);
                      });
                    },
                  ),
                ],
              );
            },
            separatorBuilder: (_, idx) {
              return const Divider();
            },
            itemCount:
                user.visitedPlaces == null ? 0 : user.visitedPlaces.length,
          ),
        ),
      );
  final formKey = GlobalKey<FormState>();
  CustomUser user;
  void openDatePicker() async {
    final date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1940),
        lastDate: DateTime(2050));
    birthDateCtr.text = DateFormat('yyyy-MM-dd').format(date);
  }

  final birthDateCtr = TextEditingController();
  final placeCtr = TextEditingController();
}
