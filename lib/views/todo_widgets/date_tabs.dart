import 'package:flutter/material.dart';

class DateTabs extends StatelessWidget {
  final TabController tabController;

  const DateTabs({Key? key, required this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      labelColor: Theme.of(context).primaryColor,
      unselectedLabelColor: Colors.grey,
      indicatorColor: Theme.of(context).primaryColor,
      tabs: const [
        Tab(text: "Today"),
        Tab(text: "Tomorrow"),
        Tab(text: "All"),
      ],
    );
  }
}
