import 'package:bloc_app_sample/data/models/post_model.dart';
import 'package:bloc_app_sample/logic/cubits/post_cubit/post_cubit.dart';
import 'package:bloc_app_sample/logic/cubits/post_cubit/post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('API Handling')),
      body: SafeArea(
        child: BlocBuilder<PostCubit, PostState>(
          builder: (context, state) {
            if (state is PostLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is PostLoadedState) {
              return postListView(state.posts);
            }
            return const Center(child: Text('An Error Occurred!'));
          },
        ),
      ),
    );
  }

  Widget postListView(List<PostModel> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        PostModel post = posts[index];
        return ListTile(
          title: Text(post.title ?? ''),
          subtitle: Text(post.body ?? ''),
        );
      },
    );
  }
}
