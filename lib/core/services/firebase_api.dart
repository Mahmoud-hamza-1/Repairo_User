import 'dart:ui';

import 'package:repairo_app_new/core/services/local_notiffication_service.dart';
import 'package:repairo_app_new/presentation/widgets/custom_elevated_button.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print("title ${message.notification?.title}");
  print("body ${message.notification?.body}");
  print("payload ${message.data}");
  await LocalNotifications.showNotification(message);

}

// class FirebaseApi {
//   static Function()? onTechnicianAccepted;

//   final _firebaseMessaging = FirebaseMessaging.instance;

//   void handleMessage(RemoteMessage? message) {
//     FirebaseMessaging.onMessage.listen((message) {
//       print("Foreground message: ${message.notification?.title}");
//       LocalNotifications.showNotification(message);

//       if (message.data["type"] == "technician_accept") {
//         if (FirebaseApi.onTechnicianAccepted != null) {
//           FirebaseApi.onTechnicianAccepted!();
//         }
//       }
//     });

//     if (message == null) return;
// //the directed page should recieva a message paramete
//     Get.toNamed("mainscreen");
//   }

//   Future initPushNotiffications() async {
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//             alert: true, badge: true, sound: true);
//     //responsible for performing an action when app is opened from a terminated state
//     FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
//     FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
//     FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
//   }

//   Future<void> initNotiffications() async {
//     await _firebaseMessaging.requestPermission();
//     final fcmToken = await _firebaseMessaging.getToken();
//     print("token $fcmToken");
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('fcm', fcmToken!);

//     initPushNotiffications();
//     FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

//     // لما يكون التطبيق مفتوح (foreground)
//     FirebaseMessaging.onMessage.listen((message) {
//       print("Foreground message: ${message.notification?.title}");
//       LocalNotifications.showNotification(message);
//       FirebaseMessaging.onMessage.listen((message) {
//         print("Foreground message: ${message.notification?.title}");
//         LocalNotifications.showNotification(message);

//         if (message.data["type"] == "technician_accept") {
//           if (FirebaseApi.onTechnicianAccepted != null) {
//             FirebaseApi.onTechnicianAccepted!();
//           }
//         }
//       });
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen((message) {
//       FirebaseMessaging.onMessage.listen((message) {
//         print("Foreground message: ${message.notification?.title}");
//         LocalNotifications.showNotification(message);

//         if (message.data["type"] == "technician_accept") {
//           if (FirebaseApi.onTechnicianAccepted != null) {
//             FirebaseApi.onTechnicianAccepted!();
//           }
//         }
//       });

//       print("User tapped notification: ${message.data}");
//     });
//   }
// }

class FirebaseApi {
  static bool _isSearchingTechnician = true;

  // كولباك ممكن تستدعيه من برة
  static VoidCallback? onTechnicianAccepted;

  final _firebaseMessaging = FirebaseMessaging.instance;

  static void technicianAccepted() {
    if (_isSearchingTechnician) {
      _isSearchingTechnician = false;
      if (Get.isDialogOpen!) Get.back(); // سكّر "جاري البحث"
      Get.defaultDialog(
        title: '',
        content: Column(
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: Image.asset("assets/images/png/check.png"),
            ),
            const SizedBox(height: 10),
            const Text(
              "تم العثور على مهني وافق على طلبك 🎉",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: "Cairo",
                color: Colors.black,
              ),
            ),
          ],
        ),
        confirm: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 12),
          child: CustomElevatedButton(
            text: 'حسناً',
            onpressed: () => Get.toNamed("mainscreen"),
          ),
        ),
        barrierDismissible: false,
      );
    }
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    print("Message: ${message.notification?.title}");
    LocalNotifications.showNotification(message);

    if (message.data["type"] == "technician_accept") {
      if (onTechnicianAccepted != null) {
        onTechnicianAccepted!(); // يستدعي الكولباك المربوط من الشاشة
      } else {
        technicianAccepted(); // fallback: يستدعي الدالة الحالية
      }
    }
  }

  Future initPushNotiffications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessage.listen(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  Future<void> initNotiffications() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    print("token $fcmToken");
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('fcm', fcmToken!);

    await initPushNotiffications();
  }
}
