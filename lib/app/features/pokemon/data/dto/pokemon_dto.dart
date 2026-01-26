class PokemonDto {
  final String name;
  final String url;

  const PokemonDto({required this.name, required this.url});

  factory PokemonDto.fromJson(Map<String, dynamic> json) {
    return PokemonDto(name: json['name'], url: json['url']);
  }
}
