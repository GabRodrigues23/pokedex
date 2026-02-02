import 'package:flutter/material.dart';
import 'package:pokedex/shared/enums/pokemon_type.dart';

class SearchBarWidget extends StatefulWidget {
  final PokemonType? currentTypeFilter;
  final Function(PokemonType?) onTypeFilterChanged;
  final Function(String) onSearchQueryChanged;

  const SearchBarWidget({
    super.key,
    this.currentTypeFilter,
    required this.onTypeFilterChanged,
    required this.onSearchQueryChanged,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBarWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          SizedBox(
            width: 400,
            height: 40,
            child: TextField(
              controller: _controller,
              onChanged: widget.onSearchQueryChanged,
              decoration: InputDecoration(
                hintText: 'Buscar',
                prefixIcon: const Icon(
                  Icons.search,
                  size: 20,
                  color: Colors.grey,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    _controller.clear();
                    widget.onSearchQueryChanged('');
                  },
                  icon: Icon(Icons.clear, size: 20, color: Colors.red[300]),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                filled: true,
                fillColor: Colors.grey.shade50,
              ),
            ),
          ),
          SizedBox(height: 4),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...PokemonType.values
                    .where((type) => type != PokemonType.unknown)
                    .map((type) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: _buildChip(type, type.name, type.color),
                      );
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(PokemonType type, String label, Color color) {
    final isSelected = widget.currentTypeFilter == type;

    return FilterChip(
      label: Text(label),
      labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      backgroundColor: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(12),
        side: BorderSide(color: color),
      ),

      selected: isSelected,
      onSelected: (_) => widget.onTypeFilterChanged(isSelected ? null : type),

      showCheckmark: true,
      checkmarkColor: Colors.black,
    );
  }
}
