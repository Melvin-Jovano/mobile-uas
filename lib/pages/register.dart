import 'package:flutter/material.dart';
import 'package:mobile_uas/config/pallete.dart';
import 'package:mobile_uas/pages/login.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.primary,
        leadingWidth: 100,
        leading: Row(
          children: [
            const SizedBox(width: 10,),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },
              child: const Row(
                children: [
                  Icon(Icons.arrow_back_ios),
                  Text('Login'),
                ],
              ),
            )
          ],
        ),
      ),
      backgroundColor: Pallete.primary,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/register.jpeg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken)
          )
        ),
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Sign Up', style: TextStyle(
                  fontSize: 26
                )),
                const SizedBox(height: 25,),
                TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    hintText: 'Username',
                    hintStyle: TextStyle(
                      color: Colors.white,
                    )
                  ),
                ),
                const SizedBox(height: 15,),
                TextField(
                  obscureText: true,
                  autocorrect: false,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      color: Colors.white,
                    )
                  ),
                ),
                const SizedBox(height: 25,),
                InkWell(
                  onTap: () {
                    if(usernameController.text.isEmpty || passwordController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('All inputs must be filled'),
                      ));
                      return;
                    }
                    Navigator.pushReplacement(
                      context, 
                      MaterialPageRoute(
                        builder: (_) => const Login()
                      )
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child:  const Text('Sign Up'),
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