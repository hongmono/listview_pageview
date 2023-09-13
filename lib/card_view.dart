import 'package:flutter/material.dart';

enum CardViewType { list, pageView }

class CardView extends StatefulWidget {
  const CardView({
    super.key,
    required this.children,
    required this.expandedChildren,
    this.space = 8,
    this.padding = EdgeInsets.zero,
    this.duration = const Duration(milliseconds: 300),
  }) : assert(children.length == expandedChildren.length);

  final List<Widget> children;
  final List<Widget> expandedChildren;
  final double space;
  final EdgeInsets padding;
  final Duration duration;

  @override
  State<CardView> createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  late final PageController pageController;
  CardViewType cardViewType = CardViewType.list;
  int? selectedIndex;

  @override
  void initState() {
    super.initState();

    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return IndexedStack(
        index: cardViewType.index,
        children: [
          Padding(
            padding: widget.padding,
            child: _buildListArea(constraints),
          ),
          _buildPageViewArea(constraints),
        ],
      );
    });
  }

  Widget _buildListArea(BoxConstraints constraints) {
    final listComponentHeight = (constraints.maxHeight - widget.padding.vertical - (widget.space) * (widget.children.length - 1)) / widget.children.length;

    return Stack(
      children: List.generate(
        widget.children.length,
        (index) => AnimatedPositioned(
          duration: widget.duration,
          top: selectedIndex == index ? 0 : index * listComponentHeight + widget.space * index,
          left: 0,
          right: 0,
          height: selectedIndex == index ? constraints.maxHeight - widget.padding.vertical : listComponentHeight,
          onEnd: () {
            setState(() {
              if (selectedIndex == index) {
                cardViewType = CardViewType.pageView;
              }
            });
          },
          child: AnimatedOpacity(
            opacity: selectedIndex == null
                ? 1
                : selectedIndex == index
                    ? 1
                    : 0,
            duration: widget.duration,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (selectedIndex == null) {
                    selectedIndex = index;
                    pageController.jumpToPage(index);
                  } else {
                    selectedIndex = null;
                  }
                });
              },
              child: Stack(
                children: [
                  AnimatedOpacity(opacity: selectedIndex == null ? 1 : 0, duration: widget.duration, child: widget.children[index]),
                  AnimatedOpacity(opacity: selectedIndex == null ? 0 : 1, duration: widget.duration, child: widget.expandedChildren[index]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageViewArea(BoxConstraints constraints) {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        setState(() {
          selectedIndex = index;
        });
      },
      children: [
        ...List.generate(
          widget.expandedChildren.length,
          (index) => GestureDetector(
            onTap: () {
              setState(() {
                cardViewType = CardViewType.list;
                selectedIndex = null;
              });
            },
            child: Padding(
              padding: widget.padding,
              child: widget.expandedChildren[index],
            ),
          ),
        ),
      ],
    );
  }
}
