import 'package:repairo_app_new/data/models/user_model.dart';
import 'package:repairo_app_new/data/web_services/verification_webservices.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerificationRepository {
  final VerificationWebservices verificationWebservices;
  VerificationRepository(this.verificationWebservices);
  Future<User> verifyNumber(String phone, String code, String fcm) async {
    final prefs = await SharedPreferences.getInstance();
    final String? fcmm = prefs.getString('fcm');
    final data = await verificationWebservices.verifyNumber(phone, code, fcmm!);
    final token = data['data']['access_token'];
    final name = data['data']['name'];
    await prefs.setString('auth_token', token);
    await prefs.setString('user_name', name ?? "verified_user");
    return User.fromJson(data);
  }
}
