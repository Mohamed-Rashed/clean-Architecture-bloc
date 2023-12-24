part of 'post_bloc.dart';

@immutable
abstract class PostEvent {}

class GetPosts extends PostEvent {
  int postId;
  int limit;

  GetPosts({
    required this.postId,
    required this.limit,
  });
}
