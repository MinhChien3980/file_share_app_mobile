part of '../../download.dart';

class DownloadViewModel extends ViewModel {
  final _storageService = getIt<StorageService>();
  final RxList<DownloadTask> _downloadTasks = <DownloadTask>[].obs;
  List<DownloadTask> get downloadTasks => _downloadTasks;
  final _uploadService = getIt<UploadService>();

  @override
  void onInit() {
    super.onInit();
    final localTasks = _storageService.getDownloadTasks();
    _downloadTasks.addAll(localTasks);

    ever(_downloadTasks, (List<DownloadTask> tasks) {
      _storageService.setDownloadTasks(tasks);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      update();
    });
  }

  @override
  void onClose() {
    _storageService.setDownloadTasks(_downloadTasks);
    super.onClose();
  }

  void addDownloadTask(DownloadTask task) {
    if (_downloadTasks.any((t) => t.url == task.url)) {
      Get.closeAllSnackbars();
      Get.snackbar(
        'Đã tồn tại',
        'File này đã có trong danh sách tải xuống.',
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.orange.shade100,
        colorText: Colors.orange.shade800,
        icon: const Icon(Icons.info, color: Colors.orange),
      );
      return;
    }
    _downloadTasks.add(task);
    startDownload(task);
  }

  void updateDownloadTask(DownloadTask task) {
    final index = _downloadTasks.indexWhere((t) => t.url == task.url);
    if (index != -1) {
      _downloadTasks[index] = task;
    } else {
      Get.closeAllSnackbars();
      Get.snackbar(
        'Không tìm thấy',
        'Không thể tìm thấy file trong danh sách tải.',
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
        icon: const Icon(Icons.error, color: Colors.red),
      );
    }
  }

  void removeDownloadTask(String url) {
    final index = _downloadTasks.indexWhere((t) => t.url == url);
    if (index != -1) {
      _downloadTasks.removeAt(index);
    } else {
      Get.closeAllSnackbars();
      Get.snackbar(
        'Không tìm thấy',
        'Không thể tìm thấy file trong danh sách tải.',
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
        icon: const Icon(Icons.error, color: Colors.red),
      );
    }
  }

  Future<void> clearCompletedTasks() async {
    _downloadTasks
        .removeWhere((task) => task.status == DownloadTaskStatus.completed);
    Get.closeAllSnackbars();
    Get.snackbar(
      'Đã xóa',
      'Tất cả file đã tải hoàn thành đã được xóa khỏi danh sách.',
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.blue.shade100,
      colorText: Colors.blue.shade800,
      icon: const Icon(Icons.check, color: Colors.blue),
    );
  }

  void startDownload(DownloadTask task) {
    task.status = DownloadTaskStatus.downloading;
    updateDownloadTask(task);
    print('Starting download for: ${task.url}');

    _uploadService.downloadFile(
      task.url,
      task.localPath,
      bearerToken: _storageService.userToken,
      cancelToken: task.cancelToken,
      onReceiveProgress: (received, total) {
        if (total > 0) {
          task.progress = (received / total) * 100;
          task.status = DownloadTaskStatus.downloading;
          updateDownloadTask(task);
        }
      },
    ).then((_) {
      task.status = DownloadTaskStatus.completed;
      task.progress = 100;
      updateDownloadTask(task);
      Get.closeAllSnackbars();
      Get.snackbar(
        'Tải hoàn thành',
        'File "${task.fileName}" đã được tải xuống thành công.',
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.green.shade100,
        colorText: Colors.green.shade800,
        icon: const Icon(Icons.check_circle, color: Colors.green),
      );
    }).catchError((error) {
      task.status = DownloadTaskStatus.failed;
      task.progress = 0;
      updateDownloadTask(task);
      Get.closeAllSnackbars();
      Get.snackbar(
        'Tải thất bại',
        'Lỗi khi tải file "${task.fileName}": ${error.toString()}',
        duration: const Duration(seconds: 4),
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
        icon: const Icon(Icons.error, color: Colors.red),
      );
      print('Download error: $error');
    });
  }

