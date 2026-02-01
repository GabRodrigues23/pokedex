import 'package:flutter/material.dart';
import 'package:pokedex/app/features/pokemon/view/widgets/pokemon_card_widget.dart';
import 'package:pokedex/app/features/pokemon/viewmodels/pokemon_list_view_model.dart';

class PokemonGridPanelWidget extends StatelessWidget {
  final PokemonListViewModel viewModel;
  const PokemonGridPanelWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1, color: Colors.blueGrey),
          right: BorderSide(width: 1, color: Colors.blueGrey),
        ),
      ),
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150,
          childAspectRatio: 0.85,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        ),
        itemCount: viewModel.pokemons.length,
        itemBuilder: (context, index) {
          final card = viewModel.pokemons[index];
          return PokemonCardWidget(pokemon: card);
        },
      ),
    );
  }
}
