part of '../../post.dart';

class PostSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PostSearchViewModel>(PostSearchViewModel(), permanent: true);
  }
}
