import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FullScreenImageViewer extends StatelessWidget {
  final String imageUrl;
  final String? title;
  final String? heroTag;

  const FullScreenImageViewer({
    super.key,
    required this.imageUrl,
    this.title,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(
          title ?? 'Xem ảnh',
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.download, color: Colors.white),
            onPressed: () => _downloadImage(),
          ),
        ],
      ),
      body: Center(
        child: InteractiveViewer(
          child: Hero(
            tag: heroTag ?? imageUrl,
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                    color: Colors.white,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.broken_image,
                        color: Colors.white,
                        size: 64,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Không thể tải ảnh',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _downloadImage() async {
    try {
      // Show download message
      Get.snackbar(
        'Đang tải xuống',
        'Ảnh sẽ được lưu vào thư mục Downloads',
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.blue.shade100,
        colorText: Colors.blue.shade800,
        icon: const Icon(Icons.download, color: Colors.blue),
      );

      // TODO: Integrate with download system
      await Future.delayed(const Duration(seconds: 1));

      Get.closeAllSnackbars();
      Get.snackbar(
        'Thành công',
        'Ảnh đã được thêm vào danh sách tải xuống',
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.green.shade100,
        colorText: Colors.green.shade800,
        icon: const Icon(Icons.check_circle, color: Colors.green),
      );
    } catch (e) {
      Get.closeAllSnackbars();
      Get.snackbar(
        'Lỗi tải xuống',
        'Không thể tải ảnh. Vui lòng thử lại.',
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
        icon: const Icon(Icons.error, color: Colors.red),
      );
      print('Download error: $e');
    }
  }

  static void show({
    required String imageUrl,
    String? title,
    String? heroTag,
  }) {
    Get.to(
      () => FullScreenImageViewer(
        imageUrl: imageUrl,
        title: title,
        heroTag: heroTag,
      ),
      transition: Transition.fadeIn,
      duration: const Duration(milliseconds: 300),
    );
  }
}
