import 'package:bookshop/views/dashboardView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bookshop/appBar.dart';
import 'package:bookshop/views/registerUser.dart';
import 'package:bookshop/controllers/DbController.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bookshop/views/registerUser.dart';
import 'package:bookshop/views/accountView.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscured = true;

  final CollectionReference allUsers = FirebaseFirestore.instance.collection(
      'Users');

  bool verifyPassword(String passwordInDB, String inputPassword){
    return passwordInDB == (inputPassword);
  }

  buildLoginPage() {
    return Expanded(
        child: Padding(padding: EdgeInsets.all(10),
            child: StreamBuilder<List<QuerySnapshot>>(
              stream: CombineLatestStream.list([allUsers.snapshots()]),
              builder: (context, snapshot) {
                var dbUsers = snapshot.data![0].docs;
                var usersList = [
                  ...dbUsers.map((customer) =>
                  {
                    'id': customer.id,
                    'first_name': customer['first_name'],
                    'last_name': customer['last_name'],
                    'phone_number': customer['phone_number'],
                    'email': customer['email'],
                    'password_hash': customer['password_hash'],
                    'wishList': customer['wishList'],
                    'cart': customer['cart'],
                    'type': 'user'
                  }),
                ];

                final userEmail = _emailController.text;
                final userPassword = _passwordController.text;
                String currentUserID = findUser(usersList, userEmail)!;

                var loginColumnView = Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(50.0),
                      child: Container(
                        color: Colors.yellow.shade50,
                        child: TextField(
                          controller: _emailController,
                          decoration: InputDecoration(labelText: 'Email:'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(50.0),
                      child: Container(
                        color: Colors.yellow.shade50,
                        child: TextField(
                          controller: _passwordController,
                          obscureText: _obscured,
                          decoration: InputDecoration(
                            labelText: 'Password:',
                            icon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscured = !_obscured;
                                });
                              },
                              icon: Icon(
                                  Icons.remove_red_eye, color: Colors.brown),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 35),
                    Row(
                      children: [
                        SizedBox(width: 30),
                        Flexible(
                          fit: FlexFit.tight,
                          child: ElevatedButton(
                            onPressed: () {
                              if (currentUserID == null) {
                                showDialog(context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('User is not registered'),
                                        content: Text(
                                            'Sorry to inform you, we do not have an account '
                                                'registered to this email please check again or register today!'),
                                        actions: [
                                          TextButton(onPressed: () =>
                                              Navigator.of(context).pop(),
                                              child: Text('Try again')),
                                          TextButton(onPressed: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        RegisterUserPage()));
                                          },
                                              child: Text('Register Now',
                                                style: TextStyle(
                                                    fontWeight: FontWeight
                                                        .bold),))
                                        ],
                                      );
                                    });
                              }
                              //TODO: Routse to main products list page
                              else {
                                var currentUser = getUser(usersList, currentUserID);

                                //!User exists but password is incorrect
                                if(!verifyPassword(currentUser['password'], userPassword)){
                                  showDialog(context: context, builder: (BuildContext builder){
                                    return AlertDialog(
                                     title: Text('Password incorrect'),
                                     content: Text('Oops! Seems like it was the wrong password'),
                                     actions: [
                                       TextButton(onPressed: ()=>Navigator.of(context).pop(), child: Text('Try again')),

                                       //TODO!! Can we forget the password?? we don't have 2FA so idk maybe with the phone number???
                                       TextButton(onPressed: (){}, child: Text('Forgot Password'))
                                     ],
                                    );
                                  });
                                }
                                //*Passwoed is correct!!!
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> AccountPage(userID: currentUserID,)));
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.brown.shade500,
                              ),
                            ),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        // Text('New to Ruina?', style: TextStyle(color: Colors.white, fontSize: 20),),
                        TextButton(
                          onPressed: () =>
                              Navigator.popAndPushNamed(
                                  context, '/registerUser'),
                          child: Text(
                            'New to Ruina?', style: TextStyle(color: Colors
                              .white, fontSize: 20),
                            // 'Create an Account',
                            // style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
                          ),
                        ),
                        SizedBox(width: 40),
                      ],
                    ),
                  ],
                );
                return loginColumnView;

              },
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: Colors.brown.shade200,
      body: Center(
        child: buildLoginPage(),
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Padding(
        //       padding: EdgeInsets.all(50.0),
        //       child: Container(
        //         color: Colors.yellow.shade50,
        //         child: TextField(
        //           controller: _emailController,
        //           decoration: InputDecoration(labelText: 'Password:'),
        //         ),
        //       ),
        //     ),
        //     Padding(
        //       padding: EdgeInsets.all(50.0),
        //       child: Container(
        //         color: Colors.yellow.shade50,
        //         child: TextField(
        //           controller: _passwordController,
        //           obscureText: _obscured,
        //           decoration: InputDecoration(
        //             labelText: 'Password:',
        //             icon: IconButton(
        //               onPressed: () {
        //                 setState(() {
        //                   _obscured = !_obscured;
        //                 });
        //               },
        //               icon: Icon(Icons.remove_red_eye, color: Colors.brown),
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //     SizedBox(height: 35),
        //     Row(
        //       children: [
        //         SizedBox(width: 30),
        //         Flexible(
        //           fit: FlexFit.tight,
        //           child: ElevatedButton(
        //             onPressed: () {
        //               //TODO: Routse to main products list page
        //             },
        //             style: ButtonStyle(
        //               backgroundColor: MaterialStateProperty.all<Color>(
        //                 Colors.brown.shade500,
        //               ),
        //             ),
        //             child: Text(
        //               'Login',
        //               style: TextStyle(
        //                 fontWeight: FontWeight.bold,
        //                 fontSize: 30,
        //                 color: Colors.white,
        //               ),
        //             ),
        //           ),
        //         ),
        //         SizedBox(width: 10),
        //         // Text('New to Ruina?', style: TextStyle(color: Colors.white, fontSize: 20),),
        //         TextButton(
        //           onPressed: () =>
        //               Navigator.popAndPushNamed(context, '/registerUser'),
        //           child: Text(
        //             'New to Ruina?',
        //             style: TextStyle(color: Colors.white, fontSize: 20),
        //             // 'Create an Account',
        //             // style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
        //           ),
        //         ),
        //         SizedBox(width: 40),
        //       ],
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
