import 'package:flutter/material.dart';
import 'package:pokedex/app/features/pokemon/ui/viewmodels/pokemon_list_view_model.dart';

class PokemonListPage extends StatefulWidget {
  final PokemonListViewModel viewModel;
  const PokemonListPage({super.key, required this.viewModel});

  @override
  State<PokemonListPage> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
