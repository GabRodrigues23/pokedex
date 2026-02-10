import 'package:flutter/material.dart';
import 'package:pokedex/app/features/pokemon/model/entities/pokemon_details.dart';
import 'package:pokedex/app/features/pokemon/model/interface/pokemon_repository_interface.dart';

class PokemonDetailsViewModel extends ChangeNotifier {
  final PokemonRepositoryInterface repository;

  PokemonDetailsViewModel(this.repository);

  PokemonDetails? details;
  bool isLoading = false;
  String? errorMessage;

  Future<void> loadDetails(int id) async {
    isLoading = true;
    notifyListeners();

    try {
      details = await repository.fetchPokemonDetails(id);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
