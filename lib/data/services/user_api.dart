import '../../core/constant/app_api.dart';
import '../../core/network/api_client.dart';
import '../models/user_model.dart';

class UserApi {
  final ApiClient _client = ApiClient();

  Future<UserModel> getUser() async {
    final res = await _client.get(AppApi.user);
    return UserModel.fromJson(res);
  }
}