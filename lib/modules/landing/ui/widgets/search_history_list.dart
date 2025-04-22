import 'package:flutter/material.dart';

class SearchHistoryList extends StatelessWidget {
  final List<String> history;
  final void Function(String) onSelect;
  final VoidCallback onClear;

  const SearchHistoryList({
    super.key,
    required this.history,
    required this.onSelect,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Historial de búsqueda',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextButton(onPressed: onClear, child: const Text('Limpiar')),
            ],
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.separated(
              itemCount: history.length,
              itemBuilder: (_, index) {
                final term = history[index];
                return ListTile(
                  leading: const Icon(Icons.history),
                  title: Text(term),
                  onTap: () => onSelect(term),
                );
              },
              separatorBuilder: (_, __) => const Divider(height: 1),
            ),
          ),
        ],
      ),
    );
  }
}
