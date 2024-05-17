import 'package:flutter/material.dart';
import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/presentation/screens/post_screen.dart';
import 'package:lexa/presentation/views/circular_icon_button.dart';
import 'package:lexa/presentation/views/circular_avatar.dart';
import 'package:lexa/presentation/views/segment_header.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PostRecommendSegment extends StatefulWidget {
  const PostRecommendSegment({super.key});

  @override
  State<PostRecommendSegment> createState() => _PostRecommendSegmentState();
}

class _PostRecommendSegmentState extends State<PostRecommendSegment> {
  final PageController _screenController =
      PageController(viewportFraction: 0.85);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(15),
          child: SegmentHeader(heading: "Other people Activities"),
        ),
        Container(
          color: const Color.fromARGB(255, 250, 250, 250),
          height: 210,
          child: PageView.builder(
            controller: _screenController,
            itemBuilder: (context, index) {
              return _buildPostItem();
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SmoothPageIndicator(
            controller: _screenController,
            count: 3,
            textDirection: TextDirection.ltr,
            effect: ExpandingDotsEffect(
              dotWidth: 5,
              dotHeight: 5,
              activeDotColor: ColorConstants.primary,
              expansionFactor: 2,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _screenController.dispose();
    super.dispose();
  }

  Widget _buildPostItem() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const PostPage(),
          ),
        );
      },
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 10,
          ),
          decoration: BoxDecoration(
            color: ColorConstants.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey[300]!,
              width: 1,
            ),
          ),
          child: Center(
            child: Column(
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularAvatar(
                            imageUrl: "",
                            size: 30,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Nguyen dep trai",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "22h",
                      style: TextStyle(
                        color: ColorConstants.primaryGray,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "I was created new topic. Let's try it to improve vocabulary",
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: ColorConstants.primaryGray,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        "assets/images/user.jpg",
                        width: 50,
                        height: 50,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 30,
                      child: CircularIconButton(
                        iconPath: "assets/icons/heart_regular_icon.svg",
                        size: 30,
                        elevation: 0,
                        iconSize: 17,
                        onTap: () {},
                      ),
                    ),
                    SizedBox(
                      width: 30,
                      child: CircularIconButton(
                        iconPath: "assets/icons/comment_icon.svg",
                        size: 30,
                        elevation: 0,
                        iconSize: 16,
                        onTap: () {},
                      ),
                    ),
                    SizedBox(
                      width: 30,
                      child: CircularIconButton(
                        iconPath: "assets/icons/share_icon.svg",
                        size: 30,
                        elevation: 0,
                        iconSize: 16,
                        onTap: () {},
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
