part of '../../post.dart';

class PostDetailPage extends BaseView<PostDetailViewModel> {
  const PostDetailPage({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: viewModel.postDetail.user?.imageUrl !=
                                null
                            ? NetworkImage(viewModel.postDetail.user!.imageUrl!)
                            : const AssetImage('assets/img/default_avatar.png')
                                as ImageProvider<Object>,
                      ),
                      title: Text(viewModel.postDetail.user?.username ?? '',
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                if (viewModel.postDetail.content != null)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: HtmlWidget(
                        viewModel.postDetail.content!,
                        textStyle:
                            const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ),
                if (viewModel.postDetail.tags != null &&
                    viewModel.postDetail.tags!.isNotEmpty)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tags',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 6,
                            runSpacing: 4,
                            children: viewModel.postDetail.tags!.map((tag) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade50,
                                  borderRadius: BorderRadius.circular(16),
                                  border:
                                      Border.all(color: Colors.blue.shade200),
                                ),
                                child: Text(
                                  '#${tag.name ?? ''}',
                                  style: TextStyle(
                                    color: Colors.blue.shade700,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (viewModel.postDetail.files != null &&
                    viewModel.postDetail.files!.isNotEmpty)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color.alphaBlend(
                            context.colorScheme.primary.withValues(alpha: 0.2),
                            Colors.white,
                          ),
                        ),
                        child: Obx(() => ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                if (index >= viewModel.fileInPost.length) {
                                  return const SizedBox.shrink();
                                }
                                final file = viewModel.fileInPost[index];
                                return Row(
                                  children: [
                                    const Icon(Icons.attach_file,
                                        color: Colors.blue),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(file.name,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                              '${(file.size / 1024).toStringAsFixed(2)} kb',
                                              style: const TextStyle(
                                                  color: Colors.grey)),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.download,
                                          color: Colors.green),
                                      onPressed: () {
                                        viewModel.downloadFile(file.url);
                                      },
                                    ),
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) => Divider(
                                color: Colors.grey.shade300,
                                height: 1,
                              ),
                              itemCount: viewModel.fileInPost.length,
                            )),
                      ),
                    ),
                  ),
              ],
            )),
            // ReactionButtonGroup(
            //   post: viewModel.postDetail,
            //   onLike: (isLike) {},
            //   onComment: (isComment) {},
            //   onBookmark: (isBookmark) {},
            // )
          ],
        ),
      ),
    );
  }
}

class ReactionButtonGroup extends StatefulWidget {
  final PostModel post;
  final Function(bool) onLike;
  final Function(bool) onComment;
  final Function(bool) onBookmark;
  const ReactionButtonGroup({
    super.key,
    required this.post,
    required this.onLike,
    required this.onComment,
    required this.onBookmark,
  });

  @override
  State<ReactionButtonGroup> createState() => _ReactionButtonGroupState();
}

class _ReactionButtonGroupState extends State<ReactionButtonGroup> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          spacing: 10,
          children: [
            Expanded(
              child: OutlinedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.thumb_up,
                      color: widget.post.isLiked ?? false
                          ? Colors.blue
                          : Colors.grey,
                      size: 24,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '${widget.post.reactionCount ?? 0}',
                      style: TextStyle(
                        color: widget.post.isLiked ?? false
                            ? Colors.blue
                            : Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  setState(() {
                    widget.post.isLiked = !(widget.post.isLiked ?? false);
                    if (widget.post.isLiked!) {
                      widget.post.reactionCount =
                          (widget.post.reactionCount ?? 0) + 1;
                    } else {
                      widget.post.reactionCount =
                          (widget.post.reactionCount ?? 0) - 1;
                    }
                  });
                  widget.onLike(widget.post.isLiked!);
                },
              ),
            ),
            Expanded(
              child: OutlinedButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.comment,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 5),
                      Text('${widget.post.commentCount ?? 0}'),
                    ],
                  )),
            ),
            Expanded(
              child: OutlinedButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.bookmark_border,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 5),
                      Text('${widget.post.shareCount ?? 0}'),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
