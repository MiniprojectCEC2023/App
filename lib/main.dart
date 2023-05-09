import 'package:flutter/material.dart';
import 'package:miniapp/connections/mongoconn.dart';
import 'package:miniapp/widgets/home.dart';
import 'global/globals.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoUtils.connect();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student App"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(12, 86, 126, 0.545),
        leading: Icon(Icons.cabin),
        elevation: 20,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              alignment: Alignment.center,
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromRGBO(12, 86, 126, 0.545),
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 249, 239, 239),
                    offset: Offset(5, 5),
                    blurRadius: 5,
                  )
                ],
              ),
              child: Column(
                children: [
                  Text(
                    "Login here",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "username",
                      hintText: "username",
                    ),
                    controller: usernameController,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "password",
                      hintText: "password",
                    ),
                    obscureText: true,
                    maxLength: 11,
                    controller: passwordController,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        onPressed: () async {
                          final collection =
                              MongoUtils.db.collection('student');
                          var username = usernameController.text;
                          var password = passwordController.text;

                          var result = await collection.findOne(
                              {'name': username, 'register_number': password});

                          if (result != null) {
                            print('Login success!');
                            registerNumber = passwordController.text;
                            name = usernameController.text;
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()),
                            );
                          } else {
                            print('Invalid username or password');
                          }
                        },
                        child: Text("Login"),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Color.fromRGBO(12, 86, 126, 0.545),
                          ),
                          minimumSize: MaterialStateProperty.all(Size(90, 45)),
                          textStyle: MaterialStateProperty.all(
                            TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
