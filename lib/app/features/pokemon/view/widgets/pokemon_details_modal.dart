import 'package:flutter/material.dart';

class PokemonDetailsModal extends StatelessWidget {
  const PokemonDetailsModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        width: 300,
        height: 500,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('ID - Nome Pokemon'),
              SizedBox(height: 15),
              Image.asset('assets/images/pikachu_pokemons_not_found.png'),
              Material(
                type: MaterialType.transparency,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 4,
                  children: [
                    Chip(label: Text('Type 1')),
                    Chip(label: Text('Type 2')),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Description: Lorem ipsum dolor sit amet consectetur adipiscing elit.\nQuisque faucibus ex sapien vitae pellentesque sem placerat.',
                  textAlign: TextAlign.justify,
                ),
              ),

              Text('Height: ?'),
              Text('Weight: ?'),

              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.navigate_before_rounded),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.navigate_next_rounded),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
