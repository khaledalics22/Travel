import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/auth.dart';
import 'package:travel/providers/post.dart';
import 'package:travel/providers/posts.dart';
import 'dart:io';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:travel/providers/Trip.dart';
import 'package:travel/utils.dart';

class CreateTrip extends StatelessWidget {
  static final route = '/create-trip';

  final _key = GlobalKey<ScaffoldState>();
  void callback(BuildContext context, Post post) async {
    _key.currentState.hideCurrentSnackBar();
    if (post != null) {
      final uid = Provider.of<Auther>(context, listen: false).user.id;
      await Provider.of<Posts>(context, listen: false).addPost(post, uid);
    }
    _key.currentState.showSnackBar(
      SnackBar(
        content: Text(
          post != null ? 'trip posted' : 'please enter valid data',
          style: TextStyle(
              fontSize: 18, color: Theme.of(context).primaryColorLight),
        ),
      ),
    );
  }

  GlobalKey<_CreateTripBodyState> childKey = GlobalKey<_CreateTripBodyState>();
  @override
  Widget build(BuildContext context) {
    print('build createTrip.dart');

    final tripBody = CreateTripBody(childKey, (post) {
      callback(context, post);
    });
    return Scaffold(
        key: _key,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('New Trip'),
          actions: [
            FlatButton(
              onPressed: () {
                childKey.currentState?.submit();
              },
              textColor: Colors.white,
              child: const Text(
                'post',
                style: const TextStyle(fontSize: 16),
              ),
            )
          ],
        ),
        body: tripBody);
  }
}

class CreateTripBody extends StatefulWidget {
  final key;
  CreateTripBody(this.key, this.callback) : super(key: key);
  final Function callback;
  static _CreateTripBodyState of(BuildContext context) =>
      context.findAncestorStateOfType<_CreateTripBodyState>();
  @override
  _CreateTripBodyState createState() => _CreateTripBodyState(callback);
}

class _CreateTripBodyState extends State<CreateTripBody> {
  final Function callback;
  _CreateTripBodyState(this.callback);
  final post = Post(trip: Trip());

  final _formKey = GlobalKey<FormState>();

  final pathCtr = TextEditingController();
  void getImage() {
    Utils.getImage().then((value) => setState(() {
          post.file = value;
          pathCtr.text = value.path;
        }));
  }

  DateTime _selectedDate = DateTime.now();
  void submit() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey?.currentState?.save();
      post.trip.date = _selectedDate.millisecondsSinceEpoch;
      post.hasImg = true;
      post.hasVid = false;
      post.isTrip = true;
      post.caption = post.trip.details;
      post.authorId = Provider.of<Auther>(context, listen: false).user.id;
      post.trip.organizer = post.authorId;
      post.date = DateTime.now().millisecondsSinceEpoch;
      callback(post);
    }
    callback(null);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime dateTime = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedDate),
    );
    final picked = DateTimeField.combine(dateTime, time);
    if (dateTime != null && dateTime != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    final f = DateFormat(DateFormat.YEAR_MONTH_DAY).add_jm();
    return SingleChildScrollView(
      child: Container(
        //  LinearGradient(),
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: const Icon(Icons.access_time),
                    ),
                    Expanded(child: Text(f.format(_selectedDate))),
                    FlatButton(
                      child: Text(
                        'choose date',
                        style: TextStyle(
                            color: Theme.of(context).primaryColorDark),
                      ),
                      onPressed: () => _selectDate(context),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: pathCtr,
                  // enableInteractiveSelection: false,
                  onSaved: (newValue) => post.file = File(newValue),
                  validator: (value) {
                    if (File(value).existsSync()) return null;
                    return 'Inavlid path';
                  },
                  decoration: InputDecoration(
                    labelText: 'Image path',
                    prefixIcon: Icon(Icons.image),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.add_photo_alternate,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: getImage,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  onSaved: (newValue) => post.trip.title = newValue,
                  validator: (value) {
                    // Validate File
                    if (value.length == 0) {
                      return 'Invalid trip title';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Trip title',
                      prefixIcon: Icon(Icons.title_rounded)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  onSaved: (newValue) => post.trip.details = newValue,
                  validator: (value) {
                    // Validate File
                    if (value.length == 0) {
                      return 'Invalid input';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Trip details',
                      prefixIcon: Icon(Icons.chrome_reader_mode_outlined)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  onSaved: (newValue) => post.trip.from = newValue,
                  validator: (value) {
                    if (value.length == 0) return 'Enter location';
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'launch location',
                      hintText: 'From',
                      prefixIcon: Icon(Icons.location_city_outlined)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  onSaved: (newValue) => post.trip.to = newValue,
                  validator: (value) {
                    if (value.length == 0) return 'Enter location';
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'landing location',
                      hintText: 'to location',
                      prefixIcon: Icon(Icons.location_on_outlined)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  onSaved: (newValue) =>
                      post.trip.groupSize = int.parse(newValue),
                  validator: (value) {
                    try {
                      int.parse(value);
                    } catch (error) {
                      return 'Invalid input';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Group Size',
                      hintText: 'Example (1, 2, 10, ...)',
                      prefixIcon: Icon(Icons.people_rounded)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  onSaved: (newValue) =>
                      post.trip.minCost = double.parse(newValue),
                  validator: (value) {
                    try {
                      double.parse(value);
                    } catch (error) {
                      return 'Invalid input';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Cost',
                      prefixIcon: Icon(Icons.attach_money_rounded)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
