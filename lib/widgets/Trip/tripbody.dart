import 'dart:io';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:travel/providers/Trip.dart';
import 'package:travel/utils.dart';

class TripBody extends StatefulWidget {
  @override
  _TripBodyState createState() => _TripBodyState();
}

class _TripBodyState extends State<TripBody> {
  final _nameCtr = TextEditingController();

  final _groupCountCtr = TextEditingController();
  final _destCtr = TextEditingController();
  final _srcCtr = TextEditingController();
  final _imgCtr = TextEditingController();
  final _costCtr = TextEditingController();

  DateTime _selectedDate = DateTime.now();

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

  File _image;

  void getImage() {
    Utils.getImage().then((value) => setState(() {
          _image = value;
        }));
  }

  Widget feild(String title, TextEditingController ctr, IconData icon) =>
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(icon),
            ),
            Expanded(
              child: TextField(
                keyboardType: Icons.people == icon || Icons.attach_money == icon
                    ? TextInputType.number
                    : TextInputType.text,
                controller: ctr,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: title,
                  suffixIcon: Icons.my_location == icon ||
                          Icons.location_on_sharp == icon
                      ? IconButton(
                          icon: Icon(Icons.add_location_alt_outlined),
                          onPressed: () {},
                        )
                      : Icons.image == icon
                          ? IconButton(
                              icon: Icon(Icons.add_photo_alternate),
                              onPressed: getImage,
                            )
                          : null,
                ),
              ),
            ),
          ],
        ),
      );
  Trip get getTrip {
    //TODO use providers to get data to createtrip post;
    return Trip(
      title: _nameCtr.text,
      
      date: _selectedDate.millisecondsSinceEpoch,
      minCost: double.parse(_costCtr.text),
      groupSize: int.parse(_groupCountCtr.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    final f = DateFormat('E, yyyy-MM').add_jm();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            feild('Image', _imgCtr, Icons.image),
            feild('Trip Name', _nameCtr, Icons.title),
            feild('From location', _srcCtr, Icons.my_location),
            feild('To location', _destCtr, Icons.location_on_sharp),
            feild('Group size', _groupCountCtr, Icons.people),
            feild('Minimum Cost', _costCtr, Icons.attach_money),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.access_time),
                  ),
                  Expanded(child: Text(f.format(_selectedDate))),
                  IconButton(
                    icon: Icon(
                      Icons.date_range,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () => _selectDate(context),
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
