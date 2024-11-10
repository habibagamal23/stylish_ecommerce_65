import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shtylishecommerce/core/sherdprf/sherd.dart';
import 'package:shtylishecommerce/fetures/profile-setting/model/user.dart';

import 'constantApi.dart';

class ProfileService {
  final Dio dio;

  ProfileService(this.dio);

  Future<User?> getCurrentuser() async {
    try {
      final int? id = SharedPrefsHelper.getid();

      if (id == null) {
        throw Exception("No id log again");
      }

      final response = await dio.get('${ApiConstants.user}/$id');

      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      } else {
        throw Exception(" Filed to load user ${response.statusCode}");
      }
    } catch (e) {
      throw Exception(" Error $e ");
    }
  }

  Future<User?> updateProfile(User user) async {
    try {
      final data = user.toJson();

      final response = await dio.put('${ApiConstants.user}/${user.id}',
          data: data,
          options: Options(headers: {'Content-Type': 'application/json'}));

      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      } else {
        throw Exception(" Filed to load user ${response.statusCode}");
      }
    } catch (e) {
      throw Exception(" Error $e ");
    }
  }
}
