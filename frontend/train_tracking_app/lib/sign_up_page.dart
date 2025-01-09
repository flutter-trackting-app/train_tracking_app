import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:train_tracking_app/login_page.dart';
import 'package:train_tracking_app/services/auth_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  Color _usernameLabelColor = Colors.grey;
  Color _emailLabelColor = Colors.grey;
  Color _passwordLabelColor = Colors.grey;
  Color _confirmPasswordLabelColor = Colors.grey;

  Color _usernamePrefixIconColor = Colors.grey;
  Color _emailPrefixIconColor = Colors.grey;
  Color _passwordPrefixIconColor = Colors.grey;
  Color _confirmPasswordPrefixIconColor = Colors.grey;

  @override
  void initState() {
    super.initState();

    _usernameFocusNode.addListener(() {
      setState(() {
        _usernameLabelColor =
            _usernameFocusNode.hasFocus ? Colors.blue : Colors.grey;
        _usernamePrefixIconColor =
            _usernameFocusNode.hasFocus ? Colors.blue : Colors.grey;
      });
    });

    _emailFocusNode.addListener(() {
      setState(() {
        _emailLabelColor = _emailFocusNode.hasFocus ? Colors.blue : Colors.grey;
        _emailPrefixIconColor =
            _emailFocusNode.hasFocus ? Colors.blue : Colors.grey;
      });
    });

    _passwordFocusNode.addListener(() {
      setState(() {
        _passwordLabelColor =
            _passwordFocusNode.hasFocus ? Colors.blue : Colors.grey;
        _passwordPrefixIconColor =
            _passwordFocusNode.hasFocus ? Colors.blue : Colors.grey;
      });
    });

    _confirmPasswordFocusNode.addListener(() {
      setState(() {
        _confirmPasswordLabelColor =
            _confirmPasswordFocusNode.hasFocus ? Colors.blue : Colors.grey;
        _confirmPasswordPrefixIconColor =
            _confirmPasswordFocusNode.hasFocus ? Colors.blue : Colors.grey;
      });
    });
  }

  @override
  void dispose() {
    _usernameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Sign Up"),
      // ),
      body: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 30),
                  child: const Image(
                    image: AssetImage(
                      'assets/images/tta_logo.png',
                    ),
                    // width: 200,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.4,
                  width: screenWidth,
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: usernameController,
                            focusNode: _usernameFocusNode,
                            decoration: InputDecoration(
                              labelText: "Username",
                              labelStyle: TextStyle(
                                  color: _usernameLabelColor, fontSize: 16),
                              hintText: "Enter your username",
                              hintStyle: const TextStyle(
                                  color: Colors.grey, fontSize: 14),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.transparent, width: 2.0),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.blue, width: 2.0),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              prefixIcon: Icon(Icons.person,
                                  color: _usernamePrefixIconColor),
                              filled: true,
                              fillColor: Colors.grey.shade100,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a username';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: emailController,
                            focusNode: _emailFocusNode,
                            decoration: InputDecoration(
                              labelText: "Email",
                              labelStyle: TextStyle(
                                  color: _emailLabelColor, fontSize: 16),
                              hintText: "Enter your email",
                              hintStyle: const TextStyle(
                                  color: Colors.grey, fontSize: 14),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.transparent, width: 2.0),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.blue, width: 2.0),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              prefixIcon: Icon(Icons.email,
                                  color: _emailPrefixIconColor),
                              filled: true,
                              fillColor: Colors.grey.shade100,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an email';
                              }
                              if (!RegExp(
                                      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                                  .hasMatch(value)) {
                                return 'Enter a valid email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: passwordController,
                            focusNode: _passwordFocusNode,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: TextStyle(
                                  color: _passwordLabelColor, fontSize: 16),
                              hintText: "Enter your password",
                              hintStyle: const TextStyle(
                                  color: Colors.grey, fontSize: 14),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.transparent, width: 2.0),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.blue, width: 2.0),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              prefixIcon: Icon(Icons.lock,
                                  color: _passwordPrefixIconColor),
                              filled: true,
                              fillColor: Colors.grey.shade100,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a password';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: confirmPasswordController,
                            focusNode: _confirmPasswordFocusNode,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "Confirm Password",
                              labelStyle: TextStyle(
                                  color: _confirmPasswordLabelColor,
                                  fontSize: 16),
                              hintText: "Confirm your password",
                              hintStyle: const TextStyle(
                                  color: Colors.grey, fontSize: 14),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.transparent, width: 2.0),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.blue, width: 2.0),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              prefixIcon: Icon(Icons.lock,
                                  color: _confirmPasswordPrefixIconColor),
                              filled: true,
                              fillColor: Colors.grey.shade100,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm your password';
                              }
                              if (value != passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        Fluttertoast.showToast(
                          msg: "Sign Up Successful",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                        );

                        final authService = AuthService();
                        final response = await authService.signUp(
                            usernameController.text.trim(),
                            emailController.text.trim(),
                            passwordController.text.trim(),
                            "user");

                        if (response["success"]) {
                          Fluttertoast.showToast(
                            msg: "Sign Up Successful",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                          );

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                        } else {
                          Fluttertoast.showToast(
                            msg: response["message"] ?? "Signup failed",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("Sign up"),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Column(
                      children: [
                        const Text(
                          "Already have an account ?",
                          style: TextStyle(fontSize: 12),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                            );
                          },
                          child: const Text(
                            'Sign in',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
