import 'package:core/models/user_model.dart';
import 'package:core/services/auth_service.dart';
import 'package:core/widgets/core_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class CoreLogin extends StatefulWidget {
  final String url;
  final Function(UserSessionModel?) isSuccess;
  CoreLogin({Key? key, required this.url, required this.isSuccess})
      : super(key: key);

  @override
  _CoreLoginState createState() => _CoreLoginState();
}

class _CoreLoginState extends State<CoreLogin> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();
  final AuthService _authService = AuthService();
  bool loading = false;
  String? _email;
  String? _password;

  void _submit() async {
    final form = this.formKey.currentState!;
    if (form.validate()) {
      form.save();
      setState(() {
        loading = true;
      });
      UserSessionModel? user = await _authService.login(
          url: widget.url, email: _email!, password: _password!);
      setState(() {
        loading = false;
      });
      widget.isSuccess(user);
      if(user != null){
        print('WELCOME ${user.data!.userType}');
      }else{
        print('ERROR!');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: AutofillGroup(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              TextFormField(
                  autofillHints: const <String>[AutofillHints.email],
                  keyboardType: TextInputType.emailAddress,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(passwordFocus);
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(width: 0.5)),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'email'),
                  validator: MultiValidator(
                    [
                      RequiredValidator(errorText: 'required'),
                      EmailValidator(errorText: 'enter a valid email'),
                    ],
                  ),
                  onSaved: (value) => _email = value),
              SizedBox(height: 32.0),
              TextFormField(
                autofillHints: const <String>[AutofillHints.password],
                keyboardType: TextInputType.text,
                obscureText: _obscureText,
                focusNode: passwordFocus,
                validator: RequiredValidator(errorText: 'required'),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(width: 0.5)),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'password',
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                    )),
                onSaved: (value) => _password = value,
              ),
              SizedBox(height: 60.0),
              CoreLoadingButton(
                onPressed: _submit,
                loading: loading,
                child: Text(
                  'Login',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                height: 50,
                width: 250,
              )
            ],
          ),
        ));
  }
}
