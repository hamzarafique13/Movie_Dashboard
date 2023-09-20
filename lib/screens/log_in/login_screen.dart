import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/movie_page_provider.dart';
import 'package:flutter_application_1/screens/sign_up/signup_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginState();
}

var emailController = TextEditingController();
var passwordController = TextEditingController();

class _LoginState extends ConsumerState<Login> {
  @override
  Widget build(BuildContext context) {
    ref.watch(moviePageProvider);
    final auth = FirebaseAuth.instance;
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 50),
            // height: 100,
            // width: 200,
            child: const Icon(Icons.login),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      spreadRadius: 7,
                      offset: const Offset(1, 1),
                      color: Colors.grey.withOpacity(0.2))
                ]),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 15),
                  hintText: '',
                  labelText: 'Email',
                  // prefixIcon: Icon(Icons.email),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.black26, width: 1.0)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1.0)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    blurRadius: 10,
                    spreadRadius: 7,
                    offset: const Offset(1, 1),
                    color: Colors.grey.withOpacity(0.2))
              ],
            ),
            child: TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 15),
                  hintText: '',
                  labelText: 'password',
                  // prefixIcon: Icon(Icons.password),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.black26, width: 1.0)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1.0)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          TextButton(
            onPressed: () async {
              try {
                await auth.signInWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text);
              } catch (e) {
                var snackBar = SnackBar(
                  backgroundColor: Colors.red,
                  content: Text((passwordController.text.isEmpty)
                      ? "password cannot be empty"
                      : "password incorrect. please try again"),
                );

                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            child: Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(10)),
              child: const Center(
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Signup())),
            child: RichText(
              text: TextSpan(
                text: "Don\'t have an account?",
                style: TextStyle(color: Colors.grey[500], fontSize: 16),
                children: const [
                  TextSpan(
                    text: "Create",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
