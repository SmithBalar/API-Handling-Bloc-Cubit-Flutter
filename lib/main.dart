import 'dart:developer';

import 'package:bloc_app_sample/data/models/post_model.dart';
import 'package:bloc_app_sample/data/repositories/post_repository.dart';
import 'package:bloc_app_sample/logic/cubits/post_cubit/post_cubit.dart';
import 'package:bloc_app_sample/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PostRepository postRepository = PostRepository();
  List<PostModel> postModels = await postRepository.fetchPosts();
  log(postModels.toString());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PostCubit()),
        BlocProvider(create: (context) => PostCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
      ),
    );
  }
}
