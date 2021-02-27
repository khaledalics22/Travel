import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/user.dart';

import 'package:travel/widgets/profile/profilebody.dart';

class ProfileData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context, listen: false);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 1.0,
          horizontal: 20.0,
        ),
        child: Text(
          user.bio != null ? user.bio : 'Bio',
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
