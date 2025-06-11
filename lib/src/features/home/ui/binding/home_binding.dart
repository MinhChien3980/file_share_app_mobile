part of '../../home.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeViewModel>(HomeViewModel(), permanent: true);
    Get.put<ExplorerViewModel>(ExplorerViewModel(), permanent: true);
    Get.put<PostSearchViewModel>(PostSearchViewModel(), permanent: true);
    Get.put<ProfileViewModel>(ProfileViewModel(), permanent: true);
  }
}
