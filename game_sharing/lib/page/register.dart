import 'package:flutter/material.dart';
import 'package:game_sharing/widget/custom_button.dart';
import 'package:game_sharing/widget/custom_text_field.dart';

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


  verifyEmail() {
    final email = emailController.text;
        setState(() {
      _isVisible = !_isVisible;
    });
    print('$email');
  }

  register() {
    final email = emailController.text;
    final password = passwordController;
    final passwordCheck = passwordCheckController;
    registerInfo = {
      'email': emailController.text,
      'password': passwordController.text
      };
    print('$email , $password, $passwordCheck');

  }

  @override void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordCheckController = TextEditingController();
    super.initState();
  }

  @override void dispose() {
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
        title: Text("회원가입"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text("이메일 주소 입력"),
        SizedBox(height: 10,),
        Text("회원님에게 연락할 수 있는 이메일 주소를 입력하세요. 이 이메일 주소는 프로필에서 다른 사람에게 공개되지 않습니다"),
        SizedBox(height: 15,),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              hintText: "이메일 주소",
              autoFocus: true,
            ),
            ),
        SizedBox(height: 10,),
        Visibility(
          visible: _isVisible,
          child: CustomElevatedButton(onPressed: () {
            verifyEmail();
                
          }, text: "다음"),
        ),
        SizedBox(height: 15,),
        Visibility(
          visible: !_isVisible,
          child:         Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              controller: passwordController,
              keyboardType: TextInputType.visiblePassword,
              hintText: "비밀번호",
              autoFocus: true,
            ),
            ),),
        SizedBox(height: 10),
        Visibility(
          visible: !_isVisible,
          child:         Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              controller: passwordCheckController,
              keyboardType: TextInputType.visiblePassword,
              hintText: "비밀번호확인",
              autoFocus: true,
            ),
            ),),
        SizedBox(height: 15,),
        Spacer(),
        Visibility(
          visible: !_isVisible,
          child: CustomElevatedButton(onPressed: () {
            register();
            Navigator.pop(context, registerInfo);
                
          }, text: "완료"),
        ),  
        Spacer(),    
        
        
      ],),
    );
  }
}