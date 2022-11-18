import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

import '../models/notification.dart';
import '../screens/feedback.dart';
import '../screens/home_page.dart';

class NotifyManager {
  static int _id = 0;

  static final FlutterLocalNotificationsPlugin notification = FlutterLocalNotificationsPlugin();

  static final StreamController<ReceivedNotification>
      didReceiveLocalNotificationStream =
      StreamController<ReceivedNotification>.broadcast();

  static final StreamController<String?> selectNotificationStream =
      StreamController<String?>.broadcast();

  static NotificationAppLaunchDetails? notificationAppLaunchDetails;

  static String? selectedPayload;

  static String initialRoute = MyHomePage.routeName;

  static Future initNotification() async {
    const String navigationActionId = 'id_3';

    notificationAppLaunchDetails =
        await notification.getNotificationAppLaunchDetails();

    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      selectedPayload =
          notificationAppLaunchDetails!.notificationResponse?.payload;
      initialRoute = FeedbackScreen.routeName;      
    }

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@drawable/ic_stat_logo3');

    const InitializationSettings settings = InitializationSettings(android: androidSettings);

    await notification.initialize(
      settings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            selectNotificationStream.add(notificationResponse.payload);
            break;
          case NotificationResponseType.selectedNotificationAction:
            if (notificationResponse.actionId == navigationActionId) {
              selectNotificationStream.add(notificationResponse.payload);
            }
            break;
        }
      },
    );

    tz.initializeTimeZones();
  }

  static Future showNotification({
    required String? title,
    required String? body,
    required String? payload,
    required String data,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'CHANNEL_ID',
      'CHANNEL_NAME',
      channelDescription: 'CHANNEL_DESCRIPTION',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      sound: RawResourceAndroidNotificationSound('nokia_ring'),
      autoCancel: true,
      playSound: true,
      enableVibration: true,
      styleInformation: BigPictureStyleInformation(
        DrawableResourceAndroidBitmap('notification'),
      ),
    );
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);
    await notification.zonedSchedule(
      _id++,
      title,
      body,
      tz.TZDateTime.from(DateTime.parse(data), tz.local),
      notificationDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: payload,
    );
  }

  static cancelAllNotifications() => notification.cancelAll();
}
