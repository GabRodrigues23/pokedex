import 'package:flutter/material.dart';
import 'package:pokedex/app/features/pokemon/model/entities/pokemon.dart';

class PokemonCardWidget extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonCardWidget({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final typeColor = (pokemon.type).color;

    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: typeColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              offset: Offset(2, 4),
              color: Colors.black26,
              blurRadius: 4,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${pokemon.id}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                pokemon.name.toUpperCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12),
              ),
              const Spacer(),
              Center(
                child: Image.network(
                  pokemon.imageUrl,
                  height: 48,
                  width: 48,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.image_not_supported),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
