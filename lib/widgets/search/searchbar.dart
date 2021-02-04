import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final onTapRoute;
  final onVlaueChanged;
  final hint; 
  SearchWidget(this.onTapRoute, this.onVlaueChanged, this.hint);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 7.0),
      child: TextField(
        maxLines: null,
        minLines: null,
        autofocus: true,
        enabled: onTapRoute == null ? true : false,
        onChanged: (value) {
          onVlaueChanged(value);
        },
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          fillColor: Colors.white,
          hintStyle: TextStyle(color: Colors.white70),
          suffixIcon: Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
