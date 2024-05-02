import 'dart:ui';
import 'package:didon/categorie/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class SignUp extends StatefulWidget {
  final Function onLogInSelected;

  SignUp({required this.onLogInSelected});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  bool isParticulier = false;
  bool isProfessionnel = false;

  Future<void> _saveUserData() async {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String phone = _phoneController.text.trim();
    String enteredPassword = _passwordController.text.trim();
    String defaultPassword = 'kenza';

    if (name.isEmpty || email.isEmpty || phone.isEmpty || enteredPassword.isEmpty) {
      // Show error message if any field is empty
      showDialog(
        context: context,
        builder: (context) => Dialog(
        backgroundColor: Colors.transparent, // Make the dialog background transparent
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Apply blur effect
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2), // Set the dialog background color with opacity
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center, // Center align content vertically
              crossAxisAlignment: CrossAxisAlignment.center, // Center align content horizontally
              children: [
                Text(
                  'Erreur',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 134, 0, 0),
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Merci de remplir tous les champs.',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'OK',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    return;
    }

    if (enteredPassword != defaultPassword) {
      // Show error message if password is incorrect
      showDialog(
        context: context,
        builder: (context) => Dialog(
        backgroundColor: Colors.transparent, // Make the dialog background transparent
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Apply blur effect
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2), // Set the dialog background color with opacity
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center, // Center align content vertically
              crossAxisAlignment: CrossAxisAlignment.center, // Center align content horizontally
              children: [
                Text(
                  'Erreur',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 134, 0, 0),
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Mot de passe incorrect !',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'OK',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Save user data to Firestore
      await FirebaseFirestore.instance.collection('users').add({
        'name': name,
        'email': email,
        'phone': phone,
        'accountType': isParticulier ? 'Particulier' : 'Professionnel',
      });

      print('User data saved successfully!');

      // Navigate to homePage after successful save
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } catch (e) {
      print('Error saving user data: $e');
      // Handle error saving data
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Erreur'),
          content: Text('Échec de l\'enregistrement des données. Veuillez réessayer.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.all(size.height > 770 ? 64 : size.height > 670 ? 32 : 16),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
            height: size.height * (size.height > 770 ? 0.7 : size.height > 670 ? 0.8 : 0.9),
              width: 500,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1.0,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Catalogue",
                      style: TextStyle(
                        fontSize: 29,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: 30,
                      child: Divider(
                        color: Color.fromARGB(255, 81, 45, 10),
                        thickness: 2,
                      ),
                    ),
                    SizedBox(height: 19),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'Nom',
                        labelText: 'Nom',
                        labelStyle: TextStyle(color: Colors.white),
                        suffixIcon: Icon(Icons.person_outline, color: Colors.white),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 19),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.white),
                        suffixIcon: Icon(Icons.mail_outline, color: Colors.white),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 19),
                    TextField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        hintText: 'Numéro de téléphone',
                        labelText: 'Numéro de téléphone',
                        labelStyle: TextStyle(color: Colors.white),
                        suffixIcon: Icon(Icons.phone, color: Colors.white),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 19),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Mot de passe',
                        labelText: 'Mot de passe',
                        labelStyle: TextStyle(color: Colors.white),
                        suffixIcon: Icon(Icons.lock_outline, color: Colors.white),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 19),
                     Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Checkbox(
                                value: isParticulier,
                                onChanged: (newValue) {
                                  setState(() {
                                    isParticulier = newValue!;
                                    if (newValue!) {
                                      isProfessionnel = false;
                                    }
                                  });
                                },
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              Text(
                                'Je suis particulier',
                                style: TextStyle(color: Colors.white , fontSize:16),
                              ),
                              SizedBox(width: 16),
                              Checkbox(
                                value: isProfessionnel,
                                onChanged: (newValue) {
                                  setState(() {
                                    isProfessionnel = newValue!;
                                    if (newValue!) {
                                      isParticulier = false;
                                    }
                                  });
                                },
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              Text(
                                'Je suis professionnel',
                                style: TextStyle(color: Colors.white, fontSize:16 ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    _isLoading
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: _saveUserData,
                            child: Text(
                              'Valider',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 81, 45, 10),
                              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
