import 'package:flutter/material.dart';
import 'package:pokedex/app/features/pokemon/model/entities/pokemon.dart';
import 'package:pokedex/app/features/pokemon/viewmodels/pokemon_details_view_model.dart';
import 'package:pokedex/app/setup/setup_get_it_injector.dart';
import 'package:pokedex/shared/extensions/formatter_string_extension.dart';

class PokemonDetailsModal extends StatefulWidget {
  final List<Pokemon> pokemons;
  final int initialIndex;
  const PokemonDetailsModal({
    super.key,
    required this.pokemons,
    required this.initialIndex,
  });

  @override
  State<PokemonDetailsModal> createState() => _PokemonDetailsModalState();
}

class _PokemonDetailsModalState extends State<PokemonDetailsModal> {
  late final PokemonDetailsViewModel viewModel;
  late int currentIndex;
  Pokemon get currentPokemon => widget.pokemons[currentIndex];

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    viewModel = getIt<PokemonDetailsViewModel>();
    viewModel.loadDetails(currentPokemon.id);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (_, __) {
        if (viewModel.isLoading)
          return const Center(child: CircularProgressIndicator());
        if (viewModel.details == null)
          return const Center(child: Text('Erro ao carregar detalhes.'));

        final details = viewModel.details!;

        return Center(
          child: Material(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            child: Container(
              padding: const EdgeInsets.all(20),
              width: 300,
              height: 500,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    details.type.first.color.withAlpha(80),
                    Colors.white,
                  ],
                  begin: AlignmentGeometry.topCenter,
                  end: AlignmentGeometry.center,
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _led(Colors.red),
                              _led(Colors.yellow),
                              _led(Colors.green),
                            ],
                          ),
                          SizedBox(height: 4),

                          Text(
                            '${details.id} - ${details.name.captalize()}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: details.type.first.color.withAlpha(50),
                                  blurRadius: 20,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: SizedBox(
                              height: 120,
                              width: 120,
                              child: Image.network(
                                details.pokemonGif,
                                fit: BoxFit.contain,
                                filterQuality: FilterQuality.none,
                                errorBuilder: (_, __, ___) => Image.network(
                                  widget.pokemons[currentIndex].imageUrl,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 4,
                            runSpacing: 4,
                            children: details.type
                                .map(
                                  (type) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 2,
                                    ),
                                    child: Chip(
                                      label: Text(type.name.captalize()),
                                      backgroundColor: type.color.withAlpha(20),
                                      side: BorderSide(color: type.color),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                          SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              details.description,
                              textAlign: TextAlign.justify,
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _statCard('Height: ', details.height),
                              _statCard('Weight: ', details.weight),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      currentIndex > 0
                          ? Column(
                              children: [
                                IconButton(
                                  onPressed: () => _goTo(currentIndex - 1),
                                  icon: const Icon(
                                    Icons.navigate_before_rounded,
                                  ),
                                  style: IconButton.styleFrom(
                                    backgroundColor: Colors.black12,
                                  ),
                                ),
                                Image.network(
                                  widget.pokemons[currentIndex - 1].imageUrl,
                                  width: 40,
                                  height: 40,
                                ),
                              ],
                            )
                          : const SizedBox(width: 48),

                      currentIndex < widget.pokemons.length - 1
                          ? Column(
                              children: [
                                IconButton(
                                  onPressed: () => _goTo(currentIndex + 1),
                                  icon: const Icon(Icons.navigate_next_rounded),
                                  style: IconButton.styleFrom(
                                    backgroundColor: Colors.black12,
                                  ),
                                ),
                                Image.network(
                                  widget.pokemons[currentIndex + 1].imageUrl,
                                  width: 40,
                                  height: 40,
                                ),
                              ],
                            )
                          : const SizedBox(width: 48),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _led(Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: color.withAlpha(80), blurRadius: 6)],
      ),
    );
  }

  Widget _statCard(String label, double value) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey)),
        Text(
          '$value',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  void _goTo(int newIndex) {
    if (newIndex < 0 || newIndex >= widget.pokemons.length) return;
    setState(() {
      currentIndex = newIndex;
    });
    viewModel.loadDetails(currentPokemon.id);
  }
}
