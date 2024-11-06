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

  Future<User?> updateUserProfile({
    required int userId,
    String? username,
    String? email,
    String? password,
    String? imageUrl,
  }) async {
    try {
      final data = {
        if (username != null) 'username': username,
        if (email != null) 'email': email,
        if (password != null) 'password': password,
        if (imageUrl != null) 'image': imageUrl,
      };

      final response = await _dio.put(
        '${ApiConstants.user}/$userId',
        data: data,
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      } else {
        throw Exception(
            "Failed to update user: Status code ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw handleDioError(e);
    } catch (e) {
      throw Exception("Unexpected error while updating user: $e");
    }
  }
}
