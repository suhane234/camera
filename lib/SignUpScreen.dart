import 'package:camera/LoginScreen.dart';
import 'package:camera/authentication.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  static const routName = '/SignUp';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formState = GlobalKey();
  TextEditingController _passwordController = new TextEditingController();
  Map<String, String> _authData = {'email': '', 'password': ''};
  _showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('error'),
              content: Text(msg),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text('ok'))
              ],
            ));
  }

  Future<void> _submit() async {
    if (!_formState.currentState.validate()) {
      return;
    }
    _formState.currentState.save();
    try {
      await Provider.of<Authenticate>(context, listen: false)
          .SignUp(_authData['email'], _authData['password']);
    } catch (error) {
      var errorMessage = 'Please try again.';
      _showErrorDialog(errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sign Up "),
          actions: <Widget>[
            FlatButton(
              child: Row(
                children: <Widget>[
                  Text('Login'),
                  Icon(Icons.person_add),
                ],
              ),
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(LoginScreen.routName);
              },
            ),
          ],
        ),
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.blue,
                Colors.blueAccent,
                Colors.lightBlueAccent
              ])),
            ),
            Center(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  height: 300,
                  width: 300,
                  padding: EdgeInsets.all(16),
                  child: Form(
                    key: _formState,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email',
                            ),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.isEmpty || !value.contains('@')) {
                                return ('invalid email address');
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _authData['email'] = value;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Password'),
                            textAlign: TextAlign.center,
                            obscureText: true,
                            controller: _passwordController,
                            validator: (value) {
                              if (value.isEmpty || value.length <= 5) {
                                return ('invalid Password');
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _authData['password'] = value;
                            },
                          ),
                          TextFormField(
                            decoration:
                                InputDecoration(labelText: 'conform password'),
                            textAlign: TextAlign.center,
                            obscureText: true,
                            validator: (value) {
                              if (value.isEmpty ||
                                  value != _passwordController.text) {
                                return ('invalid Password');
                              }
                              return null;
                            },
                            onSaved: (value) {},
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          RaisedButton(
                            color: Colors.blue,
                            textColor: Colors.white,
                            child: Text('Submit'),
                            onPressed: () {
                              _submit();
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
