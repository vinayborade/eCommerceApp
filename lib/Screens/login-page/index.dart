import 'dart:convert';
import 'package:ecommerce_app/Screens/home-Page/index.dart';
import 'package:ecommerce_app/design-system/colors/index.dart';
import 'package:ecommerce_app/design-system/vb-text/index.dart';
import 'package:ecommerce_app/types/vb_typography_type.dart';
import 'package:ecommerce_app/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const routeName = '/login-page';
  static const screenName = 'LoginPage';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;
  bool _isLoading = false;

  Future<void> _login() async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    if (StringUtils.isEmpty(username) || StringUtils.isEmpty(password)) {
      setState(() {
        _errorMessage = 'Please enter username & password';
        _showAlertDialog(context);
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('https://fakestoreapi.com/auth/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print('Login successful: $jsonResponse');
        setState(() {
          _errorMessage = null;
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        setState(() {
          _errorMessage = 'Login failed. Please check your credentials.';
          _showAlertDialog(context);
        });
      }
    } catch (error) {
      setState(() {
        _errorMessage = 'Network error. Please try again later.';
        _showAlertDialog(context);
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: VBColors.COLOR_10,
        title: const VBText(
          text: "Login",
          typographyType: VBTypographyType.HEADING_L,
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
              color: VBColors.COLOR_10,
              borderRadius: BorderRadius.circular(10)),
          width: 380,
          height: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const VBText(
                text: "Welcome!",
                typographyType: VBTypographyType.HEADING_L_BOLD,
              ),
              const SizedBox(height: 50),
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                    labelStyle: TextStyle(color: VBColors.BLACK),
                    labelText: 'Username',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: VBColors.WHITE)),
                    focusColor: VBColors.BLACK),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelStyle: TextStyle(color: VBColors.BLACK),
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  child: _isLoading 
                      ? CircularProgressIndicator()
                      : const VBText(
                          text: "Login",
                          typographyType: VBTypographyType.BODY_M,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: VBText(
            text: _errorMessage!,
            typographyType: VBTypographyType.BODY_M_MEDIUM,
          ),
          actions: <Widget>[
            TextButton(
              child: const VBText(
                text: 'Okay',
                typographyType: VBTypographyType.BODY_M,
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}
