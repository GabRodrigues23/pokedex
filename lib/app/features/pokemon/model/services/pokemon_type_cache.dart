import 'dart:async';
import 'dart:convert';

import 'package:pokedex/shared/enums/pokemon_type.dart';
import 'package:pokedex/shared/extensions/pokemon_type_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PokemonTypeCache {
  static const _prefsKeyType = 'pokemon_types_cache';

  final Map<int, PokemonType> _cache = {};
  bool _loaded = false;
  Timer? _saveDebounce;

  Future<void> load() async {
    if (_loaded) return;

    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_prefsKeyType);

    if (raw != null && raw.isNotEmpty) {
      final Map<String, dynamic> map = jsonDecode(raw);
      for (final entry in map.entries) {
        final id = int.tryParse(entry.key);
        final typeName = entry.value as String?;
        if (id != null && typeName != null) {
          _cache[id] = typeName.toPokemonType();
        }
      }
    }
    _loaded = true;
  }

  PokemonType? get(int id) => _cache[id];

  void set(int id, PokemonType type) {
    _cache[id] = type;
    _scheduleSave();
  }

  bool contains(int id) => _cache.containsKey(id);
  Map<int, PokemonType> getAll() => Map.unmodifiable(_cache);

  void _scheduleSave() {
    _saveDebounce?.cancel();
    _saveDebounce = Timer(const Duration(milliseconds: 800), () async {
      final prefs = await SharedPreferences.getInstance();

      final encoded = jsonEncode(
        _cache.map((id, type) => MapEntry(id.toString(), type.name)),
      );

      await prefs.setString(_prefsKeyType, encoded);
    });
  }
}
