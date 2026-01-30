import 'package:dio/dio.dart';
import 'package:pokedex/app/features/pokemon/model/dto/pokemon_dto.dart';
import 'package:pokedex/app/setup/pokemon_list_query_defaults.dart';
import 'package:pokedex/core/constants/endpoints.dart';

class PokemonApiService {
  final Dio dio;
  final PokemonListQueryDefaults defaults;
  PokemonApiService(this.dio, this.defaults);

  Future<List<PokemonDto>> fetchPokemonList({int? limit, int? offset}) async {
    final res = await dio.get(
      ApiEndpoints.pokemon,
      queryParameters: {'limit': defaults.limit, 'offset': defaults.offset},
    );

    final results = (res.data['results'] as List);

    return results.map((e) => PokemonDto.fromJson(e)).toList();
  }
}
