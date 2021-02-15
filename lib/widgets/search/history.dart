import 'package:flutter/material.dart';

class HistoryList extends StatelessWidget {
  final list;
  const HistoryList(this.list);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: list != null ? list.length : 0,
        itemBuilder: (_, idx) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  list[idx],
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {},
              ),
            ],
          );
        },
      ),
    );
  }
}
