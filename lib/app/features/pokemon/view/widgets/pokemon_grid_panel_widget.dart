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
      child: viewModel.filteredPokemons.isEmpty
          ? _emptyPageWidget()
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150,
                childAspectRatio: 0.85,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemCount: viewModel.filteredPokemons.length,
              itemBuilder: (context, index) {
                final card = viewModel.filteredPokemons[index];
                return PokemonCardWidget(pokemon: card);
              },
            ),
    );
  }

  Widget _emptyPageWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Nenhum Pokémon encontrado com esse filtro!',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          Image.asset(
            'assets/images/pikachu_pokemons_not_found.png',
            height: 84,
            width: 90,
            filterQuality: FilterQuality.high,
          ),
        ],
      ),
    );
  }
}
