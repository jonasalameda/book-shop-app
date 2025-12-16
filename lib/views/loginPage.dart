import 'package:bookshop/views/adminView.dart';
import 'package:bookshop/views/dashboardView.dart';
import 'package:bookshop/views/homeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bookshop/views/registerUser.dart';
import 'package:bookshop/main.dart';
import 'package:bookshop/controllers/DbController.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bookshop/views/accountView.dart';
import 'package:bookshop/main.dart';
import 'package:bookshop/appBar2.dart';
import 'package:bookshop/common.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bookshop/l10n/app_localizations.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscured = true;
  bool _isLoading = false;

  final CollectionReference allUsers =
      FirebaseFirestore.instance.collection('Users');

  bool verifyPassword(String passwordInDB, String inputPassword) {
    return passwordInDB == inputPassword;
  }

  buildLoginPage() {
    return Column(children: [
      Expanded(
          child: Padding(
              padding: EdgeInsets.all(10),
              child: StreamBuilder<List<QuerySnapshot>>(
                stream: CombineLatestStream.list([allUsers.snapshots()]),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                var dbUsers = snapshot.data![0].docs;
                var usersList = [
                  ...dbUsers.map((customer) {
                    var data = customer.data() as Map<String, dynamic>?;
                    return {
                      'id': customer.id,
                      'first_name': data?['first_name'] ?? '',
                      'last_name': data?['last_name'] ?? '',
                      'phone_number': data?['phone_number'] ?? '',
                      'email': data?['email'] ?? '',
                      'password_hash': data?['password_hash'] ?? '',
                      'wishlist': data?['wishlist'] ?? [],
                      'cart': data?['cart'] ?? [],
                      'role': data?['role'] ?? '',
                      'type': 'user'
                    };
                  }),
                ];
                  var dbUsers = snapshot.data![0].docs;
                  var usersList = [
                    ...dbUsers.map((customer) {
                      var data = customer.data() as Map<String, dynamic>?;
                      return {
                        'id': customer.id,
                        'first_name': data?['first_name'] ?? '',
                        'last_name': data?['last_name'] ?? '',
                        'phone_number': data?['phone_number'] ?? '',
                        'email': data?['email'] ?? '',
                        'password_hash': data?['password_hash'] ?? '',
                        'wishlist': data?['wishlist'] ?? [],
                        'cart': data?['cart'] ?? [],
                        'role': data?['role'] ?? '',
                        'type': 'user'
                      };
                    }),
                  ];

                var loginColumnView = Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.yellow.shade50,
                            borderRadius: BorderRadius.circular(10)),
                        child: TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email:',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.all(10),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.yellow.shade50,
                            borderRadius: BorderRadius.circular(10)),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: _obscured,
                          decoration: InputDecoration(
                            labelText: 'Password:',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.all(10),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscured = !_obscured;
                                });
                              },
                              icon: Icon(
                                _obscured
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.brown,
                              ),
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
                            onPressed: () async {
                              final userEmail =
                                  _emailController.text.toLowerCase();
                              final userPassword = _passwordController.text;
                              if (userEmail.isEmpty || userPassword.isEmpty) {
                                showErrorDialog(
                                    'Empty Fields',
                                    'Please enter both email and password',
                                    context);
                              }
                              String? userID = findUser(usersList, userEmail);
                              currentUserID = userID; // Changed to nullable
                  var loginColumnView = Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.yellow.shade50,
                              borderRadius: BorderRadius.circular(10)),
                          child: TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email:',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.all(10),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.yellow.shade50,
                              borderRadius: BorderRadius.circular(10)),
                          child: TextField(
                            controller: _passwordController,
                            obscureText: _obscured,
                            decoration: InputDecoration(
                              labelText: 'Password:',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.all(10),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscured = !_obscured;
                                  });
                                },
                                icon: Icon(
                                  _obscured
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.brown,
                                ),
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
                                final userEmail = _emailController.text;
                                final userPassword = _passwordController.text;
                                if (userEmail.isEmpty || userPassword.isEmpty) {
                                  _showErrorDialog('Empty Fields',
                                      'Please enter both email and password');
                                }
                                String? currentUserID = findUser(usersList,
                                    userEmail); // Changed to nullable

                              //needed to check
                              // print(userID);
                              // showErrorDialog(userID.toString(), usersList.toString(), context);
                              await loadCurrentUser();
                              if (userID == null) {
                                //showErrorDialog('User is not registered', 'Sorry to inform you, we do not have an account registered to this email please check again or register today!', context);
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('User is not registered'),
                                        content: Text(
                                            'Sorry to inform you, we do not have an account '
                                            'registered to this email please check again or register today!'),
                                        actions: [
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                              child: Text('Try again')),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            RegisterUserPage()));
                                              },
                                              child: Text(
                                                'Register Now',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ))
                                        ],
                                      );
                                    });
                              } else {
                                var currentUser =
                                    getUser(usersList, currentUserID!);
                                if (currentUserID == null) {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('User is not registered'),
                                          content: Text(
                                              'Sorry to inform you, we do not have an account '
                                              'registered to this email please check again or register today!'),
                                          actions: [
                                            TextButton(
                                                onPressed: () =>
                                                    Navigator.of(context).pop(),
                                                child: Text('Try again')),
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              RegisterUserPage()));
                                                },
                                                child: Text(
                                                  'Register Now',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ))
                                          ],
                                        );
                                      });
                                } else {
                                  var currentUser =
                                      getUser(usersList, currentUserID);

                                await loadCurrentUser();
                                bool isCorrectPassword = verifyPassword(
                                    currentUser['password_hash'], userPassword);
                                // User exists but password is incorrect
                                if (!isCorrectPassword) {
                                  showErrorDialog(
                                      'Password incorrect',
                                      'Oops! Seems like it was the wrong password',
                                      context);
                                } else {
                                  // Password is correct
                                  if(currentUser['id'] == 'cpWtMJprI1mqtNey7XGf') //admin
                                  // if (currentUser['user_role'] == 'admin') //admin
                                  {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AdminPage(
                                                userID: currentUserID!)));
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AccountPage(
                                                userID: currentUserID!)));
                                  }
                                }
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
                      ],
                    ),
                    SizedBox(height: 10),
                    TextButton(
                      onPressed: () =>
                          Navigator.popAndPushNamed(context, '/registerUser'),
                      child: Text(
                        'New to Ruina?',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    SizedBox(width: 40),
                  ],
                );
                return loginColumnView;
              },
            )));
                                  bool isCorrectPassword = verifyPassword(
                                      currentUser['password_hash'],
                                      userPassword);
                                  // User exists but password is incorrect
                                  if (!isCorrectPassword) {
                                    _showErrorDialog('Password incorrect',
                                        'Oops! Seems like it was the wrong password');
                                  } else {
                                    // Password is correct
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            // builder: (context) => AccountPage(userID: currentUserID)));
                                            builder: (context) =>
                                                HomeScreen()));
                                  }
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
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
                        ],
                      ),
                      SizedBox(height: 10),
                      TextButton(
                        onPressed: () =>
                            Navigator.popAndPushNamed(context, '/registerUser'),
                        child: Text(
                          'New to Ruina?',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      SizedBox(width: 40),
                    ],
                  );
                  return loginColumnView;
                },
              )))
    ]);
  }

  @override
  void initState() {
    super.initState();
    _initUser();
  }

  Future<void> _initUser() async {
    if (currentUserID.isNotEmpty) {
      currentUser = await getUserById(currentUserID);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: Colors.brown.shade200,
      body: Center(
        child: SingleChildScrollView(
          child: buildLoginPage(),
        ),
      ),
    );
  }
}
