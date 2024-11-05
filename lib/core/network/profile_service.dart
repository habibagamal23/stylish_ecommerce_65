import 'package:dio/dio.dart';
import '../../fetures/profile-setting/model/user.dart';
import '../sherdprf/sherd.dart';
import 'Error.dart';
import 'constantApi.dart';

class ProfileService {
  final Dio _dio;

  ProfileService(this._dio);

  Future<User?> getCurrentUserbyid() async {
    try {
      final int? id = SharedPrefsHelper.getid();

      if (id == null) {
        throw Exception("No id found. Please log in again.");
      }

      final resp = await _dio.get(
        '${ApiConstants.user}/$id',
      );

      if (resp.statusCode == 200) {
        return User.fromJson(resp.data);
      } else {
        throw Exception("Failed to load user: Status code ${resp.statusCode}");
      }
    } on DioException catch (e) {
      throw handleDioError(e);
    } catch (e) {
      throw Exception("Unexpected error while loading user: $e");
    }
  }
}
