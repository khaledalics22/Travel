import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:travel/providers/Comment.dart';
import 'package:travel/providers/post.dart';

class Posts with ChangeNotifier {
  List<Post> _postsList = [];
  final postsRef = FirebaseFirestore.instance.collection('posts');
  final postsFiles = FirebaseStorage.instance.ref('posts');

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
    _postsList.insert(0, post);
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
