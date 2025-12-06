import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationButton extends ConsumerStatefulWidget {
  const NotificationButton({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NotificationButtonState();
}

class _NotificationButtonState extends ConsumerState<NotificationButton> {

  @override
  Widget build(BuildContext context) {
    return Stack(
  children: [
    IconButton(
      icon: Icon(Icons.notifications, color: Colors.amber, size: 40),
      onPressed: () {
        // Handle notification tap
      },
    ),
    Positioned(
      right: 6,
      top: 6,
      child: Container(
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
        ),
        constraints: BoxConstraints(
          minWidth: 18,
          minHeight: 18,
        ),
        child: Text(
          '1', // notification count
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  ],
) ;
  }
}