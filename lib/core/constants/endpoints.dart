class ApiEndpoints {
  static const String baseUrl = 'https://pokeapi.co/api/v2';
  static const String pokemon = '/pokemon';
  static String pokemonDetails(int id) => '$pokemon/$id';
  static String pokemonDescription(int id) => '/pokemon-species/$id';
}
