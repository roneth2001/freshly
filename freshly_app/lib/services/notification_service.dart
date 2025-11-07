import 'dart:ui';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:freshly_app/db/database_helper.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications = 
      FlutterLocalNotificationsPlugin();

  final DatabaseHelper _dbHelper = DatabaseHelper();

  // Initialize the notification service
  Future<void> initialize() async {
    // Initialize timezone
    tz.initializeTimeZones();
    
    // Android initialization settings
    const AndroidInitializationSettings androidSettings = 
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS initialization settings
    const DarwinInitializationSettings iosSettings = 
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // Request permissions
    await _requestPermissions();
  }

  // Request notification permissions
  Future<void> _requestPermissions() async {
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }

    // For Android 13+ (API 33+)
    final status = await Permission.notification.status;
    if (status.isDenied) {
      await Permission.notification.request();
    }
  }

  // Handle notification tap
  void _onNotificationTapped(NotificationResponse response) {
    // Handle navigation or actions when notification is tapped
    print('Notification tapped: ${response.payload}');
  }

  // Schedule notification for an item
  Future<void> scheduleItemNotification(
    int itemId,
    String itemName,
    DateTime expiryDate,
  ) async {
    // Cancel any existing notification for this item
    await cancelNotification(itemId);

    // Calculate notification time (2 days before expiry at 9 AM)
    final notificationDate = expiryDate.subtract(const Duration(days: 2));
    final scheduledDate = DateTime(
      notificationDate.year,
      notificationDate.month,
      notificationDate.day,
      9, // 9 AM
      0,
    );

    // Only schedule if the notification time is in the future
    if (scheduledDate.isAfter(DateTime.now())) {
      await _notifications.zonedSchedule(
        itemId, // Use item ID as notification ID
        'Item Expiring Soon! ⚠️',
        '$itemName will expire in 2 days',
        tz.TZDateTime.from(scheduledDate, tz.local),
        NotificationDetails(
          android: AndroidNotificationDetails(
            'expiry_channel',
            'Expiry Notifications',
            channelDescription: 'Notifications for items about to expire',
            importance: Importance.high,
            priority: Priority.high,
            color: const Color(0xFF7CB342),
            icon: '@mipmap/ic_launcher',
            styleInformation: BigTextStyleInformation(
              '$itemName will expire on ${expiryDate.toLocal().toString().split(' ')[0]}',
              contentTitle: 'Item Expiring Soon! ⚠️',
              summaryText: 'Check your inventory',
            ),
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: itemId.toString(),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }

  // Schedule notifications for all items
  Future<void> scheduleAllNotifications() async {
    final items = await _dbHelper.getItems();
    
    for (var item in items) {
      final expiryDate = DateTime.parse(item['expiryDate']);
      await scheduleItemNotification(
        item['id'],
        item['name'],
        expiryDate,
      );
    }
  }

  // Cancel notification for a specific item
  Future<void> cancelNotification(int itemId) async {
    await _notifications.cancel(itemId);
  }

  // Cancel all notifications
  Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
  }

  // Show immediate notification (for testing or immediate alerts)
  Future<void> showImmediateNotification(
    String title,
    String body, {
    String? payload,
  }) async {
    await _notifications.show(
      DateTime.now().millisecond,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'immediate_channel',
          'Immediate Notifications',
          channelDescription: 'Immediate notification alerts',
          importance: Importance.high,
          priority: Priority.high,
          color: Color(0xFF7CB342),
          icon: '@mipmap/ic_launcher',
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: payload,
    );
  }

  // Check and notify about items expiring today or already expired
  Future<void> checkExpiredItems() async {
    final items = await _dbHelper.getItems();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    for (var item in items) {
      final expiryDate = DateTime.parse(item['expiryDate']);
      final expiryDay = DateTime(
        expiryDate.year,
        expiryDate.month,
        expiryDate.day,
      );

      // Check if expired or expiring today
      if (expiryDay.isBefore(today) || expiryDay.isAtSameMomentAs(today)) {
        await showImmediateNotification(
          'Item Expired! 🚨',
          '${item['name']} has expired or is expiring today',
          payload: item['id'].toString(),
        );
      }
    }
  }

  // Get all pending notifications (for debugging)
  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await _notifications.pendingNotificationRequests();
  }
}