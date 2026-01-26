import 'package:dio/dio.dart';
import 'package:pokedex/app/features/pokemon/data/services/pokemon_api_service.dart';
import 'package:pokedex/app/features/pokemon/data/mappers/pokemon_mapper.dart';
import 'package:pokedex/app/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex/app/features/pokemon/domain/entities/pokemon_details.dart';
import 'package:pokedex/app/features/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:pokedex/core/errors/error.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonApiService api;
  PokemonRepositoryImpl(this.api);

  @override
  Future<List<Pokemon>> fetchPokemonList({
    required int limit,
    required int offset,
  }) async {
    try {
      final dtos = await api.fetchPokemonList(limit: limit, offset: offset);
      return dtos.map(PokemonMapper.toEntity).toList();
    } on DioException catch (e) {
      throw NetworkError('Erro ao buscar pokémons: $e');
    }
  }

  @override
  Future<PokemonDetails> fetchPokemonDetails(int id) async {
    final dto = await api.fetchPokemonDetails(id);
    return PokemonMapper.toDetailsEntity(dto);
  }
}
