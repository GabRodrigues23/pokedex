import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pokedex/app/features/pokemon/view/widgets/pokemon_details_widget/pokemon_details_modal.dart';
import 'package:pokedex/app/features/pokemon/view/widgets/pokemon_grid_panel_widget/pokemon_grid_panel_widget.dart';
import 'package:pokedex/app/features/pokemon/viewmodels/pokemon_list_view_model.dart';
import 'package:pokedex/app/features/pokemon/view/widgets/filter_bar_widget/filter_bar_widget.dart';

class PokemonListPage extends StatefulWidget {
  final PokemonListViewModel viewModel;
  const PokemonListPage({super.key, required this.viewModel});

  @override
  State<PokemonListPage> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'POKEDEX',
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF3B3B3B),
      ),
      backgroundColor: const Color(0xFF3B3B3B),
      body: ListenableBuilder(
        listenable: widget.viewModel,
        builder: (context, _) {
          if (widget.viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (widget.viewModel.errorMessage != null) {
            return Center(
              child: Text(
                widget.viewModel.errorMessage!,
                style: const TextStyle(color: Colors.redAccent),
                textAlign: TextAlign.center,
              ),
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 12,
            children: [
              SearchBarWidget(
                currentTypeFilter: widget.viewModel.typeFilter,
                onTypeFilterChanged: (newTypeFilter) {
                  widget.viewModel.setTypeFilter(newTypeFilter);
                },
                onSearchQueryChanged: (query) {
                  widget.viewModel.setSearchQuery(query);
                },
              ),
              Expanded(
                child: PokemonGridPanelWidget(
                  viewModel: widget.viewModel,
                  onPokemonTap: (pokemon) {
                    final index = widget.viewModel.filteredPokemons.indexOf(
                      pokemon,
                    );
                    showGeneralDialog(
                      context: context,
                      barrierDismissible: true,
                      barrierLabel: '',
                      transitionDuration: const Duration(milliseconds: 200),
                      pageBuilder: (_, __, ___) => Stack(
                        children: [
                          BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                            child: Container(color: Colors.black26),
                          ),
                          PokemonDetailsModal(
                            pokemons: widget.viewModel.filteredPokemons,
                            initialIndex: index,
                          ),
                        ],
                      ),
                      transitionBuilder: (_, animation, __, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: ScaleTransition(
                            scale: Tween(
                              begin: 0.9,
                              end: 1.0,
                            ).animate(animation),
                            child: child,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
