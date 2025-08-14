import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth_bloc.dart';
import '../blocs/auth_event.dart';
import '../blocs/auth_state.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  bool _agreeToDataProcessing = false;
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      _isFormValid =
          _usernameController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _agreeToDataProcessing;
    });
  }

  void _onLoginPressed() {
    if (_isFormValid) {
      context.read<AuthBloc>().add(
        LoginRequested(
          username: _usernameController.text.trim(),
          password: _passwordController.text,
          agreeToDataProcessing: _agreeToDataProcessing,
        ),
      );
    }
  }

  void _onDataProcessingLinkPressed() {
    // TODO: Navigate to data processing terms page
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Политика обработки персональных данных')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            // TODO: Navigate to PIN setup or main app
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Добро пожаловать, ${state.user.fullName}!'),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const SizedBox(height: 60),

                // Title
                const Text(
                  'Войдите в учётную запись',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 40),

                // Login Form
                Expanded(
                  child: Column(
                    children: [
                      // Username Field
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          final isError = state is LoginError;
                          return CustomTextField(
                            hintText: 'Логин',
                            controller: _usernameController,
                            focusNode: _usernameFocusNode,
                            isError: isError,
                            keyboardType: TextInputType.text,
                            onChanged: (_) => _validateForm(),
                          );
                        },
                      ),

                      const SizedBox(height: 16),

                      // Password Field
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          final isError = state is LoginError;
                          return CustomTextField(
                            hintText: 'Пароль',
                            controller: _passwordController,
                            focusNode: _passwordFocusNode,
                            isPassword: true,
                            isError: isError,
                            keyboardType: TextInputType.visiblePassword,
                            onChanged: (_) => _validateForm(),
                          );
                        },
                      ),

                      const SizedBox(height: 8),

                      // Error Message
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          if (state is LoginError) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                state.message,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),

                      const SizedBox(height: 24),

                      // Data Processing Agreement
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _agreeToDataProcessing =
                                    !_agreeToDataProcessing;
                              });
                              _validateForm();
                            },
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: _agreeToDataProcessing
                                    ? const Color(0xFF6366F1)
                                    : Colors.transparent,
                                border: Border.all(
                                  color: const Color(0xFF6366F1),
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: _agreeToDataProcessing
                                  ? const Icon(
                                      Icons.check,
                                      size: 12,
                                      color: Colors.white,
                                      weight: 900,
                                    )
                                  : null,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _agreeToDataProcessing =
                                      !_agreeToDataProcessing;
                                });
                                _validateForm();
                              },
                              child: RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    height: 1.4,
                                  ),
                                  children: [
                                    const TextSpan(text: 'Я согласен(на) на '),
                                    TextSpan(
                                      text: 'обработку персональных данных',
                                      style: const TextStyle(
                                        color: Color(0xFF6366F1),
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = _onDataProcessingLinkPressed,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const Spacer(),

                      // Continue Button
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          if (!_isFormValid) {
                            return const SizedBox.shrink(); // Hide button when form is invalid
                          }
                          return CustomButton(
                            text: 'Продолжить',
                            onPressed: _onLoginPressed,
                            isLoading: state is LoginLoading,
                            isEnabled: _isFormValid,
                          );
                        },
                      ),

                      const SizedBox(height: 24),

                      // Footer Text
                      const Column(
                        children: [
                          Text(
                            'Если у вас нет учётной записи,',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'обратитесь в компанию',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
