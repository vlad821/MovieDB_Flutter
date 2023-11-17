import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies/screens/auth/my_button.dart';
import 'package:movies/screens/auth/my_textfield.dart';
import 'package:movies/screens/auth/square_tile.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  LoginPage({super.key, this.onTap});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  void signUserIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.red,
          title: Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Container(
           decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 123, 5, 5),
                Color.fromARGB(255, 60, 2, 2)
              ], // Change colors as needed
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
        
                  // logo
                  const Icon(
                    Icons.lock,
                    size: 100,
                  ),
        
                  const SizedBox(height: 50),
        
                  // welcome back, you've been missed!
                  Text(
                    'Welcome back you\'ve been missed!',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      fontSize: 16,
                    ),
                  ),
        
                  const SizedBox(height: 25),
        
                  // username textfield
                  MyTextField(
                    controller: emailController,
                    hintText: 'Username',
                    obscureText: false,
                  ),
        
                  const SizedBox(height: 10),
        
                  // password textfield
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
        
                  const SizedBox(height: 10),
        
                  // forgot password?
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot Password?',
                          style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
                        ),
                      ],
                    ),
                  ),
        
                  const SizedBox(height: 10),
        
                  // sign in button
                  MyButton(
                    text:"Sign In",
                    onTap: signUserIn,
                  ),
        
                  const SizedBox(height: 15),
        
                  // or continue with
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Or continue with',
                            style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ],
                    ),
                  ),
        
                  const SizedBox(height: 50),
        
                  // google + apple sign in buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      // google button
                      SquareTile(imagePath: 'lib/images/google.png'),
        
                      SizedBox(width: 25),
        
                      // apple button
                     // SquareTile(imagePath: 'lib/images/apple.png')
                    ],
                  ),
        
                  const SizedBox(height: 50),
        
                  // not a member? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member?',
                        style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Register now',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
