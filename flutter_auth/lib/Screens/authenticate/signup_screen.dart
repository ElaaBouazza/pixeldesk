import 'package:flutter/material.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_auth/components/rounded_password_field.dart';
import 'package:flutter_auth/shared/loading.dart';
import 'package:flutter_auth/services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}
class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading ? Loading() : Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.indigoAccent,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/welcomes.gif"),
            fit: BoxFit.cover,                 
          ),
        ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Pixel'),
            ),
            
            SizedBox(height: 130.0),
            RoundedInputField(
              hintText: "Your Email",
              validator: (value) => value.isEmpty ? 'Enter an email' : null,
              onChanged: (value) {setState(() => email = value);},
            ),
            RoundedPasswordField(
              validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
              onChanged: (value) {setState(() => password = value);},
            ),
            RoundedButton(
              text: "SIGNUP",
              press: () async {
                if(_formKey.currentState.validate()){
                    setState(() => loading = true);
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                    if(result == null) {
                      setState(() {
                        loading = false;
                        error = 'Please supply a valid email';
                      });
                    }
                  }
              },
            ),

              ],
            )
        ),
      ), 
    );
  }
}