import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/user.dart';
import 'package:travel/providers/Requests.dart';
import 'package:travel/widgets/circularImage.dart';
import 'package:travel/widgets/profile/userprofilebody.dart';

class UserProfile extends StatelessWidget {
  static final route = '/user-profile';
  @override
  Widget build(BuildContext context) {
    final uid = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        body: FutureBuilder(
            future: Requests.getUserById(uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final user = CustomUser.fromJson(snapshot.data);
                return SafeArea(
                  child: NestedScrollView(
                    body: ChangeNotifierProvider.value(
                      value: user,
                      child: Container(
                          color: Colors.white, child: UserProfileBody()),
                    ),
                    headerSliverBuilder: (context, innerBoxIsScrolled) {
                      return [
                        SliverAppBar(
                          titleSpacing: NavigationToolbar.kMiddleSpacing,
                          expandedHeight: 200.0,
                          floating: true,
                          pinned: true,
                          forceElevated: innerBoxIsScrolled,
                          flexibleSpace: FlexibleSpaceBar(
                              centerTitle: true,
                              // stretchModes: [StretchMode.blurBackground],
                              title: Text(user.name,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  )),
                              background: Container(
                                width: double.infinity,
                                height: (170.0 + 50.0),
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    user.coverUrl == null
                                        ? Positioned(
                                            top: 0,
                                            bottom: 0,
                                            left: 0,
                                            right: 0,
                                            child: Image.asset(
                                              'assets/icon/traveller.jpg',
                                              fit: BoxFit.cover,
                                              height: 170.0,
                                              filterQuality: FilterQuality.low,
                                              width: double.infinity,
                                            ),
                                          )
                                        : Image.network(
                                            user.coverUrl,
                                            fit: BoxFit.cover,
                                            height: 170.0,
                                            filterQuality: FilterQuality.low,
                                            width: double.infinity,
                                            loadingBuilder: (context, child,
                                                    loadingProgress) =>
                                                loadingProgress == null
                                                    ? child
                                                    : CircularProgressIndicator(),
                                          ),
                                    Positioned(
                                      child: Container(
                                        height: 2,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Divider(
                                          thickness: 2,
                                        ),
                                      ),
                                      top: 150,
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      child: CircleAvatar(
                                        radius: 79,
                                        backgroundColor: Colors.grey,
                                        child: user.profileUrl == null
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(150),
                                                child: Image.asset(
                                                  'assets/icon/traveller.jpg',
                                                  width: 150,
                                                  height: 150,
                                                  filterQuality:
                                                      FilterQuality.low,
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            : CircularImage(
                                                150.0, user.profileUrl),
                                      ),
                                    ),
                                    Positioned(
                                      child: Container(
                                        height: 50,
                                        color: Colors.black54,
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        ),
                      ];
                    },
                  ),
                );
              }
              return Container();
            }));
  }
}
