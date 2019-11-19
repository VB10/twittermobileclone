import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String _githubPhotoUrl =
      "https://avatars0.githubusercontent.com/u/17102578?s=460&v=4";
  int defaultTabLength = 4;
  String _randomImage = "https://picsum.photos/200/300";
  String dummyTweet =
      "A group of physicians has volunteered to vaccinate migrants against the flu for free, but US Customs and Border Protection is all but certain to say no to the offer. \"We haven't responded, but it's not likely to happen,\" a CBP official told CNN.";
  bool isHeaderClose = false;
  double lastOffset = 0;
  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();

    scrollController.addListener(() {
      print(scrollController.offset);
      if (scrollController.offset <= 0) {
        isHeaderClose = false;
      } else if (scrollController.offset >=
          scrollController.position.maxScrollExtent) {
        isHeaderClose = true;
      } else {
        isHeaderClose = scrollController.offset > lastOffset ? true : false;
      }

      setState(() {
        lastOffset = scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _fabButton,
      body: SafeArea(
        child: DefaultTabController(
          length: defaultTabLength,
          child: Column(
            children: <Widget>[
              _containerAppbar,
              _tabbarItems,
              _expandedListView
            ],
          ),
        ),
      ),
    );
  }

  Widget get _fabButton => FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.adb),
      );

  Widget get _containerAppbar => AnimatedContainer(
        duration: Duration(milliseconds: 500),
        height: isHeaderClose ? 0 : 50,
        child: _appBar,
      );

  Widget get _appBar => AppBar(
        elevation: 0,
        centerTitle: false,
        title: _appBarItems,
      );

  Widget get _appBarItems => Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 10,
        children: <Widget>[
          CircleAvatar(backgroundImage: NetworkImage(_githubPhotoUrl)),
          Text("Home", style: titleTextStyle)
        ],
      );

  Widget get _tabbarItems => TabBar(
        tabs: <Widget>[
          Tab(
              icon: Icon(
            Icons.dashboard,
          )),
          Tab(icon: Icon(Icons.radio)),
          Tab(icon: Icon(Icons.satellite)),
          Tab(icon: Icon(Icons.verified_user)),
        ],
      );

  Widget get _expandedListView => Expanded(
        child: _listView,
      );

  Widget get _listView => ListView.builder(
        itemCount: 10,
        controller: scrollController,
        itemBuilder: (context, index) {
          return _listViewCard;
        },
      );

  Widget get _listViewCard => Card(
        child: ListTile(
          leading: CircleAvatar(backgroundImage: NetworkImage(_randomImage)),
          title: Wrap(
            direction: Axis.horizontal,
            runSpacing: 5,
            children: <Widget>[
              _listCardTitle("Hello"),
              Text(dummyTweet),
              _placeHolderField,
              _footerButtonRow
            ],
          ),
        ),
      );

  Widget _listCardTitle(String text) => Text(
        text,
        style: titleTextStyle,
      );

  Widget get _placeHolderField => Container(
        height: 100,
        child: Placeholder(),
      );

  Widget get _footerButtonRow => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _iconLabelButton,
          _iconLabelButton,
          _iconLabelButton,
          _iconLabelButton,
        ],
      );

  Widget _iconLabel(String text) => Wrap(
        spacing: 5,
        children: <Widget>[
          Icon(
            Icons.comment,
            color: CupertinoColors.inactiveGray,
          ),
          Text(text)
        ],
      );

  Widget get _iconLabelButton => InkWell(
        child: _iconLabel("1"),
        onTap: () {},
      );
}

final titleTextStyle = TextStyle(
    letterSpacing: 1,
    fontSize: 20,
    fontWeight: FontWeight.w800,
    color: Colors.black);
