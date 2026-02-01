import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:pokedex/app/features/pokemon/model/entities/pokemon.dart';
import 'package:pokedex/app/features/pokemon/model/interface/pokemon_repository_interface.dart';
import 'package:pokedex/app/setup/pokemon_list_query_defaults.dart';

class PokemonListViewModel extends ChangeNotifier {
  final PokemonRepositoryInterface repository;
  final PokemonListQueryDefaults defaults;

  PokemonListViewModel(this.repository, this.defaults);

  List<Pokemon> pokemons = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> load() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      pokemons = await repository.fetchPokemonList(
        limit: defaults.limit,
        offset: defaults.offset,
      );
    } catch (e) {
      errorMessage = e.toString();
      pokemons = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> preloadAll({
    void Function(int done, int total)? onProgress,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final list = await repository.fetchPokemonList(
        limit: defaults.limit,
        offset: defaults.offset,
      );

      pokemons = await repository.hydrateTypesForList(
        list,
        batchSize: 60,
        onProgress: onProgress,
      );
    } catch (e) {
      errorMessage = e.toString();
      pokemons = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> hydrateAll({void Function(int, int)? onProgress}) async {
    pokemons = await repository.hydrateTypesForList(
      pokemons,
      batchSize: 60,
      onProgress: onProgress,
    );
    notifyListeners();
  }
}
