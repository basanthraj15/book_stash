import 'package:book_stash/Services/auth_services.dart';
import 'package:book_stash/utils/toast.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool _isObscuredPass = true;

  @override
  Widget build(BuildContext context) {
    double ScreenWidth = MediaQuery.of(context).size.width;
    double ScreenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: ScreenHeight * 0.1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset("assets/images/book.jpg"),
                      SizedBox(height: 20),
                      Text(
                        "Hi Welcome Aboard!",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Register your account to use the app",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: emailcontroller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Email"),
                          hintText: "Enter your Email",
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: passwordcontroller,
                        obscureText: _isObscuredPass,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Password"),
                          hintText: "Enter your Password",
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscuredPass
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscuredPass = !_isObscuredPass;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(ScreenWidth * 0.7, 40),
                              backgroundColor:
                                  const Color.fromARGB(255, 8, 23, 49)),
                          onPressed: () async {
                            await AuthServicesHelper.createAccountWithEmail(
                                    emailcontroller.text,
                                    passwordcontroller.text)
                                .then((value) {
                              if (value == "Account created!") {
                                ShowToast.toast(
                                    message: "Account Created Successfully!");
                                Navigator.pushNamedAndRemoveUntil(
                                    context, "/home", (route) => false);
                              } else {
                                ShowToast.toast(message: "Error:$value");
                              }
                            });
                          },
                          child: Text(
                            "Signup",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account?"),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "/login");
                              },
                              child: Text(
                                "Login Now",
                                style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.bold),
                              ))
                        ],
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
  }

  @override
  void dispose() {
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }
}
