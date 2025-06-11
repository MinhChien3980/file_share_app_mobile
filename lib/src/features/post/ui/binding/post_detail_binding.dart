part of '../../post.dart';

class PostDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostDetailViewModel>(() => PostDetailViewModel());
  }
}
