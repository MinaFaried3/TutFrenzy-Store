import 'package:flutter/material.dart';
import 'package:frenzy_store/presentation/resources/strings_manager.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(AppStrings.search),
    );
  }
}
