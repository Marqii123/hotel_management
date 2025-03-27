import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin{
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() {
    if (usernameController.text == "user" && passwordController.text == "pass123") {
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid Credrentials!"))
      );
    }
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff005AD0),
      body: AnimatedBackground(
        vsync: this, 
        behaviour: RandomParticleBehaviour(
          options: ParticleOptions(
            spawnMaxRadius: 40,
            spawnMinSpeed: 15,
            particleCount: 80,
            spawnMaxSpeed: 40,
            baseColor: Colors.blue,
          )
        ),
        child: Center(
          child: Container(
          width: 400,
          margin: EdgeInsets.all(50),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.business, 
                size: 80, 
                color: Colors.orange
              ),
              SizedBox(height: 10),
              Text(
                "LOGIN", 
                style: TextStyle(
                  fontSize: 22, 
                  fontWeight: FontWeight.bold)
              ),
              SizedBox(height: 20),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(labelText: 'Username')
              ),
              SizedBox(height: 10),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'), 
                obscureText: true
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 250,
                height: 30,
                child: ElevatedButton(
                  onPressed: login, 
                  child: Text("Login"),
                ),
              ),
              SizedBox(height: 10),
              Text("Don't have an account yet?"),
              TextButton(
                onPressed: () { 
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => RegisterScreen())
                    ); 
                }, 
                child: Text("Register")
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Ionicons.logo_google)),
                  IconButton(onPressed: () {}, icon: Icon(Ionicons.logo_facebook)),
                  IconButton(onPressed: () {}, icon: Icon(Ionicons.logo_apple)),
                ],
              )
            ],
          ),
        ),

        )
        )
    );
  }
}

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff005AD0),
      body: Center(
        child: Container(
          width: 400,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Register", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              TextField(decoration: InputDecoration(labelText: 'Full Name')),
              SizedBox(height: 10),
              TextField(decoration: InputDecoration(labelText: 'Email')),
              SizedBox(height: 10),
              TextField(decoration: InputDecoration(labelText: 'Password'), obscureText: true),
              SizedBox(height: 20),
              ElevatedButton(onPressed: () {}, child: Text("Register")),
              SizedBox(height: 10),
              Text("Already have an account?"),
              TextButton(onPressed: () { Navigator.pop(context); }, child: Text("Login")),
            ],
          ),
        ),
      ),
    );
  }
}
