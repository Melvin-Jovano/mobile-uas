import 'package:flutter/material.dart';
import 'package:mobile_uas/config/pallete.dart';
import 'package:mobile_uas/pages/login.dart';

// ignore: must_be_immutable
class Register extends StatelessWidget {
  Register({super.key});

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
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
                      MaterialPageRoute(builder: (context) => Login()),
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
          body: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Create an account', style: TextStyle(
                    fontSize: 26
                  )),
                  const SizedBox(height: 25,),
                  TextField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Colors.white
                        )
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(96, 62, 62, 62),
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
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Colors.white
                        )
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(96, 62, 62, 62),
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
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Account created, please login...'),
                      ));
                      Navigator.pushReplacement(
                        context, 
                        MaterialPageRoute(
                          builder: (_) => Login()
                        )
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 15
                      ),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(96, 62, 62, 62),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child:  const Text('Sign up'),
                    ),
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