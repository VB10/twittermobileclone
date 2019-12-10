class Trend {
  String location;
  String hashtag;
  String tweets;

  Trend({this.location, this.hashtag, this.tweets});

  Trend.fromJson(Map<String, dynamic> json) {
    location = json['location'];
    hashtag = json['hashtag'];
    tweets = json['tweets'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['location'] = this.location;
    data['hashtag'] = this.hashtag;
    data['tweets'] = this.tweets;
    return data;
  }
}
