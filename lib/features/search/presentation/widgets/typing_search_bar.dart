import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TypingSearchBar extends StatelessWidget {
  final Function(String)? onSearchChanged;
  final bool searching;
  const TypingSearchBar(
      {super.key, this.onSearchChanged, this.searching = false});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BackButton(
          onPressed: () => context.pop(),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: onSearchChanged,
                    autofocus: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      suffixIcon: searching
                          ? Container(
                              padding: const EdgeInsets.all(8.0),
                              height: 20,
                              width: 20,
                              child: const CircularProgressIndicator(),
                            )
                          : null,
                      hintText: 'Search',
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
