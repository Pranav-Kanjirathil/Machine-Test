import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),
                    Center(
                      child: SizedBox(
                        height: 130,
                        width: 150,
                        child: Image.asset(
                          'assets/images/login.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      "Enter Phone Number",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'font3',
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hint: Row(
                          children: [
                            Text(
                              " Enter phone Number",
                              style: TextStyle(
                                fontFamily: 'font1',
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff7D7D7D),
                              ),
                            ),
                            Text(
                              " *",
                              style: TextStyle(
                                fontFamily: 'font2',
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                          fontFamily: 'font3',
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          height: 1.5,
                        ),
                        children: [
                          const TextSpan(
                            text: "By Continuing, I agree to TotalX's ",
                          ),
                          TextSpan(
                            text: "Terms and condition",
                            style: TextStyle(
                              color: Colors.blue.shade300,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          const TextSpan(text: " & "),
                          TextSpan(
                            text: "privacy policy",
                            style: TextStyle(
                              color: Colors.blue.shade300,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          "Get OTP",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'font3',
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
      ),
    );
  }
}
