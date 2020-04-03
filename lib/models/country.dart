class Country{
  final String country;
  final int cases;
  final int deaths;
  final int recovered;

  Country({this.country, this.cases, this.deaths, this.recovered});

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    country: json['country'],
    cases: json['cases'],
    deaths: json['deaths'],
    recovered: json['recovered']
  );
}