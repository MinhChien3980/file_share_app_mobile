part of '../../post.dart';

class PostCard extends StatefulWidget {
  final PostModel post;
  final void Function()? onTap;
  final void Function(bool isLike) onLike;
  const PostCard(
      {super.key, required this.post, this.onTap, required this.onLike});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // User Header
          if (widget.post.user != null)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.grey.shade300,
                    backgroundImage: widget.post.user?.imageUrl != null &&
                            widget.post.user!.imageUrl!.isNotEmpty
                        ? NetworkImage(widget.post.user!.imageUrl!)
                        : null,
                    child: widget.post.user?.imageUrl == null ||
                            widget.post.user!.imageUrl!.isEmpty
                        ? Icon(Icons.person, color: Colors.grey.shade600)
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.post.user?.username ?? 'Unknown User',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 2),
                        if (widget.post.createdAt != null)
                          Text(
                            _formatTimestamp(widget.post.createdAt!),
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 13,
                            ),
                          ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.more_horiz, color: Colors.grey.shade600),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

          // Post Content
          if (widget.post.content != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getTextWithoutHashtags(widget.post.content!),
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Hashtags
                  if (_getHashtags(widget.post.content!).isNotEmpty)
                    Wrap(
                      spacing: 4,
                      children:
                          _getHashtags(widget.post.content!).map((hashtag) {
                        return GestureDetector(
                          onTap: () {
                            // Handle hashtag tap
                          },
                          child: Text(
                            hashtag,
                            style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                ],
              ),
            ),

          const SizedBox(height: 12),

          // Images Grid
          if (_getImageFiles().isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildImageGrid(),
            ),

          // Files Info (if there are non-image files)
          if (_getNonImageFiles().isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _getNonImageFiles().map((fileUrl) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade50,
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Row(
                      children: [
                        // File type icon
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: _getFileTypeColor(fileUrl),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: _getFileTypeIcon(fileUrl),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // File info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _getFileName(fileUrl),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    _getFileExtension(fileUrl).toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Download button
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconButton(
                            onPressed: () {
                              // Handle file download/view
                              _handleFileAction(fileUrl);
                            },
                            icon: Icon(
                              Icons.cloud_download_outlined,
                              color: Colors.blue.shade600,
                              size: 22,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

          // Reaction Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                _buildReactionButton(
                  Icons.thumb_up_outlined,
                  '${widget.post.reactionCount ?? 0}',
                  widget.post.isLiked ?? false,
                  () => widget.onLike(!(widget.post.isLiked ?? false)),
                ),
                const SizedBox(width: 20),
                _buildReactionButton(
                  Icons.comment_outlined,
                  '${widget.post.commentCount ?? 0}',
                  false,
                  () {},
                ),
                const SizedBox(width: 20),
                _buildReactionButton(
                  Icons.share_outlined,
                  '${widget.post.shareCount ?? 0}',
                  false,
                  () {},
                ),
                const Spacer(),
                if (widget.post.viewCount != null)
                  Row(
                    children: [
                      Icon(Icons.visibility_outlined,
                          size: 16, color: Colors.grey.shade600),
                      const SizedBox(width: 4),
                      Text(
                        '${widget.post.viewCount}',
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 13),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageGrid() {
    final images = _getImageFiles();
    if (images.isEmpty) return const SizedBox.shrink();

    if (images.length == 1) {
      return _buildSingleImage(images[0]);
    } else if (images.length == 2) {
      return _buildTwoImages(images);
    } else if (images.length == 3) {
      return _buildThreeImages(images);
    } else {
      return _buildFourOrMoreImages(images);
    }
  }

  Widget _buildSingleImage(String imageUrl) {
    return GestureDetector(
      onTap: () => _openImageViewer(imageUrl, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Hero(
            tag: 'post_image_${widget.post.id}_0',
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: _imageLoadingBuilder,
              errorBuilder: _imageErrorBuilder,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTwoImages(List<String> images) {
    return SizedBox(
      height: 200,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => _openImageViewer(images[0], 0),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                child: Hero(
                  tag: 'post_image_${widget.post.id}_0',
                  child: Image.network(
                    images[0],
                    fit: BoxFit.cover,
                    height: double.infinity,
                    loadingBuilder: _imageLoadingBuilder,
                    errorBuilder: _imageErrorBuilder,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 2),
          Expanded(
            child: GestureDetector(
              onTap: () => _openImageViewer(images[1], 1),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                child: Hero(
                  tag: 'post_image_${widget.post.id}_1',
                  child: Image.network(
                    images[1],
                    fit: BoxFit.cover,
                    height: double.infinity,
                    loadingBuilder: _imageLoadingBuilder,
                    errorBuilder: _imageErrorBuilder,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThreeImages(List<String> images) {
    return SizedBox(
      height: 200,
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Image.network(
                images[0],
                fit: BoxFit.cover,
                height: double.infinity,
                loadingBuilder: _imageLoadingBuilder,
                errorBuilder: _imageErrorBuilder,
              ),
            ),
          ),
          const SizedBox(width: 2),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(12),
                    ),
                    child: Image.network(
                      images[1],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      loadingBuilder: _imageLoadingBuilder,
                      errorBuilder: _imageErrorBuilder,
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(12),
                    ),
                    child: Image.network(
                      images[2],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      loadingBuilder: _imageLoadingBuilder,
                      errorBuilder: _imageErrorBuilder,
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

  Widget _buildFourOrMoreImages(List<String> images) {
    return SizedBox(
      height: 240,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                    ),
                    child: Image.network(
                      images[0],
                      fit: BoxFit.cover,
                      height: double.infinity,
                      loadingBuilder: _imageLoadingBuilder,
                      errorBuilder: _imageErrorBuilder,
                    ),
                  ),
                ),
                const SizedBox(width: 2),
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(12),
                    ),
                    child: Image.network(
                      images[1],
                      fit: BoxFit.cover,
                      height: double.infinity,
                      loadingBuilder: _imageLoadingBuilder,
                      errorBuilder: _imageErrorBuilder,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                    ),
                    child: Image.network(
                      images[2],
                      fit: BoxFit.cover,
                      height: double.infinity,
                      loadingBuilder: _imageLoadingBuilder,
                      errorBuilder: _imageErrorBuilder,
                    ),
                  ),
                ),
                const SizedBox(width: 2),
                Expanded(
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(12),
                        ),
                        child: Image.network(
                          images[3],
                          fit: BoxFit.cover,
                          height: double.infinity,
                          width: double.infinity,
                          loadingBuilder: _imageLoadingBuilder,
                          errorBuilder: _imageErrorBuilder,
                        ),
                      ),
                      if (images.length > 4)
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(12),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '+${images.length - 4}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReactionButton(
      IconData icon, String count, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 20,
            color: isActive ? Colors.blue : Colors.grey.shade600,
          ),
          const SizedBox(width: 4),
          Text(
            count,
            style: TextStyle(
              color: isActive ? Colors.blue : Colors.grey.shade600,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _imageLoadingBuilder(
      BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
    if (loadingProgress == null) return child;
    return Container(
      color: Colors.grey.shade200,
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.grey.shade400),
        ),
      ),
    );
  }

  Widget _imageErrorBuilder(
      BuildContext context, Object error, StackTrace? stackTrace) {
    return Container(
      color: Colors.grey.shade200,
      child: Center(
        child: Icon(Icons.broken_image, color: Colors.grey.shade400, size: 32),
      ),
    );
  }

  String _formatTimestamp(String timestampStr) {
    try {
      final timestamp = DateTime.parse(timestampStr);
      final now = DateTime.now();
      final diff = now.difference(timestamp);

      if (diff.inDays > 0) {
        return '${diff.inDays} ngày trước';
      } else if (diff.inHours > 0) {
        return '${diff.inHours} giờ trước';
      } else if (diff.inMinutes > 0) {
        return '${diff.inMinutes} phút trước';
      } else {
        return 'Vừa xong';
      }
    } catch (e) {
      return 'Không rõ';
    }
  }

  List<String> _getImageFiles() {
    if (widget.post.files == null || widget.post.files!.isEmpty) {
      return [];
    }
    return widget.post.files!.where((file) {
      final lowercaseFile = file.toLowerCase();
      return lowercaseFile.endsWith('.jpg') ||
          lowercaseFile.endsWith('.jpeg') ||
          lowercaseFile.endsWith('.png') ||
          lowercaseFile.endsWith('.gif') ||
          lowercaseFile.endsWith('.webp');
    }).toList();
  }

  List<String> _getNonImageFiles() {
    if (widget.post.files == null || widget.post.files!.isEmpty) {
      return [];
    }
    return widget.post.files!.where((file) {
      final lowercaseFile = file.toLowerCase();
      return !(lowercaseFile.endsWith('.jpg') ||
          lowercaseFile.endsWith('.jpeg') ||
          lowercaseFile.endsWith('.png') ||
          lowercaseFile.endsWith('.gif') ||
          lowercaseFile.endsWith('.webp'));
    }).toList();
  }

  String _getTextWithoutHashtags(String content) {
    return content.replaceAll(RegExp(r'#\w+'), '').trim();
  }

  List<String> _getHashtags(String content) {
    final regex = RegExp(r'#\w+');
    return regex.allMatches(content).map((match) => match.group(0)!).toList();
  }

  Color _getFileTypeColor(String fileUrl) {
    final extension = _getFileExtension(fileUrl).toLowerCase();
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

  Widget _getFileTypeIcon(String fileUrl) {
    final extension = _getFileExtension(fileUrl).toLowerCase();

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

  String _getFileName(String fileUrl) {
    try {
      // Extract filename from URL
      final uri = Uri.parse(fileUrl);
      String fileName = uri.pathSegments.last;

      // Remove any query parameters
      if (fileName.contains('?')) {
        fileName = fileName.split('?').first;
      }

      // If still no readable name, try to extract from path
      if (fileName.isEmpty || fileName.length < 3) {
        final segments = fileUrl.split('/');
        fileName = segments.isNotEmpty ? segments.last : 'Unknown File';
      }

      // Decode URL encoding
      fileName = Uri.decodeFull(fileName);

      // If filename is too long, create a shorter display name
      if (fileName.length > 50 && !fileName.contains(' ')) {
        final extension = _getFileExtension(fileName);
        if (extension.isNotEmpty) {
          fileName = 'Document.$extension';
        } else {
          fileName = 'Document';
        }
      }

      return fileName;
    } catch (e) {
      return 'Document';
    }
  }

  String _getFileExtension(String fileUrl) {
    try {
      final fileName = _getFileName(fileUrl);
      final lastDotIndex = fileName.lastIndexOf('.');
      if (lastDotIndex != -1 && lastDotIndex < fileName.length - 1) {
        return fileName.substring(lastDotIndex + 1);
      }
      return 'file';
    } catch (e) {
      return 'file';
    }
  }

  void _handleFileAction(String fileUrl) async {
    try {
      final fileName = _getFileName(fileUrl);
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final uniqueFileName = '${timestamp}_$fileName';

      String downloadPath;
      if (Platform.isAndroid) {
        // Use External Storage for Android Downloads folder
        final downloadsPath = '/storage/emulated/0/Download';
        final directory = Directory(downloadsPath);
        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }
        downloadPath = '$downloadsPath/$uniqueFileName';
      } else {
        // For iOS, use Documents directory
        final directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }
        downloadPath = '${directory.path}/$uniqueFileName';
      }

      // Create download task and add to download manager
      final downloadTask = DownloadTask(
        url: fileUrl,
        fileName: fileName,
        localPath: downloadPath,
        status: DownloadTaskStatus.pending,
        progress: 0,
      );

      // Get download view model and add task
      final downloadViewModel = Get.find<DownloadViewModel>();
      downloadViewModel.addDownloadTask(downloadTask);

      Get.snackbar(
        'Đã thêm vào danh sách tải',
        'File đang được tải xuống. Kiểm tra trang Downloads để xem tiến trình.',
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.blue.shade100,
        colorText: Colors.blue.shade800,
        icon: const Icon(Icons.download, color: Colors.blue),
        onTap: (snack) {
          Get.find<HomeViewModel>().changeIndex(2);
        },
      );
    } catch (e) {
      Get.closeAllSnackbars();
      Get.snackbar(
        'Lỗi thêm tải xuống',
        'Không thể thêm file vào danh sách tải. Vui lòng thử lại.',
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
        icon: const Icon(Icons.error, color: Colors.red),
      );
      print('Download error: $e');
    }
  }

  void _openImageViewer(String imageUrl, int index) {
    FullScreenImageViewer.show(
      imageUrl: imageUrl,
      title: 'Ảnh trong bài viết',
      heroTag: 'post_image_${widget.post.id}_$index',
    );
  }
}
