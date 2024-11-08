import 'package:flutter/material.dart';
import 'package:game_sharing/global/show_alert_dialog.dart';
import 'package:game_sharing/widget/custom_button.dart';
import 'package:game_sharing/widget/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController userIdController;
  late TextEditingController userPasswordController;

  login() {
    final userId = userIdController.text;
    final userPassword = userPasswordController.text;

    print('$userId, $userPassword');

  }

  @override
  void initState() {
    userIdController = TextEditingController();
    userPasswordController = TextEditingController();
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
          // TODO: Image 클릭하면 애니메이션 넣기
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: Image.asset('images/logo.png',
            width: 200,
            height: 150,),
          ),
          SizedBox(height: 40),
          // TODO: User Input 값에 따른 validator 및 Onchanged 생성
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              controller: userIdController,
              keyboardType: TextInputType.emailAddress,
              hintText: "사용자 이메일 주소",
              autoFocus: true,
            ),
            ),
            SizedBox(height: 10),
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              controller: userPasswordController,
              keyboardType: TextInputType.emailAddress,
              hintText: "사용자 비밀번호",
              obscureText: true,
            ),
            ),
            SizedBox(height: 20),
            CustomElevatedButton(onPressed: login, text: "로그인"),
            SizedBox(height: 10),
            TextButton(onPressed: (){}, child: Text("비밀번호를 잊으셨나요?", style: TextStyle(color: Colors.blue),),),
            Spacer(),
            CustomOutlinedButton(onPressed: (){}, text: "새 계정 만들기"),
            SizedBox(height: 20),
            Text("PlayMate",style: TextStyle(color:Colors.grey),),
            Spacer()
        ],
        ),
      )
    );
  }
}
