import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

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
      child: SizedBox(
        width: 400,
        height: 40,
        child: TextField(
          controller: _controller,
          // onChanged: widget.onSearchChanged,
          decoration: InputDecoration(
            hintText: 'Buscar',
            prefixIcon: const Icon(Icons.search, size: 20, color: Colors.grey),
            suffixIcon: IconButton(
              onPressed: () {
                // _controller.clear();
                // widget.onSearchChanged;
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
    );
  }
}
