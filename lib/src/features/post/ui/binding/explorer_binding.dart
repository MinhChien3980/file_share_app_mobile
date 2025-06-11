part of '../../post.dart';

class ExplorerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ExplorerViewModel>(ExplorerViewModel(), permanent: true);
  }
}
