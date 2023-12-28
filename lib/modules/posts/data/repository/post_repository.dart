import 'package:cleanex/core/error/exceptions.dart';
import 'package:cleanex/core/error/failure.dart';
import 'package:cleanex/core/network/network_info.dart';
import 'package:cleanex/modules/posts/data/datasource/post_local_data_source.dart';
import 'package:cleanex/modules/posts/data/datasource/post_remote_data_source.dart';
import 'package:cleanex/modules/posts/data/model/post_model.dart';
import 'package:cleanex/modules/posts/domain/entities/post.dart';
import 'package:cleanex/modules/posts/domain/repository/base_post_repository.dart';
import 'package:dartz/dartz.dart';

class PostRepository extends BasePostsRepository {
  final BasePostRemoteDataSource basePostRemoteDataSource;
  final BasePostLocalDataSource basePostLocalDataSource;
  final NetworkInfo networkInfo;

  PostRepository(
    this.basePostRemoteDataSource,
    this.basePostLocalDataSource,
    this.networkInfo,
  );

  @override
  Future<Either<Failure, List<Post>>> getPosts(
      {required int postId, required int limit}) async {

    if(await networkInfo.isConnected){
      try {
        final List<PostModel> result = await basePostRemoteDataSource.getPosts(postId: postId, limit: limit);
        basePostLocalDataSource.cashPosts(postList: result);
        return Right(result);
      } on ServerExceptions catch (failure) {
        return Left(ServerFailure(failure.errorMessageModel));
      }
    }else{
      try {
        final localPosts = await basePostLocalDataSource.getLastPosts();
        return Right(localPosts);
      } on ServerExceptions catch (failure) {
        return Left(ServerFailure(failure.errorMessageModel));
      }
    }
  }
}
