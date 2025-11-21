import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_respository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogsUseCase implements UseCase<List<Blog>, NoParms> {
  final BlogRespository blogRespository;

  GetAllBlogsUseCase(this.blogRespository);
  @override
  Future<Either<Failure, List<Blog>>> call(NoParms params) async {
    return await blogRespository.getAllBlogs();
  }
}
