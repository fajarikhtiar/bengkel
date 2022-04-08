import 'package:bengkel/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    handleSignUp() async {
      AuthProvider authProvider =
          Provider.of<AuthProvider>(context, listen: false);

      if (await authProvider.register(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
      )) {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'Gagal Register !',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Icon(
            Icons.login,
            size: 100,
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              prefix: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.person)),
              hintText: 'Your Name',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              prefix: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(Icons.email),
              ),
              hintText: 'Your Email Address',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              prefix: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(Icons.lock),
              ),
              hintText: 'Your Password',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: handleSignUp,
            child: Text('Register'),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Text('Login disini'),
          ),
        ],
      ),
    );
  }
}
