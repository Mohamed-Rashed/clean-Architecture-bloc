import 'package:cleanex/core/resources/app_themes.dart';
import 'package:cleanex/modules/posts/presentation/Screens/post_screen.dart';
import 'package:cleanex/modules/posts/presentation/controller/post_bloc.dart';
import 'package:cleanex/core/services/services_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'flavors.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:<BlocProvider<dynamic>>[
        BlocProvider<PostBloc>(
          create: (_) => sl<PostBloc>(),
        )
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (_,__){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: F.title,
            theme: AppThemes.light,
            home: const PostScreen(),
          );
        },
      ),
    );
  }
}
