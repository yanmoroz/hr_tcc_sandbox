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
          'eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJ3THlGOTBTTlZBUko5T1UzRENndXhLblVSTnIyS3VmVGVwdHZyVnV4bFhRIn0.eyJleHAiOjE3NTg4MzUxNzYsImlhdCI6MTc1ODc5OTUzNywiYXV0aF90aW1lIjoxNzU4Nzk5MTc2LCJqdGkiOiJvbnJ0YWM6NmY1MWM0YzItZGM2ZS02ODE5LTA5MmItODRlMGE4MDcxYjExIiwiaXNzIjoiaHR0cHM6Ly9sZW11ci0xLmNsb3VkLWlhbS5jb20vYXV0aC9yZWFsbXMvbW9iaWxlLXRjYy1yZWFsbSIsImF1ZCI6ImFjY291bnQiLCJzdWIiOiJkZDZlODAyZS05MjdiLTQwZWItOTdmZi0xMjkxMzRhNjFhMmMiLCJ0eXAiOiJCZWFyZXIiLCJhenAiOiJtb2JpbGUtdGNjIiwic2lkIjoiOTJlMzQwMzgtZWMxMC00OTk5LWI0NDUtMTI5OTAxMjM1NTExIiwiYWNyIjoiMCIsImFsbG93ZWQtb3JpZ2lucyI6WyJodHRwOi8vbG9jYWxob3N0OjgwODAiLCJodHRwOi8vbG9jYWxob3N0Ojg0NDMiXSwicmVhbG1fYWNjZXNzIjp7InJvbGVzIjpbIm9mZmxpbmVfYWNjZXNzIiwidW1hX2F1dGhvcml6YXRpb24iLCJkZWZhdWx0LXJvbGVzLW1ldGVvciJdfSwicmVzb3VyY2VfYWNjZXNzIjp7Im1vYmlsZS10Y2MiOnsicm9sZXMiOlsiRU1QTE9ZRUUiXX0sImFjY291bnQiOnsicm9sZXMiOlsibWFuYWdlLWFjY291bnQiLCJtYW5hZ2UtYWNjb3VudC1saW5rcyIsInZpZXctcHJvZmlsZSJdfX0sInNjb3BlIjoib3BlbmlkIGVtYWlsIHByb2ZpbGUiLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwibmFtZSI6ItCQ0LvQtdC60YHQtdC5IFgiLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJ1c2VyMyIsImdpdmVuX25hbWUiOiLQkNC70LXQutGB0LXQuSIsImZhbWlseV9uYW1lIjoiWCIsImVtYWlsIjoiYWxla3NlaS5vZG5vbGtvQHN5bmNocm8ucHJvIn0.WdYWwSj__C6JyC0U1Dm6E33cbwQp6JZtPdvH2R8QAfjaJdgBQYCXA_O2ZR5ft_P2kz15prkjvgyviEdaLtWYmCAmM0cOIq7Gajb6ipXfk1-bDzDbyT5eFRNgR9_ENvMLw51ImsK16fEZfu_l1-Mb64w_i3IlbJKO1G1I2utMdZ2sHbvQeC37AheYTVud082NjAM02RKrCH1HJ4EGz9whdDDdQ4ksV8_53vOV-HK_Q3Rh0ahOWUgm_KF5_8jf50ff-dNmP6_0j5CZriCE7A41R-B3ENo35ihVSNlwvnKlo-8lf6I3r7SuiyMqa2bwufRGD_3gQY0-NKaD6rAHR8zoVA',
      refreshToken: 'mock_refresh_token_67890',
      expiresAt: DateTime.now().add(const Duration(hours: 24)),
    );
  }
}
