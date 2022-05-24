import 'package:flutter/material.dart';
import 'package:privatechat/controllers/themeNotifier.dart';
import 'package:provider/provider.dart';

import 'empty_content.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class ListItemsBuilder<T> extends StatelessWidget {
  const ListItemsBuilder(
      {Key? key,
      required this.snapshot,
      required this.itemBuilder,
      required this.controller})
      : super(key: key);
  final AsyncSnapshot<List> snapshot;
  final ItemWidgetBuilder<T> itemBuilder;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasData) {
      final List items = snapshot.data!;
      if (items.isNotEmpty) {
        return _buildList(items);
      } else {
        return const EmptyContent();
      }
    } else if (snapshot.hasError) {
      return const EmptyContent(
        title: 'Something went wrong',
        message: 'Can\'t load content right now',
      );
    }
    return Center(
      child: CircularProgressIndicator(
        color: Provider.of<ThemeNotifier>(context).darkTheme
            ? Colors.white
            : Colors.black,
      ),
    );
  }

  Widget _buildList(items) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        controller: controller,
        itemCount: items.length,
        itemBuilder: (context, index) => itemBuilder(context, items[index]));
  }
}
