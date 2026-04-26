import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_widgets/controller/mentor_post_controller.dart';
import 'package:flutter_widgets/screen/mentor_post_screen/add_post_screen.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MentorPostScreen extends StatelessWidget {
  final MentorPostController controller = Get.put(MentorPostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      body: GetBuilder<MentorPostController>(
        builder: (controller) {
          return RefreshIndicator(
            onRefresh: () async {
              await controller.fetchPosts();
            },
            color: const Color(0xFF6A11CB),
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
              slivers: [
                // Premium SliverAppBar
                SliverAppBar(
                  expandedHeight: 120.0,
                  floating: false,
                  pinned: true,
                  elevation: 0,
                  stretch: true,
                  backgroundColor: const Color(0xFF6A11CB),
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: const Text(
                      "Mentor Posts",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        fontFamily: 'Inter',
                      ),
                    ),
                    background: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                  ),
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 16),
                      ),
                    ),
                  ),
                ),

                // Content
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                  sliver: controller.isLoading && controller.posts.isEmpty
                      ? SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) => _buildShimmerCard(),
                            childCount: 4,
                          ),
                        )
                      : controller.posts.isEmpty
                          ? SliverFillRemaining(
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.post_add_rounded, size: 64, color: Colors.grey.shade300),
                                    const SizedBox(height: 16),
                                    Text(
                                      "No posts yet",
                                      style: TextStyle(color: Colors.grey.shade500, fontSize: 16, fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  final post = controller.posts[index];
                                  return _buildPostCard(post);
                                },
                                childCount: controller.posts.length,
                              ),
                            ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: SizedBox(
        width: 45,
        height: 45,
        child: FloatingActionButton(
          backgroundColor: const Color(0xFF6A11CB),
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          onPressed: () {
            Get.dialog(const AddPostDialog());
          },
          child: const Icon(Icons.add_rounded, color: Colors.white, size: 22),
        ),
      ),
    );
  }

  Widget _buildShimmerCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Shimmer
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(width: 34, height: 34, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(width: 80, height: 10, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4))),
                      ),
                      const SizedBox(height: 5),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(width: 50, height: 8, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4))),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Image Shimmer
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(width: double.infinity, height: 150, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12))),
            ),
          ),

          // Content Shimmer
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(width: 150, height: 12, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4))),
                ),
                const SizedBox(height: 10),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(width: double.infinity, height: 8, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4))),
                      const SizedBox(height: 5),
                      Container(width: double.infinity, height: 8, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4))),
                      const SizedBox(height: 5),
                      Container(width: 200, height: 8, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4))),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(width: 60, height: 20, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8))),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostCard(MentorPost post) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post Header (Mentor Info)
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Color(0xFF6A11CB), Color(0xFF2575FC)]),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Center(
                    child: Icon(Icons.person_rounded, color: Colors.white, size: 16),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Administrator",
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: Color(0xFF1F2937)),
                      ),
                      Text(
                        post.date,
                        style: TextStyle(fontSize: 10, color: Colors.grey.shade500, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                _buildActionMenu(post),
              ],
            ),
          ),

          // Post Content (Image or Video)
          if (post.type.toLowerCase() == 'video' && post.imageUrl.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: _YoutubeVideoPlayer(url: post.imageUrl, postId: post.id),
              ),
            )
          else if (post.imageUrl.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: post.imageUrl.contains("assets")
                    ? Image.asset(
                        post.imageUrl,
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        post.imageUrl,
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => _buildImageError(),
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            height: 150,
                            width: double.infinity,
                            color: Colors.grey.shade50,
                            child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                          );
                        },
                      ),
              ),
            ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1F2937),
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  post.content,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontFamily: 'Inter',
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3EFFF),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            post.type.toLowerCase() == "image" ? Icons.image_rounded : (post.type.toLowerCase() == "video" ? Icons.videocam_rounded : Icons.text_fields_rounded),
                            size: 12,
                            color: const Color(0xFF6A11CB),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            post.type.toUpperCase(),
                            style: const TextStyle(
                              color: Color(0xFF6A11CB),
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
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

  Widget _buildImageError() {
    return Container(
      height: 150,
      width: double.infinity,
      color: Colors.grey.shade100,
      child: Icon(Icons.broken_image_rounded, color: Colors.grey.shade300, size: 24),
    );
  }

  Widget _buildActionMenu(MentorPost post) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        shape: BoxShape.circle,
      ),
      child: PopupMenuButton<String>(
        padding: EdgeInsets.zero,
        icon: Icon(Icons.more_horiz_rounded, size: 20, color: Colors.grey.shade600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onSelected: (value) {
          if (value == 'edit') {
            Get.find<MentorPostController>().editPost(post);
          } else if (value == 'delete') {
            Get.find<MentorPostController>().deletePost(post.id);
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 'edit',
            child: Row(
              children: [
                Icon(Icons.edit_rounded, size: 18, color: Color(0xFF6A11CB)),
                SizedBox(width: 12),
                Text('Edit', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          const PopupMenuItem(
            value: 'delete',
            child: Row(
              children: [
                Icon(Icons.delete_outline_rounded, size: 18, color: Colors.redAccent),
                SizedBox(width: 12),
                Text('Delete', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.redAccent)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _YoutubeVideoPlayer extends StatefulWidget {
  final String url;
  final int postId;
  const _YoutubeVideoPlayer({required this.url, required this.postId});

  @override
  State<_YoutubeVideoPlayer> createState() => _YoutubeVideoPlayerState();
}

class _YoutubeVideoPlayerState extends State<_YoutubeVideoPlayer> {
  late YoutubePlayerController _controller;
  String? _videoId;
  final controller = Get.find<MentorPostController>();

  @override
  void initState() {
    super.initState();
    _videoId = YoutubePlayer.convertUrlToId(widget.url);
    _controller = YoutubePlayerController(
      initialVideoId: _videoId ?? "",
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(_onStateChange);
  }

  void _onStateChange() {
    if (_controller.value.isPlaying) {
      // If this video starts playing, notify the controller to pause others
      controller.onVideoStartedPlaying(widget.postId, _controller);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onStateChange);
    controller.onVideoDisposed(widget.postId);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_videoId == null) {
      return Container(
        height: 150,
        color: Colors.black12,
        child: const Center(child: Text("Invalid YouTube URL")),
      );
    }

    return VisibilityDetector(
      key: Key('video_${widget.postId}'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction < 0.5) {
          if (_controller.value.isPlaying) {
            _controller.pause();
          }
        }
      },
      child: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: const Color(0xFF6A11CB),
        progressColors: const ProgressBarColors(
          playedColor: Color(0xFF6A11CB),
          handleColor: Color(0xFF2575FC),
        ),
      ),
    );
  }
}
