import 'package:flutter/material.dart';
import 'package:youdoyou/constants/app_colors.dart';
import 'package:youdoyou/constants/app_sizes.dart';
import 'package:youdoyou/features/authentication/data/firebase_auth.dart';

enum AuthMode {
  signup,
  login,
}

class AuthCard extends StatefulWidget {
  const AuthCard({super.key});

  @override
  AuthCardState createState() => AuthCardState();
}

class AuthCardState extends State<AuthCard> {
  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey();

  AuthMode authMode = AuthMode.login;

  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  var _isLoading = false;
  final emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // if validation of the form... kaput!
      return;
    }
    //save requirements
    _formKey.currentState!.save();
    _formKey.currentState!.reset();

    setState(() {
      _isLoading = true;
    });
    if (authMode == AuthMode.login) {
      // Log user in AND GO TO HOME
      const Duration(seconds: 1);
      await FirebaseAuthRepository()
          .logIn(_authData['email'] as String, _authData['password'] as String);
    } else {
      //this returns a future/promise... the whole function should be async?
      // check if user already exists or no, Sign user up and go home
      const Duration(seconds: 1);
      await FirebaseAuthRepository()
          .signUp(_authData['email'] as String, _authData['password'] as String);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (authMode == AuthMode.login) {
      setState(() {
        authMode = AuthMode.signup;
      });
    } else {
      setState(() {
        authMode = AuthMode.login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        height: authMode == AuthMode.signup ? 340 : 280,
        constraints: BoxConstraints(minHeight: authMode == AuthMode.signup ? 340 : 280),
        width: deviceSize.width * 0.75,
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                //EMAIL TEXTFIELD
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'E-Mail',
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.secondary),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['email'] = value!;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                //PASSWORD TEXTFIELD
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.secondary),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    if (value != null) _authData['password'] = value;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                if (authMode == AuthMode.signup)
                  TextFormField(
                    enabled: authMode == AuthMode.signup,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: AppColors.white),
                        borderRadius: BorderRadius.circular(Sizes.p12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: AppColors.secondary),
                        borderRadius: BorderRadius.circular(Sizes.p12),
                      ),
                    ),
                    obscureText: true,
                    validator: authMode == AuthMode.signup
                        ? (value) {
                            if (value != _passwordController.text) {
                              return 'Passwords do not match!';
                            }
                            return null;
                          }
                        : null,
                  ),
                const SizedBox(
                  height: 10,
                ),
                // BUTTONS---------------------------------------
                if (_isLoading)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: AppColors.complement,
                      foregroundColor: AppColors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: Sizes.p8),
                    ),
                    onPressed: _submit,
                    child: Text(authMode == AuthMode.login ? 'LOGIN' : 'SIGN UP'),
                  ),
                //switch between sign in/ up---------------------------
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.additional,
                    padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: Sizes.p4),
                  ),
                  onPressed: _switchAuthMode,
                  child: Text(
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      '${authMode == AuthMode.login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
