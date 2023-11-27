import 'package:flutter/material.dart';
import 'package:youdoyou/constants/app_colors.dart';
import 'package:youdoyou/features/authentication/data/firebase_auth.dart';

enum AuthMode { Signup, Login }

class AuthCard extends StatefulWidget {
  const AuthCard({super.key});

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  @override
  void initState() {
    super.initState();
    //check if user is loged in or out
  }

  final GlobalKey<FormState> _formKey = GlobalKey();

  AuthMode authMode = AuthMode.Login;
  // final _emailController = TextEditingController();
  // final _passwordController = TextEditingController();

//map to store the globalkey
//store this in riverpod?
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
    if (authMode == AuthMode.Login) {
      // Log user in AND GO TO HOME
      const Duration(seconds: 1);
      await FirebaseAuthService()
          .logIn(_authData['email'] as String, _authData['password'] as String);
    } else {
      //this returns a future/promise... the whole function should be async?
      // check if user already exists or no, Sign user up and go home
      const Duration(seconds: 1);
      await FirebaseAuthService().signUp(
          _authData['email'] as String, _authData['password'] as String);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (authMode == AuthMode.Login) {
      setState(() {
        authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        authMode = AuthMode.Login;
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
        height: authMode == AuthMode.Signup ? 340 : 280,
        constraints:
            BoxConstraints(minHeight: authMode == AuthMode.Signup ? 340 : 280),
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
                      borderSide: const BorderSide(color: Colors.white),
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
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@')) {
                      return 'Invalid email!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['email'] = value!;
                    //emailController.text = '';
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                //PASSWORD TEXTFIELD
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
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
                  },
                  onSaved: (value) {
                    if (value != null) _authData['password'] = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                if (authMode == AuthMode.Signup)
                  TextFormField(
                    enabled: authMode == AuthMode.Signup,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: AppColors.secondary),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    obscureText: true,
                    validator: authMode == AuthMode.Signup
                        ? (value) {
                            if (value != _passwordController.text) {
                              return 'Passwords do not match!';
                            }
                          }
                        : null,
                  ),
                const SizedBox(
                  height: 10,
                ),
                // BUTTONS---------------------------------------
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: AppColors.complement,
                      foregroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                    ),
                    onPressed: _submit,
                    child:
                        Text(authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                  ),
                //switch between sign in/ up---------------------------
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.additional,
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 4.0),
                  ),
                  onPressed: _switchAuthMode,
                  child: Text(
                      style: TextStyle(fontWeight: FontWeight.bold),
                      '${authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
