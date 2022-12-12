import 'package:flutter/material.dart';
import 'package:frenzy_store/presentation/resources/strings_manager.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(AppStrings.notifications),
    );
  }
}
