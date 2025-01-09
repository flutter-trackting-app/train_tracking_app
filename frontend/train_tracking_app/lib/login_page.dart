import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:train_tracking_app/homepage.dart';
import 'package:train_tracking_app/sign_up_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  Color _emailLabelColor = Colors.grey;
  Color _emailPrefixIconColor = Colors.grey;
  Color _passwordLabelColor = Colors.grey;
  Color _passwordPrefixIconColor = Colors.grey;

  @override
  void initState() {
    super.initState();

    _emailFocusNode.addListener(() {
      setState(() {
        if (_emailFocusNode.hasFocus) {
          _emailLabelColor = Colors.blue;
          _emailPrefixIconColor = Colors.blue;
        } else {
          _emailLabelColor = Colors.grey;
          _emailPrefixIconColor = Colors.grey;
        }
      });
    });

    _passwordFocusNode.addListener(() {
      setState(() {
        if (_passwordFocusNode.hasFocus) {
          _passwordLabelColor = Colors.blue;
          _passwordPrefixIconColor = Colors.blue;
        } else {
          _passwordLabelColor = Colors.grey;
          _passwordPrefixIconColor = Colors.grey;
        }
      });
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Sign In"),
      // ),
      body: SizedBox(
        width: screenWidth,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
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
                TextFormField(
                  controller: emailController,
                  focusNode: _emailFocusNode,
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle:
                        TextStyle(color: _emailLabelColor, fontSize: 16),
                    hintText: "Enter your email",
                    hintStyle:
                        const TextStyle(color: Colors.grey, fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.transparent, width: 2.0),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    prefixIcon: Icon(Icons.email, color: _emailPrefixIconColor),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                TextFormField(
                  controller: passwordController,
                  focusNode: _passwordFocusNode,
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle:
                        TextStyle(color: _passwordLabelColor, fontSize: 16),
                    hintText: "Enter your password",
                    hintStyle:
                        const TextStyle(color: Colors.grey, fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.transparent, width: 2.0),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    prefixIcon:
                        Icon(Icons.lock, color: _passwordPrefixIconColor),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      const hardcodedEmail = "username";
                      const hardcodedPassword = "123";

                      if (formKey.currentState?.validate() ?? false) {
                        if (emailController.text == hardcodedEmail &&
                            passwordController.text == hardcodedPassword) {
                          Fluttertoast.showToast(
                            msg: "Login Successful",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        } else {
                          Fluttertoast.showToast(
                            msg: "Invalid username or password",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                          );
                        }
                      } else {
                        Fluttertoast.showToast(
                          msg: "Please enter valid credentials",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                        );
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
                    child: const Text("Sign in"),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Column(
                      children: [
                        const Text(
                          "Don't have an account ?",
                          style: TextStyle(fontSize: 12),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpPage()),
                            );
                          },
                          child: const Text(
                            'Sign up',
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
