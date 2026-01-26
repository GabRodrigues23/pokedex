import 'package:flutter/material.dart';
import 'package:pokedex/app/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex/app/features/pokemon/domain/usecases/get_pokemon_list.dart';

class PokemonListViewModel extends ChangeNotifier {
  final GetPokemonList getPokemonList;
  PokemonListViewModel(this.getPokemonList);

  List<Pokemon> pokemons = [];
  bool isLoading = false;
  String errorMessage = '';

  Future<void> load() async {
    isLoading = true;
    notifyListeners();

    try {
      pokemons = await getPokemonList();
    } catch (e) {
      errorMessage = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
