import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/movie_page_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Signup extends ConsumerStatefulWidget {
  const Signup({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _IsgnupState();
}

var emailController = TextEditingController();
var passwordController = TextEditingController();

class _IsgnupState extends ConsumerState<Signup> {
  @override
  Widget build(BuildContext context) {
    ref.watch(moviePageProvider);
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 50),
            child: Icon(Icons.create),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      spreadRadius: 7,
                      offset: Offset(1, 1),
                      color: Colors.grey.withOpacity(0.2))
                ]),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 15),
                  hintText: '',
                  labelText: 'Email',
                  // prefixIcon: Icon(Icons.email),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.black26, width: 1.0)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white, width: 1.0)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      spreadRadius: 7,
                      offset: Offset(1, 1),
                      color: Colors.grey.withOpacity(0.2))
                ]),
            child: TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 15),
                  hintText: '',
                  labelText: 'password',
                  // prefixIcon: Icon(Icons.password),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.black26, width: 1.0)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white, width: 1.0)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          TextButton(
            onPressed: () {
              ref
                  .read(moviePageProvider.notifier)
                  .register(emailController.text, passwordController.text);
              // .register(emailController.text, passwordController.text);
            },
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(10)),
              // margin: EdgeInsets.only(top: 90),
              child: const Center(
                child: Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: RichText(
                text: TextSpan(
              text: "Have an account?",
              style: TextStyle(color: Colors.grey[500], fontSize: 16),
            )),
          )
        ],
      ),
    );
  }
}
