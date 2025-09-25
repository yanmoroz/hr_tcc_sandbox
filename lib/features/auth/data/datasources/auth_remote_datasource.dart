import '../../../../shared/services/network_service.dart';
import '../../../../shared/services/logger_service.dart';
import '../../../../shared/utils/auth_constants.dart';
import '../../../../main.dart';
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
      getIt<LoggerService>().warning('Logout API call failed: $e');
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
      accessToken:
          'eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJ3THlGOTBTTlZBUko5T1UzRENndXhLblVSTnIyS3VmVGVwdHZyVnV4bFhRIn0.eyJleHAiOjE3NTgyNzE4NjYsImlhdCI6MTc1ODIzNTkwNywiYXV0aF90aW1lIjoxNzU4MjM1ODY2LCJqdGkiOiJvbnJ0YWM6NzA0NzQ5NDMtMDkyYS00ZDIxLWUxZWMtZjVmZjcxZGZkYjY5IiwiaXNzIjoiaHR0cHM6Ly9sZW11ci0xLmNsb3VkLWlhbS5jb20vYXV0aC9yZWFsbXMvbW9iaWxlLXRjYy1yZWFsbSIsImF1ZCI6ImFjY291bnQiLCJzdWIiOiJkZDZlODAyZS05MjdiLTQwZWItOTdmZi0xMjkxMzRhNjFhMmMiLCJ0eXAiOiJCZWFyZXIiLCJhenAiOiJtb2JpbGUtdGNjIiwic2lkIjoiNjgzNTFlNDQtNWNlZi00NmZkLWFmNWQtZjljMWNhNzRkNmU1IiwiYWNyIjoiMSIsImFsbG93ZWQtb3JpZ2lucyI6WyJodHRwOi8vbG9jYWxob3N0OjgwODAiLCJodHRwOi8vbG9jYWxob3N0Ojg0NDMiXSwicmVhbG1fYWNjZXNzIjp7InJvbGVzIjpbIm9mZmxpbmVfYWNjZXNzIiwidW1hX2F1dGhvcml6YXRpb24iLCJkZWZhdWx0LXJvbGVzLW1ldGVvciJdfSwicmVzb3VyY2VfYWNjZXNzIjp7Im1vYmlsZS10Y2MiOnsicm9sZXMiOlsiRU1QTE9ZRUUiXX0sImFjY291bnQiOnsicm9sZXMiOlsibWFuYWdlLWFjY291bnQiLCJtYW5hZ2UtYWNjb3VudC1saW5rcyIsInZpZXctcHJvZmlsZSJdfX0sInNjb3BlIjoib3BlbmlkIGVtYWlsIHByb2ZpbGUiLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwibmFtZSI6ItCQ0LvQtdC60YHQtdC5IFgiLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJ1c2VyMyIsImdpdmVuX25hbWUiOiLQkNC70LXQutGB0LXQuSIsImZhbWlseV9uYW1lIjoiWCIsImVtYWlsIjoiYWxla3NlaS5vZG5vbGtvQHN5bmNocm8ucHJvIn0.OU776AVgTy3MCfPf1K-yHqeNjvXXU7MlWfYEUfDt69HWYHZpSP32ERntFJkxLn1DvVB0flVwQMYMPh3QuNkbabpyUjRyLQv0WIslNqJ1FSZf8NEpzgle4aS2ENgfAMCNifZ-1I2nOb79QMq3KK86YqIrdziH1_Yd8m-TvxYdL7jmmlI2N4HuTknUSZG-Pv5yy4DaYaHyx1BHeMYbE9T-jB6a_vXb4ceINAL87iWRczQg6WEkYV9fB5mDUYQ5W0hTIPREw_uH976zFkJnCMTaVurMgpHAKiUfxDnECMtcdHJjE1NWQU7u-L-UvOLifiR4U__YVUGBN1e64W2-v5yoTg',
      refreshToken: 'mock_refresh_token_67890',
      expiresAt: DateTime.now().add(const Duration(hours: 24)),
    );
  }
}
