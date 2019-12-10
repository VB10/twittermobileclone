import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'tabbar_view.dart';

class HomeView extends StatefulWidget {
  HomeView(this.controller);

  final ScrollController controller;

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String _randomImage = "https://picsum.photos/200/300";
  String dummyTweet =
      "A group of physicians has volunteered to vaccinate migrants against the flu for free, but US Customs and Border Protection is all but certain to say no to the offer. \"We haven't responded, but it's not likely to happen,\" a CBP official told CNN.";
  bool isHeaderClose = false;
  double lastOffset = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _fabButton,
      body: _listView,
    );
  }

  Widget get _fabButton => FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.adb),
      );

  Widget get _listView => ListView.builder(
        itemCount: 10,
        controller: widget.controller,
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
