import 'package:flutter/material.dart';
import 'package:twitterclone/custom/refresh2.dart';
import 'package:twitterclone/model/trend_topic.dart';

class SearchView extends StatefulWidget {
  SearchView(this.scrollController);
  final ScrollController scrollController;
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  double _padding = 20;
  TrendTopic _topic;
  bool isRefresh = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _topic = TrendTopic(
        hashtag: "#Champions League",
        location: "Trending in Turkey",
        tweets: "16.8K Tweets");
  }

  Future tempFuture() async {
    setState(() {
      isRefresh = !isRefresh;
    });
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      isRefresh = !isRefresh;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
      body: RefreshIndicator2(
        onRefresh: tempFuture,
        child: ListView(
          children: <Widget>[
            _downIconWidget,
            _emptySpace,
            _trendTitleWidget,
            _listHashView,
          ],
        ),
      ),
    );
  }

  Widget get _emptySpace => SizedBox(height: 10);

  Widget get _downIconWidget => AnimatedContainer(
        duration: Duration(milliseconds: 500),
        height: isRefresh ? 60 : 30,
        child: isRefresh
            ? Center(child: CircularProgressIndicator())
            : Icon(
                Icons.arrow_downward,
                color: Colors.grey,
              ),
      );

  Widget get _trendTitleWidget => Card(
        color: Theme.of(context).scaffoldBackgroundColor,
        margin: EdgeInsets.all(0),
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
            side: BorderSide(color: Colors.grey, width: 0.5)),
        child: Container(
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: _padding),
          alignment: Alignment.centerLeft,
          child: Text(
            "Trends for you",
            style: Theme.of(context).textTheme.headline,
          ),
        ),
      );

  Widget get _divider => Divider(
        height: 0,
        color: Colors.grey,
      );

  Widget get _listHashView => ListView.separated(
        itemCount: 5,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => _divider,
        itemBuilder: (context, index) => cardListMethod(context),
      );

  Card cardListMethod(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
          side: BorderSide(style: BorderStyle.none, color: Colors.transparent)),
      child: listPadding(context),
    );
  }

  Padding listPadding(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _padding, vertical: 5),
      child: row(context),
    );
  }

  Row row(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
            child: Wrap(
          direction: Axis.vertical,
          spacing: 5,
          children: <Widget>[
            Text(_topic.location, style: Theme.of(context).textTheme.caption),
            Text(_topic.hashtag,
                style: Theme.of(context)
                    .textTheme
                    .headline
                    .copyWith(fontSize: 15)),
            Text(
              _topic.tweets,
              style: Theme.of(context).textTheme.button,
            ),
          ],
        )),
        Icon(Icons.arrow_drop_down)
      ],
    );
  }
}
