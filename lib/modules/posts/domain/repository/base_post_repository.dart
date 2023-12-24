import 'package:cleanex/core/error/failure.dart';
import 'package:cleanex/modules/posts/domain/entities/post.dart';
import 'package:dartz/dartz.dart';

abstract class BasePostsRepository{
  Future<Either<Failure, List<Post>>> getPosts({required int postId, required int limit});
}