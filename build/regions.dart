import 'providers.dart';

class Regions {
  final String region;
  final String region_name;
  final String endpoint;
  final Providers provider;
  String protocol = "HTTP";

  Regions({
    required this.region_name,
    required this.region,
    required this.endpoint,
    required this.provider,
  });
}

List<Regions> listOfRegions = [
  Regions(
    region: "eu-west-3",
    region_name: "Europe (Paris)",
    endpoint: "rds.eu-west-3.amazonaws.com",
    provider: Providers.aws,
  ),
  Regions(
    region: "eu-west-2",
    region_name: "Europe (Spain)",
    endpoint: "rds.eu-south-2.amazonaws.com",
    provider: Providers.aws,
  ),
];
