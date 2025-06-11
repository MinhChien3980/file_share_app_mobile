part of '../../post.dart';

class CreatePostPage extends BaseView<CreatePostViewModel> {
  const CreatePostPage({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Create a new post',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: viewModel.contentController,
                        decoration: const InputDecoration(
                          labelText: 'Post Content',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 5,
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Select Tags',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Builder(builder: (context) {
                                return ElevatedButton(
                                  onPressed: () {
                                    viewModel.pickTag(context, viewModel);
                                  },
                                  child: const Text('Add Tags'),
                                );
                              }),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Obx(() => Container(
                                padding: const EdgeInsets.all(20),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: viewModel.selectedTags.isEmpty
                                    ? const Text('No tags selected')
                                    : Wrap(
                                        spacing: 8.0,
                                        runSpacing: 4.0,
                                        children: viewModel.selectedTags.map((tag) {
                                          return Chip(
                                            label: Text(tag.name ?? ''),
                                            onDeleted: () => viewModel.removeTag(tag),
                                          );
                                        }).toList(),
                                      ),
                              )),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Select Files',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.all(20),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Obx(() => ListView(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      children: viewModel.selectFile.map((file) {
                                        return Chip(
                                          label: Text(file.path.split('/').last),
                                          onDeleted: () => viewModel.removeFile(file.path),
                                        );
                                      }).toList(),
                                    )),
                                TextButton(
                                  onPressed: () {
                                    viewModel.pickFile();
                                  },
                                  child: const Text('Add File'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ElevatedButton(
                onPressed: () {
                  // Handle post creation logic
                  viewModel.createPost();
                },
                child: const Text('Create Post'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
