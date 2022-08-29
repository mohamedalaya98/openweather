import 'package:flutter/material.dart';
import 'package:openweather/constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: kDefaultPadding * 2),
              Container(
                height: 150,
                width: 190,
                padding: const EdgeInsets.only(top: 40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                ),
                child: Center(
                  child: Image.asset('assets/images/logo.png'),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  top: kDefaultPadding / 2,
                  left: kDefaultPadding,
                ),
              ),
              const SizedBox(height: kDefaultPadding * 1.5),
              Padding(
                padding: const EdgeInsets.only(
                  top: kDefaultPadding * 2,
                  left: kDefaultPadding * 1.5,
                ),
                child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Text(
                          "Enter your username or email address",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: kDefaultPadding / 2),
                        SizedBox(
                          width: 330,
                          height: 60,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: "Username or email address",
                              labelStyle: TextStyle(
                                color: Colors.black45,
                                fontSize: 13,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                borderSide: BorderSide(
                                  color: Color(0xffADADAD),
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const SizedBox(height: kDefaultPadding * 1.5),
                            const Text(
                              "Enter your password",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: kDefaultPadding / 2),
                            SizedBox(
                              width: 330,
                              height: 60,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  labelText: "Enter your password",
                                  labelStyle: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 13,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    borderSide: BorderSide(
                                      color: Color(0xffADADAD),
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.emailAddress,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: kDefaultPadding * 2),
              ElevatedButton(
                // ignore: sort_child_properties_last
                child: const Padding(
                  padding: EdgeInsets.only(
                    left: kDefaultPadding * 6.5,
                    right: kDefaultPadding * 6.5,
                    top: kDefaultPadding,
                    bottom: kDefaultPadding,
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  print('Pressed');
                  Navigator.pushReplacementNamed(context, '/home');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
