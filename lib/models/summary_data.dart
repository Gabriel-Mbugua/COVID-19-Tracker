class SummaryData {
  final int cases;
  final int deaths;
  final int recovered;

  SummaryData({this.cases, this.deaths, this.recovered});

  factory SummaryData.fromJson(Map<String, dynamic> json) => SummaryData(
      cases: json['cases'],
      deaths: json['deaths'],
      recovered: json['recovered']);
}
