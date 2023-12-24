import 'package:cleanex/core/utilis/enums.dart';
import 'package:cleanex/modules/posts/domain/entities/post.dart';
import 'package:equatable/equatable.dart';

class PostState extends Equatable {
  RequestState getPostsState;
  final List<Post>? postsResponse;
  final String message;

  PostState({
    this.getPostsState = RequestState.initState,
    this.postsResponse,
    this.message = "",
  });


  PostState copyWith({
    RequestState? getPostsState,
    List<Post>? postsResponse,
    String? message,
  }) {
    return PostState(
      getPostsState: getPostsState ?? this.getPostsState,
      postsResponse: postsResponse ?? this.postsResponse,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [getPostsState,postsResponse, message];
}
