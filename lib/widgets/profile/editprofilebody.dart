import 'package:flutter/material.dart';
import 'package:travel/models/place.dart';

class EditProfileBody extends StatefulWidget {
  @override
  _EditProfileBodyState createState() => _EditProfileBodyState();
}

class _EditProfileBodyState extends State<EditProfileBody> {
  Widget inputField(String title, TextEditingController ctr, IconData icon) =>
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
                keyboardType: Icons.people == icon
                    ? TextInputType.number
                    : TextInputType.text,
                controller: ctr,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: title,
                  suffixIcon: Icons.date_range == icon
                      ? IconButton(
                          icon: Icon(Icons.date_range),
                          onPressed: () {},
                        )
                      : Icons.place == icon
                          ? IconButton(
                              icon: Icon(Icons.check),
                              onPressed: () {},
                            )
                          : null,
                ),
              ),
            ),
          ],
        ),
      );
  var _visitedPlaces = [
    Place(title: 'Paris'),
    Place(title: 'UK'),
    Place(title: 'US'),
    Place(title: 'India'),
    Place(title: 'China'),
    Place(title: 'Cairo'),
  ];
  Widget placesListWiget() => Flexible(
        child: Container(
          height: MediaQuery.of(context).size.height / 2,
          margin: const EdgeInsets.only(left: 50),
          child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (_, idx) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _visitedPlaces[idx].title,
                  ),
                  IconButton(
                    iconSize: 15,
                    icon: Icon(Icons.close),
                    onPressed: () {},
                  ),
                ],
              );
            },
            separatorBuilder: (_, idx) {
              return const Divider();
            },
            itemCount: _visitedPlaces.length,
          ),
        ),
      );
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            inputField('Birthday', null, Icons.date_range),
            inputField('Position', null, Icons.work),
            inputField('Education', null, Icons.school),
            inputField('visited places', null, Icons.place),
            placesListWiget(),
          ],
          mainAxisSize: MainAxisSize.min,
        ),
      ),
    );
  }
}
