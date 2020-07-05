class Country{
  final String country;
  final int cases;
  final int deaths;
  final int recovered;
  final int active;
  final int todayCases;
  final int critical;
  final int todayDeaths;

  Country({this.country, this.cases, this.deaths, this.recovered, this.active, this.todayCases, this.critical, this.todayDeaths});

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    country: json['country'],
    cases: json['cases'],
    deaths: json['deaths'],
    recovered: json['recovered'],
    active: json['active'],
    todayCases: json['todayCases'],
    todayDeaths: json['todayDeaths'],
    critical: json['critical']
  );
}