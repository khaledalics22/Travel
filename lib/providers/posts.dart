import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:travel/providers/Comment.dart';
import 'package:travel/providers/post.dart';

class Posts with ChangeNotifier {
  List<Post> _postsList = [];
  final postsRef = FirebaseFirestore.instance.collection('posts');
  final postsFiles = FirebaseStorage.instance.ref('posts');

  Future<QuerySnapshot> getPostsOfUser(String uid) async {
    return postsRef.where('autherId', isEqualTo: uid).get();
  }

  final _searchHistRef = FirebaseFirestore.instance.collection('searchHist');

  Future<QuerySnapshot> searchHistoryofUser(String uid) async {
    return _searchHistRef.doc(uid).collection('history').orderBy('date').get();
  }

  Future<void> addHistoryForUser(String uid, String text, int date) async {
    final refDoc = _searchHistRef.doc(uid).collection('history').doc();
    await refDoc.set({'id': refDoc.id, 'text': text, 'date': date});
  }

  Future<void> removeHistOfUser(String uid, String histId) {
    return _searchHistRef.doc(uid).collection('history').doc(histId).delete(); 
  }

  Future<void> addPost(Post post, uid) async {
    final postDoc = postsRef.doc();
    post.postId = postDoc.id;
    // print('--------------------- ${postDoc.id}');
    if (post.hasImg || post.hasVid) {
      final ref = postsFiles
          .child('/$uid')
          .child('/${postDoc.id}.' + (post.hasImg ? 'jpg' : 'mp4'));
      final task = ref.putFile(
          post.file,
          SettableMetadata(
              contentType: post.hasImg ? 'image/jpeg' : 'video/mp4'));
      final url = await (await Future.value(task)).ref.getDownloadURL();
      post.hasImg ? post.imgUrl = url : post.videoUrl = url;
    }
    await postDoc.set(post.toJson);
    _postsList.insert(postsList.length - 1, post);
    notifyListeners();
  }

  Future<void> loadPosts() async {
    if (_postsList.isNotEmpty) return;
    final response = await postsRef.orderBy('date').get();
    _postsList.addAll(response.docs.map((e) {
      // print('*******loaded post provider******');
      return Post.fromJson(e.data());
    }).toList());
    notifyListeners();
  }

  Future<QuerySnapshot> searchForTripByTitle(String body) async {
    return postsRef.where('trip.title', isEqualTo: body).get();
  }

  List<Post> findByTitle(String title) {
    if (title == null) return [];
    return _postsList
        .where((post) => (post.isTrip && post.trip.title.contains(title)))
        .toList();
  }

  List<Comment> findCommentsOfPostId(String id) {
    return _postsList
        .firstWhere((element) => element.postId == id)
        .commentsList;
  }

  Post findById(String id) {
    return _postsList.firstWhere((element) => element.postId == id,
        orElse: () => null);
  }

  List<Post> get postsList {
    return [..._postsList.reversed]; // retur copy of list with no reference
  }
}
