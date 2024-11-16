import 'package:flutter/material.dart';
import 'package:game_sharing/global/show_alert_dialog.dart';
import 'package:game_sharing/page/forgot.dart';
import 'package:game_sharing/page/home.dart';
import 'package:game_sharing/page/register.dart';
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

  final _formKey = GlobalKey<FormState>();
  bool _obscureOption = true;

  bool _login() {
    final userId = userIdController.text;
    final userPassword = userPasswordController.text;
    if (userId == "null" || userPassword =="null") {
      return false;
    }
    return true;
  }


  @override
  void initState() {
    userIdController = TextEditingController();
    userPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    userIdController.dispose();
    userPasswordController.dispose();
    super.dispose();
  }

  Future<void> _takeUserInfoFromRegister(BuildContext context) async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const RegisterPage()));

    if (!context.mounted) return;
    if (result != null) {
      userIdController.text = result['email'] ?? ''; // null이면 빈 문자열('') 사용
      userPasswordController.text =
          result['password'] ?? ''; // null이면 빈 문자열('') 사용
      print(' 값 가져오기 ${result["email"]}, ${result["password"]}');
    } else {
      print('RegisterPage에서 결과값이 전달되지 않았습니다.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Spacer(),
                // TODO: Image 클릭하면 애니메이션 넣기
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  child: Image.asset(
                    'images/logo.png',
                    width: 200,
                    height: 150,
                  ),
                ),
                const SizedBox(height: 40),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CustomTextField(
                          controller: userIdController,
                          keyboardType: TextInputType.emailAddress,
                          hintText: "사용자 이메일 주소",
                          autoFocus: true,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                !value.contains("@")) {
                              return "이메일을 확인해주세요";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      IntrinsicHeight(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: CustomTextField(
                            controller: userPasswordController,
                            keyboardType: TextInputType.emailAddress,
                            hintText: "사용자 비밀번호",
                            obscureText: _obscureOption,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureOption = !_obscureOption;
                                });
                              },
                              child: _obscureOption ? const Icon(Icons.remove_red_eye) : const Icon(Icons.lock_sharp),
                            ),
                            validator: (value) {
                              if (value == null || value.length < 4) {
                                return "비밀번호를 확인해주세요";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                CustomElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (_login()) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
                        }
                        else {
                          showAlertDialog(context: context, message: "로그인정보를 불러올수없습니다");
                        }
      
                      }
                      ;
                    },
                    text: "로그인"),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgotPage()));
                  },
                  child: const Text(
                    "비밀번호를 잊으셨나요?",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                const Spacer(),
                CustomOutlinedButton(
                    onPressed: () {
                      _takeUserInfoFromRegister(context);
                    },
                    text: "새 계정 만들기"),
                const SizedBox(height: 20),
                const Text(
                  "PlayMate",
                  style: TextStyle(color: Colors.grey),
                ),
                const Spacer()
              ],
            ),
          ));
  }
}
