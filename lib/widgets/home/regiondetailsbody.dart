import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:travel/providers/auth.dart';
import 'package:travel/providers/place.dart';
import 'package:travel/providers/placescomments.dart';
import 'package:travel/providers/regions.dart';
import 'package:travel/widgets/home/countrieslist.dart';
import 'package:travel/widgets/home/landmarkslist.dart';
import 'package:travel/widgets/home/placecomments.dart';

class RegionDetailsBody extends StatelessWidget {
  final id;
  final type;
  RegionDetailsBody(this.id, this.type);
  @override
  Widget build(BuildContext context) {
    var region;
    if (type == Type.REGION)
      region = Provider.of<Regions>(context, listen: false).getRegionById(id);
    else
      region = Provider.of<Place>(context, listen: false);
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
      child: SingleChildScrollView(
        // physics: NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    region.title,
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RatingBar(
                    onRatingUpdate: null,
                    ratingWidget: RatingWidget(
                      half: null,
                      empty: Icon(
                        Icons.star,
                        color: Colors.grey,
                      ),
                      full: Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                    ),
                    ignoreGestures: true,
                    initialRating: region.rate.index.toDouble(),
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemSize: 20,
                    itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ReadMoreText(
                region.details,
                style: TextStyle(
                  color: Colors.grey,
                ),
                trimLines: 5,
                lessStyle: TextStyle(color: Theme.of(context).primaryColorDark),
                moreStyle: TextStyle(color: Theme.of(context).primaryColorDark),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                type == Type.REGION ? 'States' : 'Where To Go',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            // CONTENT HERE-------------------
            type == Type.REGION
                ? CountriesList(region.countris)
                : Flexible(flex: 1, child: LandmarksList(region.landmarks)),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'Comments',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            CommentActions(region.id),
            Divider(
              thickness: 1,
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: PlaceCommentsList(region.id),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommentActions extends StatelessWidget {
  final placeId;
  CommentActions(this.placeId);
  @override
  Widget build(BuildContext context) {
    final _commentControllder = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 40,
          color: Colors.pink[50],
          child: Row(mainAxisSize: MainAxisSize.max, children: [
            Expanded(
              child: TextField(
                controller: _commentControllder,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'leave comment here',
                    contentPadding: EdgeInsets.all(8.0)),
              ),
            ),
            IconButton(
                icon: Icon(
                  Icons.send,
                  color: Theme.of(context).primaryColorDark,
                ),
                onPressed: () async {
                  if (_commentControllder.text.isNotEmpty)
                    await Provider.of<PlaceComments>(context, listen: false)
                        .addCommentToPlaceById(placeId, {
                      'authorId':
                          Provider.of<Auther>(context, listen: false).user.id,
                      'body': _commentControllder.text
                    });
                  _commentControllder.clear();
                }),
          ]),
        ),
      ),
    );
  }
}
