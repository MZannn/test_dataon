import 'package:flutter/material.dart';
import 'package:test_dataon/data/models/register_model.dart';
import 'package:test_dataon/pages/register/register_view_model.dart';
import 'package:provider/provider.dart';
import '../../helper/database_helper.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        shadowColor: Colors.black12,
        title: const Text(
          "Sign Up",
        ),
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Consumer<RegisterViewModel>(
                builder: (context, viewModel, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("Email"),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: "Email",
                          focusColor: Colors.deepPurple,
                          contentPadding: const EdgeInsets.all(10),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.deepPurple, width: 1),
                          ),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.grey,
                            width: 0.8,
                          )),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("Password"),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration(
                          hintText: "Password",
                          focusColor: Colors.deepPurple,
                          contentPadding: const EdgeInsets.all(10),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.deepPurple, width: 1),
                          ),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.grey,
                            width: 0.8,
                          )),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 45,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              if (viewModel
                                  .isValidEmail(emailController.text)) {
                                await DatabaseHelper.initializeDatabase();
                                final newRegistration = RegisterModel(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                                await DatabaseHelper.insertRegistration(
                                    newRegistration.toMap());
                                Navigator.pushReplacementNamed(
                                    context, '/login');
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Email is not valid"),
                                  ),
                                );
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  );
                },
              ),
            ),
          )),
    );
  }
}
