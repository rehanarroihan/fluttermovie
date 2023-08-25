import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttermovie/res/colors.dart';

class AppSearchBar extends StatefulWidget {
  final String? hint;
  final ValueChanged<String> onQueryChanged;

  const AppSearchBar({
    Key? key,
    this.hint,
    required this.onQueryChanged
  }) : super(key: key);

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  final TextEditingController _textEditingController = TextEditingController();
  Timer? _debounce;

  void _onSearchTextChanged(String query) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }

    _debounce = Timer(const Duration(milliseconds: 500), () {
      widget.onQueryChanged(query);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _textEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _textEditingController,
      style: const TextStyle(color: Colors.white),
      onChanged: _onSearchTextChanged,
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: TextStyle(
          fontSize: 16,
          color: Colors.white.withOpacity(0.7)
        ),
        suffixIcon: Icon(
          Icons.search,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}
