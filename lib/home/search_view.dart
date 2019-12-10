import 'package:flutter/material.dart';
import 'package:twitterclone/model/trend_model.dart';

class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  String trendsTitle = "Trends for you";
  int itemCount = 5;
  Trend trend;

  List<Widget> headerView = [];
  @override
  void initState() {
    super.initState();
    trend = Trend(
        hashtag: "#cukur",
        location: "Trending in Turkey",
        tweets: "9.844 Twets");
  }

  double headerCardWidgetHeight = 15;

  @override
  Widget build(BuildContext context) {
    print(headerCardWidgetHeight);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: RefreshIndicator(
          onRefresh: () {
            print("asdasd");
            headerView.clear();

            return Future.value(true);
          },
          notificationPredicate: (isIndicator) {
            // if (isIndicator.metrics.atEdge) {
            //   print("asd");
            //   setState(() {
            //     headerCardWidgetHeight =
            //         MediaQuery.of(context).size.height * .5;
            //   });
            // }
            headerView.clear();
            return true;
          },
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                headerCardWidget,
                trendsCardWidget,
                ListView.builder(
                  itemCount: 5,
                  shrinkWrap: true,
                  itemBuilder: (index, child) => Text("data"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get haxd => ListView.separated(
        key: UniqueKey(),
        shrinkWrap: true,
        separatorBuilder: (context, index) => Divider(),
        itemCount: itemCount + 2,
        itemBuilder: (context, index) =>
            index < 2 ? headerCardWidget : trendsListWidget(model: trend),
      );

  Widget trendsListWidget({@required Trend model}) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Wrap(
              direction: Axis.vertical,
              spacing: 10,
              children: <Widget>[
                Text(model.location),
                Text(model.hashtag,
                    style: Theme.of(context)
                        .textTheme
                        .headline
                        .copyWith(fontSize: 15)),
                Text(model.tweets),
              ],
            ),
          ),
          Icon(Icons.arrow_drop_down)
        ],
      );

  Widget get trendsCardWidget => cardWidget(
      Text(
        trendsTitle,
        style: Theme.of(context).textTheme.headline,
      ),
      height: MediaQuery.of(context).size.height * .05);

  Widget get headerCardWidget =>
      cardWidget(_headerChild, height: headerCardWidgetHeight);

  Widget cardWidget(Widget child, {@required double height, double margin}) =>
      AnimatedContainer(
        duration: Duration(milliseconds: 500),
        height: height,
        child: child,
      );

  Widget get _headerChild => Icon(
        Icons.arrow_downward,
        color: Colors.grey,
      );
}
