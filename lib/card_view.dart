import 'package:flutter/material.dart';

enum CardViewType { list, pageView }

class CardView extends StatefulWidget {
  const CardView({
    super.key,
    required this.children,
    this.space,
  });

  final double? space;
  final List<Widget> children;

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
      final listComponentHeight = (constraints.maxHeight - (widget.space ?? 0) * (widget.children.length - 1)) / widget.children.length;

      return IndexedStack(
        index: cardViewType.index,
        children: [
          SizedBox(
            height: constraints.maxHeight,
            child: Stack(
              children: List.generate(
                5,
                (index) => AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  top: selectedIndex == index ? 0 : index * listComponentHeight + (widget.space ?? 0) * index,
                  left: 0,
                  right: 0,
                  height: selectedIndex == index ? constraints.maxHeight : listComponentHeight,
                  onEnd: () {
                    setState(() {
                      if (selectedIndex == index) {
                        cardViewType = CardViewType.pageView;
                      }
                    });
                  },
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
                    child: AnimatedOpacity(
                      opacity: selectedIndex == null
                          ? 1
                          : selectedIndex == index
                              ? 1
                              : 0,
                      duration: const Duration(milliseconds: 300),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(child: Text('$index')),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: constraints.maxHeight,
            child: PageView(
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              children: [
                ...List.generate(
                  5,
                  (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        cardViewType = CardViewType.list;
                        selectedIndex = null;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text('$index'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
