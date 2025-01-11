import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hr/generic_bloc.dart';
import 'package:hr/generic_event.dart';
import 'package:hr/generic_state.dart';
import 'package:hr/localization_service.dart';

class LoginPage extends StatefulWidget {
  final Function(Locale) onChangeLanguage;
  final Locale currentLocale;

  const LoginPage({
    super.key,
    required this.onChangeLanguage,
    required this.currentLocale,
  });

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  bool _isPasswordVisible = false;
  bool _rememberMe = false;
  bool _isErrorDialogVisible = false;

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  Future<void> _loadSavedCredentials() async {
    final savedUsername = await _secureStorage.read(key: 'username');
    final savedPassword = await _secureStorage.read(key: 'password');

    if (savedUsername != null && savedPassword != null) {
      setState(() {
        _usernameController.text = savedUsername;
        _passwordController.text = savedPassword;
        _rememberMe = true;
      });
    }
  }

  Future<void> _saveCredentials(String username, String password) async {
    if (_rememberMe) {
      await _secureStorage.write(key: 'username', value: username);
      await _secureStorage.write(key: 'password', value: password);
    } else {
      await _secureStorage.delete(key: 'username');
      await _secureStorage.delete(key: 'password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GenericBloc(
        submitDataCallback: (data) async {
          final username = data['username'] ?? '';
          final password = data['password'] ?? '';

          print("DEBUG: Received username: $username, password: $password");

          if (username.isEmpty || password.isEmpty) {
            throw Exception(LocalizationService.translate('fill_credentials'));
          }

          // Simulate login API call with specific credentials
          await Future.delayed(const Duration(seconds: 2));

          // Set specific username and password
          if (username == 'user123' && password == 'pass123') {
            print("DEBUG: Login successful");
            return {'success': true};
          } else {
            print("DEBUG: Login failed");
            throw Exception(LocalizationService.translate('login_failed'));
          }
        },
      ),
      child: BlocConsumer<GenericBloc, GenericState>(
        listener: (context, state) {
          if (state is GenericLoaded) {
            _saveCredentials(
              _usernameController.text.trim(),
              _passwordController.text.trim(),
            );
            Navigator.of(context).pushReplacementNamed('/HomePage');
          } else if (state is GenericError) {
            if (!_isErrorDialogVisible) {
              setState(() {
                _isErrorDialogVisible = true;
              });

              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text(LocalizationService.translate('Error')),
                  content: Text(state.message),
                  actions: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isErrorDialogVisible = false;
                        });
                        Navigator.of(ctx).pop();
                      },
                      child: Text(LocalizationService.translate('ok')),
                    ),
                  ],
                ),
              );
            }
          }
        },
        builder: (context, state) {
          final isLoading = state is GenericLoading;

          return Scaffold(
            backgroundColor: const Color(0xff3D3D3D),
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const Center(
                      child: Image(
                        image: AssetImage('assets/images/karlogo.png'),
                        width: 70,
                        height: 70,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Directionality(
                      textDirection: TextDirection.ltr,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.apps,
                            color: Color(0xffCE5E52),
                            size: 40,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'E-Service System',
                            style: TextStyle(fontSize: 28, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person, color: Colors.white),
                          labelText: LocalizationService.translate('username'),
                          labelStyle: const TextStyle(color: Colors.white),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock, color: Colors.white),
                          labelText: LocalizationService.translate('password'),
                          labelStyle: const TextStyle(color: Colors.white),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Checkbox(
                                value: _rememberMe,
                                activeColor: const Color(0xffCE5E52),
                                onChanged: (bool? value) {
                                  setState(() {
                                    _rememberMe = value ?? false;
                                  });
                                },
                              ),
                            ),
                            Text(
                              LocalizationService.translate('remember_me'),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 13),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/reset-password');
                          },
                          child: Text(
                            LocalizationService.translate('forgot_password'),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              final username = _usernameController.text.trim();
                              final password = _passwordController.text.trim();

                              context.read<GenericBloc>().add(
                                    SubmitData(data: {
                                      'username': username,
                                      'password': password,
                                    }),
                                  );
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffCE5E52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        minimumSize: const Size(380, 50),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              LocalizationService.translate('login'),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 22),
                            ),
                    ),
                    const SizedBox(height: 30),
                    TextButton(
                      onPressed: () {
                        if (widget.currentLocale.languageCode == 'en') {
                          widget.onChangeLanguage(const Locale('ar', 'EG'));
                        } else {
                          widget.onChangeLanguage(const Locale('en', 'US'));
                        }
                      },
                      child: Text(
                        widget.currentLocale.languageCode == 'en'
                            ? "عربي"
                            : "English",
                        style: const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      LocalizationService.translate('rights_reserved'),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
