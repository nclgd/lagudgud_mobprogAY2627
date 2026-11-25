import 'package:flutter/material.dart';
import '../widgets/newsfeed_card.dart';

// The newsfeed: a list of two posts.
// TODO: Post 1 is YOUR post. Replace 'Your Name' with your own name
// and write your own post text.
// TODO: Post 2 is by a CLASSMATE you pick. Replace "Classmate's Name"
// with their name and write their post text.

class Post {
  Post({
    required this.authorName,
    required this.date,
    required this.text,
    required this.likes,
    this.imageAsset,
    this.avatarAsset = 'assets/images/nicole.jpg',
  });

  final String authorName;
  final String date;
  final String text;
  int likes;
  final String? imageAsset;
  final String avatarAsset;
}

class NewsFeedScreen extends StatefulWidget {
  const NewsFeedScreen({super.key});

  @override
  State<NewsFeedScreen> createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {
  final List<Post> _posts = [
    Post(
      authorName: 'Nessy Lagudgud',
      date: 'November 23',
      text: 'When nothing goes right, go left.',
      likes: 100,
      avatarAsset: 'assets/images/nicole.jpg',
    ),
    Post(
      authorName: "Alex Alejandro",
      date: 'November 26',
      text: 'Listening to Olivia Rodrigo\'s latest album lately.',
      likes: 200,
      avatarAsset: 'assets/images/sen.jpg',
      imageAsset: 'assets/images/olivia.jpg',
    ),
  ];

  void _likePost(int index) {
    setState(() {
      _posts[index].likes += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _posts.length,
      itemBuilder: (context, index) {
        final post = _posts[index];
        return NewsFeedCard(
          authorName: post.authorName,
          date: post.date,
          text: post.text,
          likes: post.likes,
          imageAsset: post.imageAsset,
          avatarAsset: post.avatarAsset,
          onLike: () => _likePost(index),
        );
      },
    );
  }
}