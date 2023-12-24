import 'package:cleanex/core/resources/color_manager.dart';
import 'package:cleanex/core/services/services_locator.dart';
import 'package:cleanex/core/services/verificationId_singletone.dart';
import 'package:cleanex/core/utilis/enums.dart';
import 'package:cleanex/modules/posts/presentation/controller/post_bloc.dart';
import 'package:cleanex/modules/posts/presentation/controller/post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  RefreshController refresh = RefreshController();
  GeneralSingleton generalSingleton = GeneralSingleton();

  @override
  void initState() {
    super.initState();
    sl<PostBloc>().add(GetPosts(postId: sl<PostBloc>().postId, limit: 10));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<PostBloc, PostState>(listener: (context, state) {
        if (state.getPostsState == RequestState.loaded) {
          refresh.loadComplete();
        } else if (state.getPostsState == RequestState.error) {
          print("Error");
        }
      }, builder: (context, state) {
        if (state.getPostsState == RequestState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.getPostsState == RequestState.loaded ||
            state.getPostsState == RequestState.pagination) {
          return SmartRefresher(
            controller: refresh,
            enablePullDown: true,
            enablePullUp: true,
            header: const ClassicHeader(
              refreshStyle: RefreshStyle.UnFollow,
            ),
            footer: CustomFooter(
              builder: (BuildContext context, LoadStatus? mode) {
                Widget body;
                if (mode == LoadStatus.idle) {
                  body = Container();
                } else if (mode == LoadStatus.loading) {
                  body = const CircularProgressIndicator();
                } else if (mode == LoadStatus.failed) {
                  body = const Text("Load Failed!Click retry!");
                } else if (mode == LoadStatus.canLoading) {
                  body = const Text("release to load more");
                } else if (generalSingleton.postsEnd.isNotEmpty) {
                  body = const Text(" no more data");
                } else {
                  body = const Text("");
                }
                return SizedBox(
                  height: 55.0,
                  child: Center(child: body),
                );
              },
            ),
            onRefresh: () {
              sl<PostBloc>().postId = 0;
              sl<PostBloc>()
                  .add(GetPosts(postId: sl<PostBloc>().postId, limit: 10));
            },
            onLoading: () {
              sl<PostBloc>().postId = sl<PostBloc>().postId + 10;
              sl<PostBloc>()
                  .add(GetPosts(postId: sl<PostBloc>().postId, limit: 10));
            },
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: AppColors.deepPurple,
                  height: 42.h,
                );
              },
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: const BoxDecoration(
                      color: Color(0xff7d6161),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "user Id : ${state.postsResponse![index].userId}",
                            style: const TextStyle(color: AppColors.white),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Text(
                            "Id : ${state.postsResponse![index].id}",
                            style: const TextStyle(color: AppColors.white),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Text(
                            "title : ${state.postsResponse![index].title}",
                            style: const TextStyle(color: AppColors.white),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Text(
                            "body : ${state.postsResponse![index].body}",
                            style: const TextStyle(color: AppColors.white),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: state.postsResponse!.length,
            ),
          );
        } else {
          return Container();
        }
      }),
    );
  }
}
