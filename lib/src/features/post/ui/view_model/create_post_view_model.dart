part of '../../post.dart';

class CreatePostViewModel extends ViewModel {
  final _postRepository = getIt<PostRepository>();
  final _uploadService = getIt<UploadService>();

  final RxList<PostTag> _tags = <PostTag>[].obs;
  List<PostTag> get tags => _tags.value;
  final contentController = TextEditingController();
  final RxList<PostTag> _selectedTags = <PostTag>[].obs;
  List<PostTag> get selectedTags => _selectedTags.value;
  final RxList<File> _selectFile = <File>[].obs;
  List<File> get selectFile => _selectFile.value;

  final _privacy = 'PUBLIC'.obs;
  String get privacy => _privacy.value;

  void setPrivacy(String value) {
    _privacy.value = value;
  }

  @override
  void onInit() {
    super.onInit();
    _fetchTags();
  }

  void _fetchTags() {
    runAction<Result<List<PostTag>>>(
      () async {
        return await _postRepository.getPostTags();
      },
      onSuccess: (data) {
        data.when(success: (data) {
          _tags.value = data;
        }, failure: (error) {
          Get.closeAllSnackbars();
          Get.snackbar('Error', error.message);
        });
      },
      onError: (error) {
        Get.closeAllSnackbars();
        Get.snackbar(error.title ?? 'Error', error.message);
      },
    );
  }

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.isNotEmpty) {
      final file = result.files.map((file) => File(file.path!)).first;
      if (_selectFile.any((f) => f.path == file.path)) {
        Get.closeAllSnackbars();
        Get.snackbar(
            'File already selected', 'This file has already been selected.');
        return;
      }
      _selectFile.add(file);
    } else {
      Get.closeAllSnackbars();
      Get.snackbar('No files selected', 'Please select at least one file.');
    }
  }

  void removeFile(String filePath) {
    _selectFile.removeWhere((file) => file.path == filePath);
  }

  void pickTag(BuildContext context, CreatePostViewModel viewModel) {
    if (_tags.isEmpty) {
      Get.closeAllSnackbars();
      Get.snackbar('No tags available', 'Please fetch tags first.');
      return;
    }
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return _PickTags(viewModel: viewModel);
      },
    );
  }

  void removeTag(PostTag tag) {
    _selectedTags.remove(tag);
  }

  void createPost() {
    final content = contentController.text.trim();
    if (content.isEmpty) {
      Get.closeAllSnackbars();
      Get.snackbar(
          'Content required', 'Please enter some content for the post.');
      return;
    }

    final tags = _selectedTags.value;
    final files = _selectFile.value;
    final privacy = _privacy.value;

    runAction<Result<PostModel>>(
      () async {
        return await _postRepository.createPost(
          content: content,
          files: files,
          privacy: privacy,
          tags: tags.isNotEmpty ? tags : null,
        );
      },
      showLoading: true,
      onSuccess: (result) {
        result.when(
          success: (data) {
            contentController.clear();
            _selectedTags.clear();
            _selectFile.clear();
            Get.back(); // Close the bottom sheet or navigate back
            Get.closeAllSnackbars();
            Get.snackbar(
                'Post created', 'Your post has been created successfully.');
          },
          failure: (error) {
            error.printError();
            Get.closeAllSnackbars();
            Get.snackbar('Error', error.message);
          },
        );
      },
      onError: (error) {
        Get.closeAllSnackbars();
        Get.snackbar(error.title ?? 'Error', error.message);
      },
    );
  }
}

class _PickTags extends StatelessWidget {
  final CreatePostViewModel viewModel;

  const _PickTags({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Select Tags',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Obx(() => Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: viewModel.tags.map((tag) {
                  return ChoiceChip(
                    label: Text(tag.name ?? ''),
                    selected: viewModel.selectedTags.contains(tag),
                    onSelected: (selected) {
                      if (selected) {
                        viewModel._selectedTags.add(tag);
                      } else {
                        viewModel.removeTag(tag);
                      }
                    },
                  );
                }).toList(),
              )),
        ],
      ),
    );
  }
}
