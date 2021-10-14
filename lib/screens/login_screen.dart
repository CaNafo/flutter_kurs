import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:movies_app/const.dart';
import 'package:movies_app/providers/auth_provider.dart';
import 'package:movies_app/screens/tabs_screen.dart';

import 'package:movies_app/widgets/login_button_small.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double windowsHeight = MediaQuery.of(context).size.height;
    var emailController = TextEditingController();
    var passController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: Constants.loginScreenPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  "assets/images/movies.jpg",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Svi filmovi na jednom mjestu!",
                style: Theme.of(context).textTheme.headline1,
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: windowsHeight * 0.15,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => LoginDialog(
                        formKey: _formKey,
                        emailController: emailController,
                        passController: passController,
                      ),
                    );
                  },
                  child: const Text("Sign in with Email"),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoginButtonSmall("Google", () {}),
                  const SizedBox(
                    width: 15,
                  ),
                  LoginButtonSmall("Apple ID", () {})
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "By Continuing you agree to the Terms and Conditions",
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginDialog extends StatelessWidget {
  const LoginDialog({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.emailController,
    required this.passController,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController emailController;
  final TextEditingController passController;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Prijava'),
      content: SizedBox(
        height: 150,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Polje e-mail ne smije biti prazno!';
                  }
                  return null;
                },
                controller: emailController,
                decoration: const InputDecoration(hintText: "email@test.com"),
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Polje lozinka ne smije biti prazno!';
                  }
                  return null;
                },
                controller: passController,
                obscureText: true,
                decoration: const InputDecoration(hintText: "lozinka"),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Odustani'),
        ),
        TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              Provider.of<AuthProvider>(context, listen: false)
                  .login(emailController.text, passController.text)
                  .then(
                (value) {
                  if (value) {
                    Navigator.of(context).pop();
                    Navigator.pushReplacementNamed(
                        context, TabsScreen.routeName);
                  } else {
                    Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Pažnja!'),
                        content: const Text(
                            'Došlo je do greške prilikom prijave, provjerite kredencijale i pokušajte ponovo.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
              );
            }
          },
          child: const Text('Prijavi me'),
        ),
      ],
    );
  }
}
