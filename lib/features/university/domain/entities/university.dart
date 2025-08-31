class University {
  final String id;
  final String name;
  final String location;
  final String type;
  final bool featured;
  final String imageUrl;
  final int? programsCount;
  final double? startingPrice;

  University({
    required this.id,
    required this.name,
    required this.location,
    required this.type,
    required this.featured,
    required this.imageUrl,
    this.programsCount,
    this.startingPrice,
  });
}