  void startAllDownloads() {
    for (var task in _downloadTasks) {
      if (task.status == DownloadTaskStatus.pending) {
        startDownload(task);
      }
    }
  }

  void cancelDownload(String url) {
    final index = _downloadTasks.indexWhere((t) => t.url == url);
    if (index != -1) {
      _downloadTasks[index].cancelToken.cancel('Download cancelled by user');
      _downloadTasks[index] =
          _downloadTasks[index].copyWith(status: DownloadTaskStatus.failed);
      Get.closeAllSnackbars();
      Get.snackbar(
        'Đã hủy',
        'Đã hủy tải file.',
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.orange.shade100,
        colorText: Colors.orange.shade800,
        icon: const Icon(Icons.cancel, color: Colors.orange),
      );
    } else {
      Get.closeAllSnackbars();
      Get.snackbar(
        'Không tìm thấy',
        'Không thể tìm thấy file trong danh sách tải.',
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
        icon: const Icon(Icons.error, color: Colors.red),
      );
    }
  }

  void cancelAllDownloads() {
    for (var task in _downloadTasks) {
      task.cancelToken.cancel('Download cancelled by user');
      task.status = DownloadTaskStatus.failed;
    }
    Get.closeAllSnackbars();
    Get.snackbar(
      'Đã hủy tất cả',
      'Tất cả các file đang tải đã được hủy.',
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.orange.shade100,
      colorText: Colors.orange.shade800,
      icon: const Icon(Icons.cancel, color: Colors.orange),
    );
  }

  void deleteTask(DownloadTask task) {
    final index = _downloadTasks.indexWhere((t) => t.url == task.url);

    if (index != -1) {
      _downloadTasks.removeAt(index);
      Get.closeAllSnackbars();
      Get.snackbar(
        'Đã xóa',
        'File đã được xóa khỏi danh sách tải.',
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.blue.shade100,
        colorText: Colors.blue.shade800,
        icon: const Icon(Icons.delete, color: Colors.blue),
      );
    } else {
      Get.closeAllSnackbars();
      Get.snackbar(
        'Không tìm thấy',
        'Không thể tìm thấy file trong danh sách tải.',
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
        icon: const Icon(Icons.error, color: Colors.red),
      );
    }
  }
}

enum DownloadTaskStatus {
  pending,
  downloading,
  completed,
  failed;

  String get name {
    switch (this) {
      case DownloadTaskStatus.pending:
        return 'Pending';
      case DownloadTaskStatus.downloading:
        return 'Downloading';
      case DownloadTaskStatus.completed:
        return 'Completed';
      case DownloadTaskStatus.failed:
        return 'Failed';
    }
  }
}

class DownloadTask {
  final String url;
  final String fileName;
  final String localPath;
  DownloadTaskStatus? status = DownloadTaskStatus.pending;
  double progress = 0;
  final CancelToken cancelToken = CancelToken();
  DownloadTask({
    required this.url,
    required this.fileName,
    required this.localPath,
    this.status = DownloadTaskStatus.pending,
    double progress = 0,
  });

  DownloadTask copyWith({
    String? url,
    String? fileName,
    String? localPath,
    DownloadTaskStatus? status,
    double? progress,
  }) {
    return DownloadTask(
      url: url ?? this.url,
      fileName: fileName ?? this.fileName,
      localPath: localPath ?? this.localPath,
      status: status ?? this.status,
      progress: progress ?? this.progress,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'fileName': fileName,
      'localPath': localPath,
      'status': status?.name,
      'progress': progress,
    };
  }

  factory DownloadTask.fromJson(Map<String, dynamic> json) {
    return DownloadTask(
      url: json['url'] as String,
      fileName: json['fileName'] as String,
      localPath: json['localPath'] as String,
      status: DownloadTaskStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => DownloadTaskStatus.pending,
      ),
      progress: json['progress'] as double? ?? 0,
    );
  }
}
