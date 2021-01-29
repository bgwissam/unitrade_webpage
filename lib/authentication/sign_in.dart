import 'package:flutter/material.dart';
import 'package:unitrade_website/authentication/authenticate.dart';
import 'package:unitrade_website/services/auth.dart';
import 'package:unitrade_website/shared/string.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = new GlobalKey<FormState>();
  String email, password, message;
  double columnVerticalDistance = 15.0;
  AuthServices _auth = new AuthServices();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(SIGN_IN),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: TextFormField(
                initialValue: '',
                decoration: InputDecoration(
                  labelText: USER_NAME,
                  fillColor: Colors.grey[200],
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide: BorderSide(color: Colors.blue)),
                ),
                validator: (val) => val.isEmpty ? USER_NAME_VALIDATION : null,
                onSaved: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
            ),
            SizedBox(
              height: columnVerticalDistance,
            ),
            Container(
              child: TextFormField(
                initialValue: '',
                obscureText: true,
                decoration: InputDecoration(
                  labelText: PASSWORD,
                  fillColor: Colors.grey[200],
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide: BorderSide(color: Colors.blue)),
                ),
                validator: (val) => val.isEmpty ? PASSWORD_VALIDATION : null,
                onSaved: (val) {
                  setState(() {
                    password = val;
                  });
                },
              ),
            ),
            SizedBox(
              height: columnVerticalDistance,
            ),
            Container(
              width: 250.0,
              child: FlatButton(
                color: Colors.greenAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    var result = await _auth.signInWithUserNameandPassword(email, password);
                    if(result.uid != null) {
                      setState(() {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Authentication(userId: result.uid,)));
                      });
                    } else {
                      message = result;
                    }
                  } else {
                    print('you need to fill all the necessary fields');
                  }
                },
                child: Text(LOG_IN),
              ),
            ),
            SizedBox(height: columnVerticalDistance,),
            message != null ?Container(
              width: 250.0,
              child: Text(message),
            ): Container(),
          ],
        ),
      ),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(CLOSE),
        ),
      ],
    );
  }
}
