// ignore_for_file: public_member_api_docs, sort_constructors_first
class MarketSearch {
  final String name;
  final String fullName;
  MarketSearch({
    required this.name,
    required this.fullName,
  });
}

List<MarketSearch> searches = [
  MarketSearch(name: 'EUR/USD', fullName: 'Euro/US Dollar'),
  MarketSearch(name: 'EUR/JPY', fullName: 'Euro/Japanese Yen'),
];
