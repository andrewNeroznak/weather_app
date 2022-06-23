import 'package:flutter/material.dart';

class WeatherSearchDelegate extends SearchDelegate<String?> {
  final List<String> _data;

  WeatherSearchDelegate(this._data);

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<String> suggestions = _data.where(
      (city) => city.toLowerCase().contains(
            query.toLowerCase(),
          ),
    );

    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(
        height: 20,
      ),
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final item = suggestions.elementAt(index);
        return ListTile(
          title: Text(item),
          onTap: () {
            close(context, item);
          },
        );
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      if (query.isNotEmpty)
        IconButton(
          tooltip: 'Clear',
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        ),
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox.shrink();
  }
}
