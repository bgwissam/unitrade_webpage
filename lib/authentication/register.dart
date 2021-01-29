import 'package:flutter/material.dart';
import 'package:unitrade_website/services/auth.dart';
import 'package:unitrade_website/shared/string.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = new GlobalKey<FormState>();
  String fullName, email, password, message;
  List<String> roles = [];
  double columnVerticalDistance = 15.0;
  AuthServices _auth = new AuthServices();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(REGISTER),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Full Name
            Container(
              child: TextFormField(
                initialValue: '',
                decoration: InputDecoration(
                  labelText: FULL_NAME,
                  fillColor: Colors.grey[200],
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide: BorderSide(color: Colors.blue)),
                ),
                validator: (val) => val.isEmpty ? FULL_NAME_VALIDATION : null,
                onSaved: (val) {
                  setState(() {
                    fullName = val;
                  });
                },
              ),
            ),
            SizedBox(
              height: columnVerticalDistance,
            ),
            //Email Address
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
            //Password
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
            //Current Roles
            Container(
              child: TextFormField(
                initialValue: '',
                decoration: InputDecoration(
                  labelText: ROLES,
                  fillColor: Colors.grey[200],
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide: BorderSide(color: Colors.blue)),
                ),
                onSaved: (val) {
                  setState(() {
                    roles.add(val);
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
                    var result = await _auth.registerWithEmailandPassword(fullName: fullName, emailAddress: email, password: password, roles: roles);
                    print('The result is: $result');
                    if (result != null) {
                      setState(() {
                        Navigator.pushNamed(context, '/home');
                      });
                    } else {
                      message = result;
                    }
                  } else {
                    print('you need to fill all the necessary fields');
                  }
                },
                child: Text(REGISTER),
              ),
            ),
            SizedBox(
              height: columnVerticalDistance,
            ),
            message != null
                ? Container(
                    width: 250.0,
                    child: Text(message),
                  )
                : Container(),
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
