import 'package:cleanex/modules/posts/data/datasource/post_remote_data_source.dart';
import 'package:cleanex/modules/posts/data/repository/post_repository.dart';
import 'package:cleanex/modules/posts/domain/repository/base_post_repository.dart';
import 'package:cleanex/modules/posts/domain/usecase/get_posts_usecase.dart';
import 'package:cleanex/modules/posts/presentation/controller/post_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class ServicesLocator{
  void init(){

    // bloc

    sl.registerLazySingleton(() => PostBloc(sl()));

    // useCases
    sl.registerLazySingleton(() => GetPostsUseCase(sl()));

    // Repository
    sl.registerLazySingleton<BasePostsRepository>(() => PostRepository(sl()));

    // data Source
    sl.registerLazySingleton<BasePostRemoteDataSource>(
            () => PostRemoteDataSource());
  }
}