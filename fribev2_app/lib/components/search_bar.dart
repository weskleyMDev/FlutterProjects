import 'package:flutter/material.dart';
import 'package:fribev2_app/generated/l10n.dart';
import 'package:fribev2_app/stores/stock.store.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    required TextEditingController searchController,
    required StockStore stockStore,
  }) : _searchController = searchController, _stockStore = stockStore;

  final TextEditingController _searchController;
  final StockStore _stockStore;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        margin: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 8.0),
        child: TextField(
          key: const ValueKey('search_sale'),
          controller: _searchController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            label: Text(
              S.of(context).search,
              overflow: TextOverflow.ellipsis,
            ),
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (value) => _stockStore.searchQuery = value,
        ),
      ),
    );
  }
}