import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  double shadowElevation = 5;
  double shadowElevation_ = 5;
  double scaleLogin = 0;
  bool centerLogo = true;
  //this is so cool
  bool isCollapsed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              // Orqa fon rasmi
              Expanded(
                child: Image.asset(
                  'assets/couple_cooking_at_stove_promo.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              // Sozdat akkaunt va Login qismi
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 70,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Image.asset('assets/hansa.png'),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 22),
                          children: [
                            TextSpan(
                              text: "#Uvidimcya",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: "na"),
                            TextSpan(
                              text: "kuxne",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 50),
                      AnimatedPhysicalModel(
                        duration: const Duration(milliseconds: 200),
                        shape: BoxShape.rectangle,
                        color: Colors.transparent,
                        elevation: shadowElevation,
                        shadowColor: Colors.grey,
                        borderRadius: BorderRadius.circular(90),
                        child: GestureDetector(
                          onTapDown: (details) {
                            setState(() {
                              shadowElevation = 0;
                            });
                          },
                          onTapUp: (details) {
                            setState(() {
                              shadowElevation = 5;
                            });
                          },
                          onTap: () {
                            setState(() {
                              scaleLogin = 1;
                              centerLogo = false;
                              isCollapsed = true;
                            });
                          },
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * .9,
                            decoration: BoxDecoration(
                              color: Colors.red.shade700,
                              borderRadius: BorderRadius.circular(90),
                            ),
                            child: const Center(
                              child: Text(
                                "Voyti",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 22,
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.grey,
                              height: 1,
                              width: double.infinity,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text("ili"),
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.grey,
                              height: 1,
                              width: double.infinity,
                            ),
                          ),
                          const SizedBox(
                            width: 22,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * .9,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: Colors.grey.shade400, width: 1),
                          borderRadius: BorderRadius.circular(90),
                        ),
                        child: Center(
                          child: Text(
                            "Sozdat akkaunt",
                            style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Login orqasidan chiqayotgan pastiga Zabili parol yozilgan qismi
          // shu jiyda sal responsivlik buzilgan
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              height: (isCollapsed) ? MediaQuery.of(context).size.height : 0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.fastLinearToSlowEaseIn,
              child: Column(
                children: [
                  const Spacer(),
                  Expanded(
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      width: double.infinity,
                      color: Colors.grey.shade800,
                      child: const Padding(
                        padding: EdgeInsets.only(bottom: 30),
                        child: Text(
                          "Zabili parol?",
                          style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Bu o'rtada joylashgan login qismi animatsiya bolib chiqadigan
          Center(
            child: AnimatedScale(
              duration: const Duration(milliseconds: 200),
              scale: scaleLogin,
              curve: Curves.fastOutSlowIn,
              child: Container(
                margin: EdgeInsets.only(
                    top: (MediaQuery.of(context).size.height / 4.85) + 50,
                    left: 20,
                    right: 20),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                scaleLogin = 0;
                                centerLogo = true;
                                isCollapsed = false;
                              });
                            },
                            child: SizedBox(
                              child: Icon(
                                Icons.close,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const Text(
                      "Vxod v akkaunt",
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const TextField(
                      autofocus: false,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_circle),
                        suffixIcon: Icon(Icons.done),
                        hintText: "Vash Login",
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const TextField(
                      autofocus: false,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.key),
                        suffixIcon: Icon(Icons.remove_red_eye),
                        hintText: "Vash Parol",
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SwitchListTile(
                      value: false,
                      inactiveTrackColor: Colors.grey.shade300,
                      onChanged: (value) {},
                      title: Text(
                        "Ne vixodit iz prolojeniya",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    AnimatedPhysicalModel(
                      duration: const Duration(milliseconds: 200),
                      shape: BoxShape.rectangle,
                      color: Colors.transparent,
                      elevation: shadowElevation_,
                      shadowColor: Colors.grey,
                      borderRadius: BorderRadius.circular(90),
                      child: GestureDetector(
                        onTapDown: (details) {
                          setState(() {
                            shadowElevation_ = 0;
                          });
                        },
                        onTapUp: (details) {
                          setState(() {
                            shadowElevation_ = 5;
                          });
                        },
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * .9,
                          decoration: BoxDecoration(
                            color: Colors.red.shade700,
                            borderRadius: BorderRadius.circular(90),
                          ),
                          child: const Center(
                            child: Text(
                              "Voyti",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Bu joy oynani ortasidagi ikonka
          AnimatedPositioned(
            duration: const Duration(milliseconds: 400),
            left: MediaQuery.of(context).size.width / 2 - 50,
            right: MediaQuery.of(context).size.width / 2 - 50,
            top: (centerLogo)
                ? (MediaQuery.of(context).size.height / 2) - 50
                : MediaQuery.of(context).size.height / 3.5,
            child: ClipOval(
              child: Container(
                color: Colors.white,
                child: Image.asset(
                  'assets/hansa_logo.png',
                  height: 100,
                  width: 100,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
