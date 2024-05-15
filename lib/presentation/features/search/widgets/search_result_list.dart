import 'package:flutter/cupertino.dart';
import 'package:lexa/core/commons/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lexa/presentation/features/search/widgets/search_result_item.dart';

class SearchResultList extends StatefulWidget {
  final bool isDisplay;
  final bool loading;
  final List<dynamic> results;

  const SearchResultList({
    super.key,
    required this.isDisplay,
    required this.results,
    required this.loading,
  });

  @override
  State<StatefulWidget> createState() => _SearchResultListState();
}

class _SearchResultListState extends State<SearchResultList> {
  @override
  Widget build(BuildContext context) {
    return widget.isDisplay
        ? Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Recent search",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                        overlayColor: MaterialStateProperty.all(Colors.transparent),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "SEE ALL",
                            style: TextStyle(
                              fontSize: 14,
                              color: ColorConstants.primaryBlue,
                            ),
                          ),
                          SvgPicture.asset(
                            "assets/icons/chervon_right_icon.svg",
                            color: ColorConstants.primaryBlue,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                widget.loading
                    ? const Padding(
                        padding: EdgeInsets.all(20),
                        child: CupertinoActivityIndicator(),
                      )
                    : Expanded(
                        child: ListView.separated(
                          itemCount: widget.results.length,
                          itemBuilder: (context, index) {
                            final data = widget.results[index];
                            return SearchResultItem(result: data);
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
