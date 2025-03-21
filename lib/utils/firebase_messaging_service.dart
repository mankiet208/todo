import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logging/logging.dart';

/// When using Flutter version 3.3.0 or higher, the message handler must be annotated with @pragma('vm:entry-point') right above the function declaration (otherwise it may be removed during tree shaking for release mode).
class FirebaseMessagingService {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static final _log = Logger('FirebaseMessagingService');

  // Initialize Firebase Messaging
  static Future<void> initialize() async {
    // Request permission for iOS
    NotificationSettings settings =
        await _firebaseMessaging.requestPermission();
    _log.info('Notification permission: ${settings.authorizationStatus}');

    // Get the FCM token
    String? token = await _firebaseMessaging.getToken();
    _log.info("FCM Token: $token");

    // Handle message interaction
    await _setupInteractedMessage();

    // Configure foreground message handler
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Set background message handler
    FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
  }

  static Future<void> _setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessageInteraction(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageInteraction);
  }

  // Handle foreground notifications
  @pragma('vm:entry-point')
  static Future<void> _handleForegroundMessage(RemoteMessage message) async {
    _log.info('Received a foreground message: ${message.notification?.title}');
  }

  // Handle background notifications
  @pragma('vm:entry-point')
  static Future<void> _handleBackgroundMessage(RemoteMessage message) async {
    _log.info('Received a background message: ${message.notification?.title}');
  }

  // Handle foreground notifications
  @pragma('vm:entry-point')
  static Future<void> _handleMessageInteraction(RemoteMessage message) async {
    _log.info('Handle message interaction: ${message.notification?.title}');
  }
}
