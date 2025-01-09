import 'package:flutter/material.dart';
import 'package:companion_animal/widget/custom_button.dart';
import 'package:companion_animal/widget/custom_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController passwordCheckController;
  Map<String, String> registerInfo = {};

  bool _isVisible = true;
  final _formKey = GlobalKey<FormState>();

  _checkEmail() {
    final email = emailController.text;
    print('$email');
  }

  _register() {
    final email = emailController.text;
    final password = passwordController;
    final passwordCheck = passwordCheckController;
    registerInfo = {
      'email': emailController.text,
      'password': passwordController.text
    };
    print('$email , $password, $passwordCheck');
  }

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordCheckController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    passwordCheckController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("회원가입"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("이메일 주소 입력"),
            const SizedBox(
              height: 10,
            ),
            const Text(
                "회원님에게 연락할 수 있는 이메일 주소를 입력하세요. 이 이메일 주소는 프로필에서 다른 사람에게 공개되지 않습니다"),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomTextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                hintText: "이메일 주소",
                autoFocus: true,
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains("@")) {
                    return "이메일을 확인해주세요";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Visibility(
              visible: _isVisible,
              child: CustomElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _isVisible = false;
                      });
                      _checkEmail();
                    }
                  },
                  text: "다음"),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: Visibility(
                  visible: !_isVisible,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CustomTextField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          hintText: "비밀번호",
                          autoFocus: true,
                          obscureText: true,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 4) {
                              return "비밀번호을 확인해주세요";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CustomTextField(
                          controller: passwordCheckController,
                          keyboardType: TextInputType.visiblePassword,
                          hintText: "비밀번호확인",
                          autoFocus: true,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty || value.isEmpty) {
                              return "비밀번호확인 확인해주세요";
                            }
                            if (passwordCheckController.text != passwordController.text) {
                              return "비밀번호와비밀번허확인이 일치하지않습니다";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 15,),
                      const Text("비밀번호생성규칙", textAlign: TextAlign.center,style: TextStyle(fontSize: 18, color: Colors.grey),),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: RichText(text: const TextSpan(
                         
                          style: TextStyle(fontSize: 13, color: Colors.black,),
                          children: <TextSpan> [
                            TextSpan(text: "최소"),
                            TextSpan(text: " 8자", style: TextStyle(fontWeight:FontWeight.bold)),
                            TextSpan(text: " 반드시 "),
                            TextSpan(text: "대문자,소문자", style: TextStyle(fontWeight:FontWeight.bold)),
                            TextSpan(text: "를 포함합니다 또"),
                            TextSpan(text: " 숫자", style: TextStyle(fontWeight:FontWeight.bold)),
                            TextSpan(text: " 가 하나 이상포함되어야 하며"),
                            TextSpan(text: " 특수 문자", style: TextStyle(fontWeight:FontWeight.bold)),
                            TextSpan(text: " 를 하나이상 포함해야 합니다")
                        
                          ]
                        )),
                      ),
//                       최소 8자
// 반드시 대문자, 소문자를 포함해야 합니다.
// 숫자가 하나 이상 포함되어야 합니다.
// 특수 문자를 하나 이상 포함해야 합니다(예: ! @ # $ % ^ & *).
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  )),
            ),
            const Spacer(),
            Visibility(
              visible: !_isVisible,
              child: CustomElevatedButton(
                            onPressed: () {
                              if(_formKey.currentState!.validate()) {
                                _register();
                              Navigator.pop(context, registerInfo);
                            }
                            },
                            text: "완료"),
            ),
                          const SizedBox(height: 50,)
          ],
        ),
      ),
    );
  }
}
