import 'dart:convert';

import 'package:cleanex/modules/posts/data/model/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BasePostLocalDataSource{
  Future<List<PostModel>> getLastPosts();

  Future<void> cashPosts({
    required List<PostModel> postList,
  });
}

const CACHED_POSTS = 'CACHED_POSTS';

class PostLocalDataSourceImpl implements BasePostLocalDataSource{
  final SharedPreferences sharedPreferences;


  PostLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<void> cashPosts({required List<PostModel> postList}) {
    return sharedPreferences.setString(
      CACHED_POSTS,
      jsonEncode(postList),
    );
  }

  @override
  Future<List<PostModel>> getLastPosts() async{
    var sampleDataFromPref = sharedPreferences.getString(CACHED_POSTS);
    var sampleJsonMap = json.decode(sampleDataFromPref!);
    List<PostModel> sampleListFromPreferance = List<PostModel>
        .from(sampleJsonMap.map((x) => PostModel.fromJson(x)));

    return sampleListFromPreferance;
  }
}