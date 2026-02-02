import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pokedex/app/features/pokemon/model/entities/pokemon.dart';
import 'package:pokedex/app/features/pokemon/model/interface/pokemon_repository_interface.dart';
import 'package:pokedex/app/setup/pokemon_list_query_defaults.dart';
import 'package:pokedex/shared/enums/pokemon_type.dart';

class PokemonListViewModel extends ChangeNotifier {
  final PokemonRepositoryInterface repository;
  final PokemonListQueryDefaults defaults;

  PokemonListViewModel(this.repository, this.defaults);

  List<Pokemon> _allPokemons = [];

  bool isLoading = false;
  String? errorMessage;

  String _searchQuery = '';
  PokemonType? _typeFilter;

  List<Pokemon> get pokemons => _allPokemons;
  String get searchQuery => _searchQuery;
  PokemonType? get typeFilter => _typeFilter;

  List<Pokemon> get filteredPokemons {
    final query = _searchQuery.toUpperCase().trim();

    return _allPokemons.where((pokemon) {
      if (_typeFilter != null && pokemon.type != _typeFilter) return false;
      if (query.isEmpty) return true;
      if (int.tryParse(query) != null) return pokemon.id.toString() == query;

      return pokemon.name.toUpperCase().contains(query);
    }).toList();
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

      _allPokemons = await repository.hydrateTypesForList(
        list,
        batchSize: 60,
        onProgress: onProgress,
      );
    } catch (e) {
      errorMessage = e.toString();
      _allPokemons = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> hydrateAll({void Function(int, int)? onProgress}) async {
    _allPokemons = await repository.hydrateTypesForList(
      _allPokemons,
      batchSize: 60,
      onProgress: onProgress,
    );
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setTypeFilter(PokemonType? type) {
    _typeFilter = type;
    notifyListeners();
  }

  void clearFilter() {
    _searchQuery = '';
    _typeFilter = null;
    notifyListeners();
  }
}
