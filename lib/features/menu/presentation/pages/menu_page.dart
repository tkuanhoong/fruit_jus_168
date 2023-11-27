import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  ScrollController _scrollController = ScrollController();
  bool isScrollingDown = false;

  void initState() {
    super.initState(); // Adjust the length according to your categories
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    setState(() {
      isScrollingDown = _scrollController.position.userScrollDirection ==
              ScrollDirection.reverse
          ? false
          : true;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double maxWidth = screenWidth;
    //return sliverappbar
    return Scaffold(
      appBar: isScrollingDown
          ? AppBar(
              backgroundColor: Colors.grey,
              title: Text('1st app bar'),
            )
          : AppBar(
              backgroundColor: Colors.grey,
              title: Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: SearchAnchor(
                  builder: (BuildContext context, SearchController controller) {
                    return SearchBar(
                      constraints: BoxConstraints.tight(Size(maxWidth, 40)),
                      controller: controller,
                      padding: const MaterialStatePropertyAll<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                      onTap: () {
                        controller.openView();
                      },
                      onChanged: (_) {
                        controller.openView();
                      },
                      leading: const Icon(Icons.search, color: Colors.black),
                    );
                  },
                  suggestionsBuilder: (
                    BuildContext context,
                    SearchController controller,
                  ) {
                    return List<ListTile>.generate(
                      5,
                      (int index) {
                        final String item = 'item $index';
                        return ListTile(title: Text(item), onTap: () {});
                      },
                    );
                  },
                ),
              ),
            ),
      body: Column(children: [
        Container(
          decoration: BoxDecoration(color: Colors.red),
          child: Row(children: [
            SizedBox(
              width: screenWidth * 0.2,
              height: MediaQuery.sizeOf(context).height - 151,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                ),
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    color: Colors.amber,
                    child: Text('data'),
                  );
                },
              ),
            ),
            SizedBox(
              width: screenWidth * 0.8,
              height: MediaQuery.sizeOf(context).height - 151,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    color: Colors.amber,
                    child: Text('data'),
                  );
                },
              ),
            ),
          ]),
        )
      ]),
    );
  }
}
