import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants.dart';
import 'custom_text.dart';

// One post in the newsfeed: avatar, name, date, post text,
// an optional image, and the like, comment, and share row.
// Enhancement 1: the image area uses the Image widget.
// Enhancement 2: the avatar uses a profile image.
// Enhancement 3: the like and comment buttons are widgets.

class NewsFeedCard extends StatelessWidget {
  const NewsFeedCard({
    super.key,
    required this.authorName,
    required this.date,
    required this.text,
    required this.likes,
    this.imageAsset,
    this.avatarAsset = 'assets/images/nicole.jpg',
    required this.onLike,
  });

  final String authorName;
  final String date;
  final String text;
  final int likes;
  final String? imageAsset;
  final String avatarAsset;
  final VoidCallback onLike;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
      color: AppColors.white,
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar, name, and date.
            Row(
              children: [
                // Enhancement 2: profile image avatar. Falls back to the
                // person icon if the image file cannot be loaded.
                CircleAvatar(
                  radius: 20.r,
                  backgroundColor: AppColors.lightGrey,
                  child: ClipOval(
                    child: Image.asset(
                      avatarAsset,
                      width: 40.r,
                      height: 40.r,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.person,
                          color: AppColors.grey,
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: authorName,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      text: date,
                      fontSize: 13,
                      color: AppColors.grey,
                    ),
                  ],
                ),
                const Spacer(),
                const Icon(Icons.more_horiz, color: AppColors.grey),
              ],
            ),
            SizedBox(height: 10.h),
            // Post text.
            CustomText(text: text),
            SizedBox(height: 10.h),
            // Enhancement 1: the Image widget shows the post image only
            // when imageAsset is not null. If the file is missing, a grey
            // placeholder shows.
            if (imageAsset != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.asset(
                  imageAsset!,
                  width: double.infinity,
                  height: 200.h,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 200.h,
                      color: AppColors.lightGrey,
                      alignment: Alignment.center,
                      child: const CustomText(
                        text: 'Post image',
                        color: AppColors.grey,
                      ),
                    );
                  },
                ),
              ),
            SizedBox(height: 10.h),
            // Likes, comments, and shares.
            Row(
              children: [
                const Icon(
                  Icons.thumb_up,
                  color: AppColors.facebookBlue,
                  size: 18,
                ),
                SizedBox(width: 4.w),
                CustomText(text: '$likes'),
                const Spacer(),
                const CustomText(
                  text: '42 Comments   5 Shares',
                  fontSize: 13,
                  color: AppColors.grey,
                ),
              ],
            ),
            const Divider(),
            // Enhancement 3: Like, Comment, and Share as widget-based
            // buttons (TextButton.icon), spaced evenly across the row.
            Row(
              children: [
                Expanded(
                  child: _ActionButton(
                    icon: Icons.thumb_up_outlined,
                    label: 'Like',
                    onTap: onLike,
                  ),
                ),
                Expanded(
                  child: _ActionButton(
                    icon: Icons.comment_outlined,
                    label: 'Comment',
                    onTap: () {},
                  ),
                ),
                Expanded(
                  child: _ActionButton(
                    icon: Icons.share_outlined,
                    label: 'Share',
                    onTap: () {},
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            // Write a comment field.
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: const CustomText(
                text: 'Write a comment...',
                color: AppColors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// A like, comment, or share button built from a TextButton widget.
class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: AppColors.grey,
        padding: EdgeInsets.symmetric(vertical: 8.h),
      ),
      icon: Icon(icon, size: 20),
      label: CustomText(text: label, color: AppColors.grey),
    );
  }
}