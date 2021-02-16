import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:travel/providers/Comment.dart';
import 'package:travel/providers/post.dart';

class Posts with ChangeNotifier {
  List<Post> _postsList = [];
  final postsRef = FirebaseFirestore.instance.collection('posts');
  final postsFiles = FirebaseStorage.instance.ref('posts');

  Future<dynamic> addPost(Post post) async {
    final postDoc = postsRef.doc();
    if (post.hasImg || post.hasVid) {
      final ref = postsFiles
          .child('/${FirebaseAuth.instance.currentUser.uid}')
          .child('/${postDoc.id}.' + (post.hasImg ? 'jpg' : 'mp4'));
      final task = ref.putFile(
          post.file,
          SettableMetadata(
              contentType: post.hasImg ? 'image/jpeg' : 'video/mp4'));
      final url = await (await Future.value(task)).ref.getDownloadURL();
      post.hasImg ? post.imgUrl = url : post.videoUrl = url;
    }
    var result = postDoc.set(post.toJson);
    notifyListeners();
    return result; 
  }

  Future<QuerySnapshot> loadPosts() async {
    return postsRef.get();
    // print('loaded');
    // result.docs.map((e) {
    //   if (e.exists) {
    //     print(e);
    //   }
    // });
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
    return _postsList.firstWhere((element) => element.postId == id);
  }

  List<Post> get postsList {
    return [..._postsList]; // retur copy of list with no reference
  }
}
