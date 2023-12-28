import 'package:cleanex/core/network/network_info.dart';
import 'package:cleanex/modules/posts/data/datasource/post_local_data_source.dart';
import 'package:cleanex/modules/posts/data/datasource/post_remote_data_source.dart';
import 'package:cleanex/modules/posts/data/repository/post_repository.dart';
import 'package:cleanex/modules/posts/domain/repository/base_post_repository.dart';
import 'package:cleanex/modules/posts/domain/usecase/get_posts_usecase.dart';
import 'package:cleanex/modules/posts/presentation/controller/post_bloc.dart';
import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

class ServicesLocator{
  Future<void> init() async {

    // bloc

    sl.registerLazySingleton(() => PostBloc(sl()));

    // useCases
    sl.registerLazySingleton(() => GetPostsUseCase(sl()));

    // Repository
    sl.registerLazySingleton<BasePostsRepository>(() => PostRepository(sl(),sl(),sl()));

    // data Source
    sl.registerLazySingleton<BasePostRemoteDataSource>(
            () => PostRemoteDataSource());

    sl.registerLazySingleton<BasePostLocalDataSource>(
          () => PostLocalDataSourceImpl(sl()),
    );


    final sharedPreferences =
        await SharedPreferences.getInstance();

    sl.registerLazySingleton(() => sharedPreferences);
    sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
    sl.registerLazySingleton(() => DataConnectionChecker());
  }
}