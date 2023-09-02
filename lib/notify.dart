import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class localnotification {
  localnotification();
  final _localnotificationServices = FlutterLocalNotificationsPlugin();

  Future<void> initlize() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings and = AndroidInitializationSettings('@drawable/ic_stat_access_alarms');

    final InitializationSettings settings =
        InitializationSettings(android: and);

    await _localnotificationServices.initialize(settings);
  }

  Future<NotificationDetails> notificationDetails() async {
    const AndroidNotificationDetails andDet = AndroidNotificationDetails(
      "channelId",
      "channelName",
      channelDescription: "description",
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      sound: RawResourceAndroidNotificationSound("notification"),
    );
    return const NotificationDetails(android: andDet);
  }

  Future<void> showNotification(
      {required int id,
      required String title,
      required String body,
      required int second}) async {
    final details = await notificationDetails();

    await _localnotificationServices.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(
            DateTime.now().add(Duration(seconds: second)), tz.local),
        details,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
