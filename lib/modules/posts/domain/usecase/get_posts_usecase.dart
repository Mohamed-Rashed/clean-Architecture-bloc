
import 'package:cleanex/core/error/failure.dart';
import 'package:cleanex/modules/posts/domain/entities/post.dart';
import 'package:cleanex/modules/posts/domain/repository/base_post_repository.dart';
import 'package:dartz/dartz.dart';

class GetPostsUseCase{
  final BasePostsRepository basePostsRepository;

  GetPostsUseCase(this.basePostsRepository);


  Future<Either<Failure, List<Post>>> call(int postId,int limit) async{
    return await basePostsRepository.getPosts(postId: postId , limit: limit);
  }
}