import 'package:flutter/material.dart';
import 'package:shop_app1/screens/products_overview_screen.dart';
import 'package:shop_app1/service/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void singIn() async {
    final success = await Services.of(context)
        .authService
        .singIn(_emailController.text.trim(), _passwordController.text.trim());

    if (success) {
      await Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => const ProductsOverViewScreen()));
    } else {
      showSnackBar('something went wrong by sign in');
    }
  }

  void singUp() async {
    print('this is running first');
    final success = await Services.of(context)
        .authService
        .signUp(_emailController.text.trim(), _passwordController.text.trim());

    if (success) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => const ProductsOverViewScreen()));
    }else {
      showSnackBar('Something went wrong by sign up');
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('LogIn'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'email',
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.secondary)),
                prefixIcon: const Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.password),
                  labelText: 'password',
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.secondary)),
                  floatingLabelBehavior: FloatingLabelBehavior.auto),
              keyboardType: TextInputType.visiblePassword,
              controller: _passwordController,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary
                ])),
                child: ElevatedButton.icon(
                  onPressed: () => singIn(),
                  icon: const Icon(Icons.login),
                  label: const Text('Sign In'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Theme.of(context).colorScheme.primary;
                        }
                        return Colors.transparent;
                      },
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Theme.of(context).colorScheme.secondary,
                  Theme.of(context).colorScheme.primary,
                ])),
                child: ElevatedButton.icon(
                  onPressed: () => singUp(),
                  icon:
                      const Icon(IconData(0xe08c, fontFamily: 'MaterialIcons')),
                  label: const Text('Sign Up'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Theme.of(context).colorScheme.primary;
                        }
                        return Colors.transparent;
                      },
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
