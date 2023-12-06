import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_jus_168/features/search/presentation/bloc/search_bloc.dart';
import 'package:fruit_jus_168/features/search/presentation/widgets/typing_search_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Timer? _debounce;
  List _allResult = [];
  bool _searching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String queryText) {
    setState(() {
      _searching = true;
    });
    // decounce to slow down the request
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 750), () {
      BlocProvider.of<SearchBloc>(context).add(SearchRequested(queryText));
      setState(() {
        _searching = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TypingSearchBar(
                onSearchChanged: _onSearchChanged,
                searching: _searching,
              ),
              BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return const Expanded(
                        child: Center(child: CircularProgressIndicator()));
                  } else if (state is SearchLoaded) {
                    _allResult = state.searchResult;
                    if (_allResult.isEmpty) {
                      return const Expanded(
                          child: Center(child: Text("No Result")));
                    }
                    return Expanded(
                      child: ListView.builder(
                        itemCount: _allResult.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(_allResult[index].name),
                          );
                        },
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
