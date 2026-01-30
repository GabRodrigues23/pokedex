import 'package:flutter/material.dart';

enum PokemonType {
  normal(Colors.grey),
  fire(Colors.redAccent),
  water(Colors.blueAccent),
  grass(Colors.green),
  electric(Colors.yellow),
  ice(Colors.cyan),
  fighting(Colors.orange),
  poison(Colors.deepPurple),
  ground(Colors.brown),
  flying(Colors.lightBlue),
  psychic(Colors.purpleAccent),
  bug(Colors.lightGreen),
  rock(Colors.grey),
  ghost(Colors.indigo),
  dragon(Colors.indigoAccent),
  dark(Colors.black87),
  steel(Colors.blueGrey),
  fairy(Colors.pinkAccent),
  unknown(Color(0xFF949494));

  final Color color;
  const PokemonType(this.color);
}
