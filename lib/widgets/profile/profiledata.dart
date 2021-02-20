import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/auth.dart';
import 'package:travel/widgets/profile/profilebody.dart';
import 'package:travel/widgets/profile/profiletop.dart';

class ProfileData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auther = Provider.of<Auther>(context);
    final user = auther.user;
    return Column(children: [
      ProfileTop(),
      Padding(
        padding: const EdgeInsets.all(3.0),
        child: Text(
          user.name != null ? user.name : 'name',
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 1.0,
          horizontal: 20.0,
        ),
        child: Text(
          user.bio != null ? user.bio : 'Add bio here',
          maxLines: 2,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ),
      const Divider(
        thickness: 1,
        indent: 7,
      ),
      ProfileBody(),
    ]);
  }
}
