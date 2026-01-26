import 'package:dio/dio.dart';
import 'package:pokedex/app/features/pokemon/data/dto/pokemon_details.dto.dart';
import 'package:pokedex/app/features/pokemon/data/dto/pokemon_dto.dart';
import 'package:pokedex/core/constants/endpoints.dart';

class PokemonApiService {
  final Dio dio;
  PokemonApiService(this.dio);

  Future<List<PokemonDto>> fetchPokemonList({
    int limit = 151,
    int offset = 0,
  }) async {
    final res = await dio.get(
      ApiEndpoints.pokemon,
      queryParameters: {'limit': limit, 'offset': offset},
    );

    final results = (res.data['results'] as List);

    return results.map((e) => PokemonDto.fromJson(e)).toList();
  }

  Future<PokemonDetailsDto> fetchPokemonDetails(int id) async {
    final res = await dio.get('${ApiEndpoints.pokemon}/$id');
    return PokemonDetailsDto.fromJson(res.data as Map<String, dynamic>);
  }
}
