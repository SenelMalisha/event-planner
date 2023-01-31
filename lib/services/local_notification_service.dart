import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();


  Future scheduleReminder({required String title, required String body, required DateTime scheduledDate}) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'channel_id', 'channel_name',
        importance: Importance.max, priority: Priority.high);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    await _notificationsPlugin.schedule(
        0, title, body, scheduledDate, platformChannelSpecifics);
  }

  static void initialize() {
    final InitializationSettings initializationSettings;

    if (Platform.isAndroid) {
      initializationSettings = InitializationSettings(
          android: AndroidInitializationSettings("@mipmap/ic_launcher"));
    } else {
      initializationSettings =
          InitializationSettings(iOS: IOSInitializationSettings());
    }

    _notificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? data) async {
          debugPrint('notification payload: ');
        });
  }

}
