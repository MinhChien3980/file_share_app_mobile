part of '../../post.dart';

class CreatePostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreatePostViewModel>(() => CreatePostViewModel());
  }
}
