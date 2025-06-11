part of '../../post.dart';

class MyPostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyPostViewModel>(() => MyPostViewModel());
  }
}
