import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cleanex/core/error/failure.dart';
import 'package:cleanex/core/utilis/enums.dart';
import 'package:cleanex/modules/posts/data/model/post_model.dart';
import 'package:cleanex/modules/posts/domain/entities/post.dart';
import 'package:cleanex/modules/posts/domain/usecase/get_posts_usecase.dart';
import 'package:cleanex/modules/posts/presentation/controller/post_state.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

part 'post_event.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetPostsUseCase getPostsUseCase;
  int postId = 0;

  PostBloc(
    this.getPostsUseCase,
  ) : super(PostState()) {
    on<PostEvent>((PostEvent event, Emitter<PostState> emit) async {
      if (event is GetPosts) {
        try {
          if(event.postId == 0){
            emit(state.copyWith(
              getPostsState: RequestState.loading,
            ));
          }else{
            emit(state.copyWith(
              getPostsState: RequestState.pagination,
            ));
          }

          Either<Failure, List<Post>> result = await getPostsUseCase(
            event.postId,
            event.limit,
          );
          result.fold(
            (Failure l) => emit(state.copyWith(
              getPostsState: RequestState.error,
              message: l.authErrorMessageModel.en,
            )),
            (List<Post> r) {
              emit(state.copyWith(
                postsResponse: r,
                getPostsState: RequestState.loaded,
              ));
            },
          );
        } on Exception catch (e) {
          emit(state.copyWith(
            getPostsState: RequestState.error,
            message: "",
          ));
        }
      }
    });
  }
}
