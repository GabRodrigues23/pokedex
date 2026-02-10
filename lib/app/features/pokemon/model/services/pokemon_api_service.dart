import 'package:dio/dio.dart';
import 'package:pokedex/app/features/pokemon/model/dto/pokemon_dto.dart';
import 'package:pokedex/core/constants/endpoints.dart';

class PokemonApiService {
  final Dio dio;
  PokemonApiService(this.dio);

  Future<List<PokemonDto>> fetchPokemonList({
    required int limit,
    required int offset,
  }) async {
    final res = await dio.get(
      ApiEndpoints.pokemon,
      queryParameters: {'limit': limit, 'offset': offset},
    );

    final results = (res.data['results'] as List);
    return results.map((e) => PokemonDto.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>> fetchPokemonDetails(int id) async {
    final res = await dio.get(ApiEndpoints.pokemonDetails(id));
    return (res.data as Map<String, dynamic>);
  }

  Future<Map<String, dynamic>> fetchPokemonSpecies(int id) async {
    final res = await dio.get(ApiEndpoints.pokemonDescription(id));
    return (res.data as Map<String, dynamic>);
  }
}
