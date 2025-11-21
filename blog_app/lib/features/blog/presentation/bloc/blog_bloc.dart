import 'dart:io';

import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogsUseCase _getAllBlogs;
  BlogBloc({
    required UploadBlog uploadBlog,
    required GetAllBlogsUseCase getAllBlogs,
  }) : _uploadBlog = uploadBlog,
       _getAllBlogs = getAllBlogs,
       super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>(_onBlogUpload);
    on<GetAllBlogs>(_onGetAllBlogs);
  }

  void _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    final res = await _uploadBlog(
      UploadBlogParams(
        posterId: event.posterId,
        title: event.title,
        content: event.content,
        image: event.image,
        topics: event.topics,
      ),
    );
    res.fold(
      (failure) => emit(BlogFailure(failure.message)),
      (blog) => emit(BlogUploadSuccess()),
    );
  }

  void _onGetAllBlogs(GetAllBlogs event, Emitter<BlogState> emit) async {
    final res = await _getAllBlogs(NoParms());
    res.fold(
      (failure) => emit(BlogFailure(failure.message)),
      (blogs) => emit(BlogDisplaySuccess(blogs)),
    );
  }
}
