import 'package:bloc_app_sample/data/models/post_model.dart';
import 'package:bloc_app_sample/data/repositories/post_repository.dart';
import 'package:bloc_app_sample/logic/cubits/post_cubit/post_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostLoadingState()) {
    fetchPosts();
  }
  PostRepository postRepository = PostRepository();
  void fetchPosts() async {
    try {
      List<PostModel> posts = await postRepository.fetchPosts();
      emit(PostLoadedState(posts));
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.unknown) {
        emit(PostErrorState('Internet Error, Please Check Your Internet!'));
      }
    }
  }
}
