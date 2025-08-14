import '../../../../shared/services/network_service.dart';
import '../../../../shared/utils/auth_constants.dart';
import '../models/login_request_model.dart';
import '../models/login_response_model.dart';
import '../models/user_model.dart';
import '../../domain/entities/user.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> login(String username, String password);
  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final NetworkService _networkService;

  AuthRemoteDataSourceImpl(this._networkService);

  @override
  Future<LoginResponseModel> login(String username, String password) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 800));

      // Mock API response - in real app, this would be an actual API call
      final requestModel = LoginRequestModel(
        username: username,
        password: password,
      );

      // Simulate API call
      // final response = await _networkService.post(
      //   '${AuthConstants.baseUrl}${AuthConstants.loginEndpoint}',
      //   requestModel.toJson(),
      // );

      // Mock successful response
      if (username == 'vladimir.grebennikov' && password == 'password123') {
        return _getMockLoginResponse();
      } else {
        throw Exception(AuthConstants.invalidCredentials);
      }
    } catch (e) {
      if (e.toString().contains('Exception:')) {
        rethrow;
      }
      throw Exception(AuthConstants.networkError);
    }
  }

  @override
  Future<void> logout() async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 400));

      // Mock API call
      // await _networkService.post(
      //   '${AuthConstants.baseUrl}${AuthConstants.logoutEndpoint}',
      //   {},
      // );
    } catch (e) {
      // Logout should not fail even if API call fails
      // Just log the error and continue
      print('Logout API call failed: $e');
    }
  }

  LoginResponseModel _getMockLoginResponse() {
    return LoginResponseModel(
      user: UserModel(
        id: '1',
        username: 'vladimir.grebennikov',
        email: 'vladimir.grebennikov@company.com',
        fullName: 'Владимир Гребенников',
        avatarUrl: 'https://example.com/avatar.jpg',
        role: UserRole.employee,
        createdAt: DateTime(2024, 1, 15),
        status: UserStatus.active,
      ),
      accessToken: 'mock_access_token_12345',
      refreshToken: 'mock_refresh_token_67890',
      expiresAt: DateTime.now().add(const Duration(hours: 24)),
    );
  }
}
