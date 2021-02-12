import 'package:flutter/cupertino.dart';
import 'package:travel/providers/Comment.dart';
import 'package:travel/providers/Trip.dart';
import 'package:travel/providers/post.dart';

class Posts with ChangeNotifier {
  List<Post> _postsList = [
    Post(
        authorId: 'mazen',
        caption: 'saqara was amazing',
        hasImg: false,
        hasVid: true,
        videoUrl:
            'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
        postId: '1',
        isTrip: false,
        imgUrl: 'https://homepages.cae.wisc.edu/~ece533/images/airplane.png',
        likesList: [
          'd',
          'd',
          'd'
        ],
        commetsList: [
          Comment(
              likesList: ['14'],
              body: 'saqara looks amazing!',
              authorName: 'khalid Ali',
              date: DateTime.now().millisecondsSinceEpoch - 1000000,
              authorImgUrl:
                  'https://homepages.cae.wisc.edu/~ece533/images/cat.png'),
          Comment(
              likesList: ['14'],
              body: 'it looks amazing!',
              authorName: 'khalid Ali',
              date: DateTime.now().millisecondsSinceEpoch - 1000000,
              authorImgUrl:
                  'https://homepages.cae.wisc.edu/~ece533/images/cat.png'),
          Comment(
              likesList: ['14'],
              body: 'it looks amazing!',
              authorName: 'khalid Ali',
              date: DateTime.now().millisecondsSinceEpoch - 1000000,
              authorImgUrl:
                  'https://homepages.cae.wisc.edu/~ece533/images/cat.png'),
          Comment(
              likesList: ['14'],
              body: 'it looks amazing!',
              authorName: 'khalid Ali',
              date: DateTime.now().millisecondsSinceEpoch - 1000000,
              authorImgUrl:
                  'https://homepages.cae.wisc.edu/~ece533/images/cat.png'),
          Comment(
              likesList: ['14'],
              body: 'it looks amazing!',
              authorName: 'khalid Ali',
              date: DateTime.now().millisecondsSinceEpoch - 1000000,
              authorImgUrl:
                  'https://homepages.cae.wisc.edu/~ece533/images/cat.png'),
        ]),
    Post(
        authorId: 'ahmed',
        caption: 'plah was amazing',
        hasImg: true,
        hasVid: false,
        isTrip: true,
        trip: Trip(
          group: ['f', 'f', 'f'],
          title: 'auxor',
          organizer: 'ahmed',
          details: 'we are grouping 15 people for a journey to saqara',
          date: DateTime.now().millisecondsSinceEpoch,
          minCost: 124.0,
        ),
        postId: '2',
        minCost: 300,
        groupSize: 7,
        imgUrl:
            'https://www.publicdomainpictures.net/pictures/220000/velka/train-tracks-into-distance-1493549798TvG.jpg',
        likesList: [
          'd',
          'd',
        ],
        commetsList: [
          Comment(
              likesList: ['14'],
              body: 'plah looks amazing!',
              authorName: 'khalid Ali',
              date: DateTime.now().millisecondsSinceEpoch - 1000000,
              authorImgUrl:
                  'https://homepages.cae.wisc.edu/~ece533/images/cat.png'),
          Comment(
              likesList: ['14'],
              body: 'it looks amazing!',
              authorName: 'khalid Ali',
              date: DateTime.now().millisecondsSinceEpoch - 10000,
              authorImgUrl:
                  'https://homepages.cae.wisc.edu/~ece533/images/cat.png'),
        ]),
    Post(
        authorId: 'mohamed',
        caption: 'it was amazing',
        hasImg: true,
        postId: '3',
        hasVid: false,
        isTrip: true,
        groupSize: 12,
        trip: Trip(
            title: 'sharm',
            organizer: 'mohamed',
            details: 'we are grouping 15 people for a journey to saqara',
            date: DateTime.now().millisecondsSinceEpoch,
            minCost: 124.0,
            group: []),
        minCost: 100,
        imgUrl:
            'https://www.publicdomainpictures.net/pictures/30000/t2/small-yacht-at-sea.jpg',
        likesList: [
          'd',
          'd',
          'd',
          'd'
        ],
        commetsList: [
          Comment(
              likesList: ['14'],
              body: 'it looks amazing!',
              authorName: 'khalid Ali',
              date: DateTime.now().millisecondsSinceEpoch - 1000000,
              authorImgUrl:
                  'https://homepages.cae.wisc.edu/~ece533/images/cat.png'),
          Comment(
              likesList: ['10'],
              body: 'it looks amazing!',
              authorName: 'khalid Ali',
              date: DateTime.now().millisecondsSinceEpoch - 10000,
              authorImgUrl:
                  'https://homepages.cae.wisc.edu/~ece533/images/cat.png'),
          Comment(
              likesList: ['8'],
              body: 'it looks amazing!',
              authorName: 'khalid Ali',
              date: DateTime.now().millisecondsSinceEpoch - 10000,
              authorImgUrl:
                  'https://homepages.cae.wisc.edu/~ece533/images/cat.png'),
          Comment(
              likesList: ['14'],
              body: 'it looks amazing!',
              authorName: 'khalid Ali',
              date: DateTime.now().millisecondsSinceEpoch - 100000,
              authorImgUrl:
                  'https://homepages.cae.wisc.edu/~ece533/images/cat.png'),
          Comment(
              likesList: ['7'],
              body: 'it looks amazing!',
              authorName: 'khalid Ali',
              date: DateTime.now().millisecondsSinceEpoch - 1000000,
              authorImgUrl:
                  'https://homepages.cae.wisc.edu/~ece533/images/cat.png'),
          Comment(
              likesList: ['14'],
              body: 'it looks amazing!',
              authorName: 'khalid Ali',
              date: DateTime.now().millisecondsSinceEpoch - 1000000,
              authorImgUrl:
                  'https://homepages.cae.wisc.edu/~ece533/images/cat.png'),
          Comment(
              likesList: ['14'],
              body: 'it looks amazing!',
              authorName: 'khalid Ali',
              date: DateTime.now().millisecondsSinceEpoch - 1000000,
              authorImgUrl:
                  'https://homepages.cae.wisc.edu/~ece533/images/cat.png'),
          Comment(
              likesList: ['5'],
              body: 'it looks amazing!',
              authorName: 'khalid Ali',
              date: DateTime.now().millisecondsSinceEpoch - 1000000,
              authorImgUrl:
                  'https://homepages.cae.wisc.edu/~ece533/images/cat.png'),
          Comment(
              likesList: ['4'],
              body: 'it looks amazing!',
              authorName: 'khalid Ali',
              date: DateTime.now().millisecondsSinceEpoch - 1000000,
              authorImgUrl:
                  'https://homepages.cae.wisc.edu/~ece533/images/cat.png'),
          Comment(
              likesList: ['4'],
              body: 'it looks amazing!',
              authorName: 'khalid Ali',
              date: DateTime.now().millisecondsSinceEpoch - 1000000,
              authorImgUrl:
                  'https://homepages.cae.wisc.edu/~ece533/images/cat.png'),
        ]),
    Post(
        authorId: 'tarek',
        caption: 'it was amazing',
        hasImg: true,
        hasVid: false,
        videoUrl:
            'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
        postId: '5',
        isTrip: false,
        imgUrl: 'https://homepages.cae.wisc.edu/~ece533/images/airplane.png',
        likesList: [
          'd',
          'd',
          'd',
          'd'
        ],
        commetsList: [
          Comment(
              likesList: ['14'],
              body: 'it looks amazing!',
              authorName: 'khalid Ali',
              date: DateTime.now().millisecondsSinceEpoch - 1000000,
              authorImgUrl:
                  'https://homepages.cae.wisc.edu/~ece533/images/cat.png'),
          Comment(
              likesList: ['14'],
              body: 'it looks amazing!',
              authorName: 'khalid Ali',
              date: DateTime.now().millisecondsSinceEpoch - 10000,
              authorImgUrl:
                  'https://homepages.cae.wisc.edu/~ece533/images/cat.png'),
          Comment(
              likesList: ['14'],
              body: 'it looks amazing!',
              authorName: 'khalid Ali',
              date: DateTime.now().millisecondsSinceEpoch - 10000,
              authorImgUrl:
                  'https://homepages.cae.wisc.edu/~ece533/images/cat.png'),
          Comment(
              likesList: ['14'],
              body: 'it looks amazing!',
              authorName: 'khalid Ali',
              date: DateTime.now().millisecondsSinceEpoch - 100000,
              authorImgUrl:
                  'https://homepages.cae.wisc.edu/~ece533/images/cat.png'),
          Comment(
              likesList: ['14'],
              body: 'it looks amazing!',
              authorName: 'khalid Ali',
              date: DateTime.now().millisecondsSinceEpoch - 1000000,
              authorImgUrl:
                  'https://homepages.cae.wisc.edu/~ece533/images/cat.png'),
          Comment(
              likesList: ['14'],
              body: 'it looks amazing!',
              authorName: 'khalid Ali',
              date: DateTime.now().millisecondsSinceEpoch - 1000000,
              authorImgUrl:
                  'https://homepages.cae.wisc.edu/~ece533/images/cat.png'),
          Comment(
              likesList: ['14'],
              body: 'it looks amazing!',
              authorName: 'khalid Ali',
              date: DateTime.now().millisecondsSinceEpoch - 1000000,
              authorImgUrl:
                  'https://homepages.cae.wisc.edu/~ece533/images/cat.png'),
          Comment(
              likesList: ['14'],
              body: 'it looks amazing!',
              authorName: 'khalid Ali',
              date: DateTime.now().millisecondsSinceEpoch - 1000000,
              authorImgUrl:
                  'https://homepages.cae.wisc.edu/~ece533/images/cat.png'),
          Comment(
              likesList: ['14'],
              body: 'it looks amazing!',
              authorName: 'khalid Ali',
              date: DateTime.now().millisecondsSinceEpoch - 1000000,
              authorImgUrl:
                  'https://homepages.cae.wisc.edu/~ece533/images/cat.png'),
          Comment(
              likesList: ['14'],
              body: 'it looks amazing!',
              authorName: 'khalid Ali',
              date: DateTime.now().millisecondsSinceEpoch - 1000000,
              authorImgUrl:
                  'https://homepages.cae.wisc.edu/~ece533/images/cat.png'),
        ]),
  ];
  void addPost(Post post) {
    _postsList.add(post);
    notifyListeners();
  }

  List<Comment> findCommentsOfPostId(String id) {
    return _postsList.firstWhere((element) => element.postId == id).commetsList;
  }

  Post findById(String id) {
    return _postsList.firstWhere((element) => element.postId == id);
  }

  List<Post> get postsList {
    return [..._postsList]; // retur copy of list with no reference
  }
}
