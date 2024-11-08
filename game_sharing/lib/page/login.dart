import 'package:flutter/material.dart';
import 'package:game_sharing/global/show_alert_dialog.dart';
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

    if (userId.isEmpty) {
      return showAlertDialog(context: context, message: "아이디를 입력해주세요!!");
    }
    if (userPassword.isEmpty) {
      return showAlertDialog(context: context, message: "비밀번호를 입력해주세요!!");
    }

  }

  @override
  void initState() {
    userIdController = TextEditingController();
    userPasswordController = TextEditingController();
    super.initState();
  }

  validate(input) {

  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        // TODO: Image 클릭하면 애니메이션 넣기
        AnimatedContainer(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10, vertical:10),
              child: Image.asset('images/logo.png')),
              ),
          ),
        ),
        SizedBox(height: 40,),
        //TODO: TextFormFiled Shape And Padding 수정하기
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          child: CustomTextField(
            onPressed: () {},
            hintText: "이메일",
            onChanged: validate,
            controller: userIdController,
          ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          child: CustomTextField(
            onPressed: () {},
            hintText: "비밀번호",
            onChanged: validate,
            controller: userPasswordController,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          child: CustomeElevatedButton(onPressed: (){}, text: "로그인")),
          Expanded(
            child: Text("PlayMate"),
          )
      ],
      )
    );
  }
}

class CustomeElevatedButton extends StatelessWidget {
  final double? buttonWidth;
  final VoidCallback onPressed;
  final String text;
  
  const CustomeElevatedButton({
    super.key, this.buttonWidth, required this.onPressed, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      width: buttonWidth ?? MediaQuery.of(context).size.width - 100,
      child: ElevatedButton(onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.black,
        splashFactory: NoSplash.splashFactory,
        elevation: 0,
        shadowColor: Colors.transparent
        
      ),
      
       child: Text(text),),
    );
  }
}