import 'package:avo/constants/regex_patterns.dart';
import 'package:avo/core/cubit/session/session_cubit.dart';
import 'package:avo/core/cubit/user/user_cubit.dart';
import 'package:avo/core/cubit/user/user_state.dart';
import 'package:avo/services/auth/signup_page.dart';
import 'package:avo/services/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _credentialController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _credentialController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Avo")),
      body: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is UserLoggedIn) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Welcome ${state.user.username}")),
            );

            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  lazy: false,
                  create: (_) => SessionCubit()..connect(),
                  child: HomePage(),
                ),
              ),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is UserLoading) {
            return Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "We met\nbefore?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 45,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    Text(
                      "Avo thinks so!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 45,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _credentialController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        hintText: "john.doe_",
                        prefixIcon: Icon(Icons.alternate_email),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "username can't be empty!";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        hintText: "********",
                        prefixIcon: Icon(Icons.password),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password can't be empty!";
                        } else if (!RegexPatterns.passwordRegex.hasMatch(
                          value,
                        )) {
                          return "The password is not valid";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<UserCubit>().login(
                              credential: _credentialController.text.trim(),
                              password: _passwordController.text.trim(),
                            );
                          }
                        },
                        child: Text("LOGIN"),
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => SignupPage()),
                        );
                      },
                      child: Text.rich(
                        style: TextStyle(fontSize: 16),
                        TextSpan(
                          text: 'Don\'t have an account?',
                          children: [
                            TextSpan(
                              text: 'Sign up',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
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
