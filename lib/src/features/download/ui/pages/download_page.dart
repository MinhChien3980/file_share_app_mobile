part of '../../download.dart';

class DownloadPage extends BaseView<DownloadViewModel> {
  const DownloadPage({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Downloads'),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: () {
              _showClearDialog(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade400, Colors.blue.shade600],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.shade200,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: GetBuilder<DownloadViewModel>(
              builder: (controller) {
                final total = controller.downloadTasks.length;
                final completed = controller.downloadTasks
                    .where((t) => t.status == DownloadTaskStatus.completed)
                    .length;
                final downloading = controller.downloadTasks
                    .where((t) => t.status == DownloadTaskStatus.downloading)
                    .length;
                final pending = controller.downloadTasks
                    .where((t) => t.status == DownloadTaskStatus.pending)
                    .length;
                final failed = controller.downloadTasks
                    .where((t) => t.status == DownloadTaskStatus.failed)
                    .length;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatusItem('Tổng cộng', total.toString(),
                        Icons.download, Colors.white),
                    _buildStatusItem('Hoàn thành', completed.toString(),
                        Icons.check_circle, Colors.green.shade200),
                    _buildStatusItem('Đang tải', downloading.toString(),
                        Icons.downloading, Colors.orange.shade200),
                    _buildStatusItem('Thất bại', failed.toString(), Icons.error,
                        Colors.red.shade200),
                  ],
                );
              },
            ),
          ),

          // Downloads List
          Expanded(
            child: GetBuilder<DownloadViewModel>(
              builder: (controller) {
                if (controller.downloadTasks.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.download_outlined,
                          size: 80,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Chưa có file tải xuống',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tải file từ bài viết sẽ xuất hiện ở đây',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // Group downloads by status
                final activeDownloads = controller.downloadTasks
                    .where((task) =>
                        task.status == DownloadTaskStatus.downloading ||
                        task.status == DownloadTaskStatus.pending)
                    .toList();

                final completedDownloads = controller.downloadTasks
                    .where(
                        (task) => task.status == DownloadTaskStatus.completed)
                    .toList();

                final failedDownloads = controller.downloadTasks
                    .where((task) => task.status == DownloadTaskStatus.failed)
                    .toList();

                return ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    if (activeDownloads.isNotEmpty) ...[
                      _buildSectionHeader('Đang tải xuống',
                          activeDownloads.length, Icons.downloading),
                      ...activeDownloads
                          .map((task) => _buildDownloadCard(task, context)),
                      const SizedBox(height: 16),
                    ],
                    if (completedDownloads.isNotEmpty) ...[
                      _buildSectionHeader('Đã hoàn thành',
                          completedDownloads.length, Icons.check_circle),
                      ...completedDownloads
                          .map((task) => _buildDownloadCard(task, context)),
                      const SizedBox(height: 16),
                    ],
                    if (failedDownloads.isNotEmpty) ...[
                      _buildSectionHeader(
                          'Thất bại', failedDownloads.length, Icons.error),
                      ...failedDownloads
                          .map((task) => _buildDownloadCard(task, context)),
                      const SizedBox(height: 16),
                    ],
                  ],
                );
              },
            ),
          ),

          // Action Buttons
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      viewModel.startAllDownloads();
                    },
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Bắt đầu tất cả'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      viewModel.cancelAllDownloads();
                    },
                    icon: const Icon(Icons.pause),
                    label: const Text('Dừng tất cả'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusItem(
      String label, String value, IconData icon, Color iconColor) {
    return Column(
      children: [
        Icon(icon, color: iconColor, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, int count, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey.shade700),
          const SizedBox(width: 8),
          Text(
            '$title ($count)',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDownloadCard(DownloadTask task, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // File type icon
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: _getFileTypeColor(task.fileName),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: _getFileTypeIcon(task.fileName),
                  ),
                ),
                const SizedBox(width: 12),

                // File info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.fileName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          _buildStatusChip(task.status!),
                          const SizedBox(width: 8),
                          if (task.status == DownloadTaskStatus.downloading)
                            Text(
                              '${task.progress.toInt()}%',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 12,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Action buttons
                _buildActionButton(task),
              ],
            ),
          ),

          // Progress bar for downloading files
          if (task.status == DownloadTaskStatus.downloading)
            Container(
              height: 4,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: LinearProgressIndicator(
                value: task.progress / 100,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade600),
              ),
            ),

          const SizedBox(height: 4),
        ],
      ),
    );
  }

  Widget _buildStatusChip(DownloadTaskStatus status) {
    Color backgroundColor;
    Color textColor;
    String text;

    switch (status) {
      case DownloadTaskStatus.pending:
        backgroundColor = Colors.orange.shade100;
        textColor = Colors.orange.shade700;
        text = 'Chờ';
        break;
      case DownloadTaskStatus.downloading:
        backgroundColor = Colors.blue.shade100;
        textColor = Colors.blue.shade700;
        text = 'Đang tải';
        break;
      case DownloadTaskStatus.completed:
        backgroundColor = Colors.green.shade100;
        textColor = Colors.green.shade700;
        text = 'Hoàn thành';
        break;
      case DownloadTaskStatus.failed:
        backgroundColor = Colors.red.shade100;
        textColor = Colors.red.shade700;
        text = 'Thất bại';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildActionButton(DownloadTask task) {
    switch (task.status!) {
      case DownloadTaskStatus.pending:
        return IconButton(
          icon: const Icon(Icons.play_arrow, color: Colors.green),
          onPressed: () => viewModel.startDownload(task),
        );
      case DownloadTaskStatus.downloading:
        return IconButton(
          icon: const Icon(Icons.pause, color: Colors.orange),
          onPressed: () => viewModel.cancelDownload(task.url),
        );
      case DownloadTaskStatus.completed:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.open_in_new, color: Colors.blue),
              onPressed: () => OpenFile.open(task.localPath),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => viewModel.deleteTask(task),
            ),
          ],
        );
      case DownloadTaskStatus.failed:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.refresh, color: Colors.blue),
              onPressed: () => viewModel.startDownload(task),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => viewModel.deleteTask(task),
            ),
          ],
        );
    }
  }

  Color _getFileTypeColor(String fileName) {
    final extension = fileName.split('.').last.toLowerCase();
    switch (extension) {
      case 'pdf':
        return Colors.red.shade600;
      case 'doc':
      case 'docx':
        return Colors.blue.shade600;
      case 'xls':
      case 'xlsx':
        return Colors.green.shade600;
      case 'ppt':
      case 'pptx':
        return Colors.orange.shade600;
      case 'txt':
        return Colors.grey.shade600;
      case 'zip':
      case 'rar':
      case '7z':
        return Colors.purple.shade600;
      case 'mp3':
      case 'wav':
      case 'flac':
        return Colors.pink.shade600;
      case 'mp4':
      case 'avi':
      case 'mov':
        return Colors.indigo.shade600;
      default:
        return Colors.grey.shade600;
    }
  }

  Widget _getFileTypeIcon(String fileName) {
    final extension = fileName.split('.').last.toLowerCase();

    switch (extension) {
      case 'doc':
      case 'docx':
        return const Text(
          'W',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        );
      case 'xls':
      case 'xlsx':
        return const Text(
          'X',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        );
      case 'ppt':
      case 'pptx':
        return const Text(
          'P',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        );
      case 'pdf':
        return const Text(
          'PDF',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        );
      default:
        IconData iconData;
        switch (extension) {
          case 'txt':
            iconData = Icons.text_snippet;
            break;
          case 'zip':
          case 'rar':
          case '7z':
            iconData = Icons.archive;
            break;
          case 'mp3':
          case 'wav':
          case 'flac':
            iconData = Icons.music_note;
            break;
          case 'mp4':
          case 'avi':
          case 'mov':
            iconData = Icons.video_file;
            break;
          default:
            iconData = Icons.insert_drive_file;
        }

        return Icon(
          iconData,
          color: Colors.white,
          size: 24,
        );
    }
  }

  void _showClearDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: const Text('Xóa tất cả'),
        content:
            const Text('Bạn có chắc muốn xóa tất cả file đã tải hoàn thành?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              viewModel.clearCompletedTasks();
              Get.back();
            },
            child: const Text('Xóa'),
          ),
        ],
      ),
    );
  }
}
