class PokemonDetailsDto {
  final int id;
  final String name;
  final List<String> types;

  PokemonDetailsDto({
    required this.id,
    required this.name,
    required this.types,
  });

  factory PokemonDetailsDto.fromJson(Map<String, dynamic> json) {
    final typesList = (json['types'] as List)
        .map((t) => t['type']['name'] as String)
        .toList();

    return PokemonDetailsDto(
      id: json['id'],
      name: json['name'],
      types: typesList,
    );
  }
}
