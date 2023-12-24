import 'package:cleanex/core/error/exceptions.dart';
import 'package:cleanex/core/network/api_constance.dart';
import 'package:cleanex/core/network/app_error_message_model.dart';
import 'package:cleanex/core/services/dio_service.dart';
import 'package:cleanex/core/services/verificationId_singletone.dart';
import 'package:cleanex/modules/posts/data/model/post_model.dart';
import 'package:dio/dio.dart';

abstract class BasePostRemoteDataSource {
  Future<List<PostModel>> getPosts({
    required int postId,
    required int limit,
  });
}

class PostRemoteDataSource extends BasePostRemoteDataSource{
  List<PostModel> listOfPosts = <PostModel>[];
  GeneralSingleton generalSingleton = GeneralSingleton();

  @override
  Future<List<PostModel>> getPosts({required int postId, required int limit}) async {
    final Map<String, dynamic> body = <String, dynamic>{
      "_start" : postId,
      "_limit": limit,
    };

    if (postId == 0) {
      generalSingleton.postsEnd = "";
      listOfPosts = [];
    }
    final Response? response = await ApiService.getApi(
      "https://jsonplaceholder.typicode.com/posts",
        body
    );
    if (response!.statusCode == 200) {
      List<PostModel> responseList = (response.data! as List<dynamic>)
          .map((e) => PostModel.fromJson(e))
          .toList();
      if (responseList.isNotEmpty ) {
        listOfPosts.addAll(responseList);
      }else{
        generalSingleton.postsEnd = "end";
      }

      return listOfPosts;
    } else {
      throw ServerExceptions(
          errorMessageModel:
          const ErrorMessageModel(en: "ffff" , ar: "kkkkkk"));
    }
  }

}
