import 'package:didon/categorie/categoryDetailScreen.dart';
import 'package:didon/main.dart';
import 'package:didon/signup.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final List<Category> categories = [
  Category(
  'Verrerie',
  'assets/images/a.png',
  [
    Product(
      'Hamac de Jardin',
      'Détendez-vous avec style dans ce confortable hamac de jardin. Parfait pour les après-midis paresseux au soleil.',
      'assets/proposal.pdf',
      [
        'assets/images/pic.jpg',
        'assets/images/picc.jpg',
        'assets/images/piccc.jpg',
      ]
    ),
    Product(
      'Ensemble de Salle à Manger Extérieur',
      'Profitez de vos repas en plein air avec cet élégant ensemble de salle à manger. Durable et résistant aux intempéries pour une utilisation toute l\'année.',
      'assets/test.pdf',
      [
        'assets/images/pic.jpg',
        'assets/images/picc.jpg',
        'assets/images/piccc.jpg',
      ]
    ),
    Product(
      'Lampes Solaires de Jardin',
      'Illuminatez votre jardin avec ces lampes solaires écologiques. Embellissez votre espace extérieur.',
      'assets/proposal.pdf',
      [
        'assets/images/pic.jpg',
        'assets/images/picc.jpg',
        'assets/images/piccc.jpg',
      ]
    ),
    Product(
      'Set d\'Outils de Jardin',
      'Équipez-vous d\'outils de jardin essentiels. Idéal pour entretenir votre oasis extérieure.',
      'assets/proposal.pdf',
      [
        'assets/images/pic.jpg',
        'assets/images/picc.jpg',
        'assets/images/piccc.jpg',
      ]
    ),
  ],
),

Category(
  'Porcelaine',
  'assets/images/j.png',
  [
    Product(
      'Set de Batterie de Cuisine en Acier Inoxydable',
      'Modernisez votre cuisine avec ce set de batterie de cuisine en acier inoxydable élégant. Parfait pour tout chef.',
      'assets/proposal.pdf',
      [
        'assets/images/pic.jpg',
        'assets/images/picc.jpg',
        'assets/images/piccc.jpg',
      ]
    ),
    Product(
      'Machine à Café',
      'Commencez bien votre journée avec cette machine à café dernier cri. Préparez un délicieux café chez vous.',
      'assets/proposal.pdf',
      [
        'assets/images/pic.jpg',
        'assets/images/picc.jpg',
        'assets/images/piccc.jpg',
      ]
    ),
  ],
),

Category(
  'Couverts de Table',
  'assets/images/v.png',
  [
    Product(
      'Organisateur de Placard',
      'Maximisez l\'espace de votre placard avec cet organisateur polyvalent. Rangez vêtements, chaussures et accessoires.',
      'assets/proposal.pdf',
      [
        'assets/images/pic.jpg',
        'assets/images/picc.jpg',
        'assets/images/piccc.jpg',
      ]
    ),
    Product(
      'Bacs de Rangement Empilables',
      'Gardez votre maison bien rangée avec ces bacs de rangement empilables. Idéaux pour organiser n\'importe quelle pièce.',
      'assets/proposal.pdf',
      [
        'assets/images/pic.jpg',
        'assets/images/picc.jpg',
        'assets/images/piccc.jpg',
      ]
    ),
  ],
),

Category(
  'Équipements de Cuisine',
  'assets/images/l.png',
  [
    Product(
      'Coussins Décoratifs',
      'Embellissez votre espace de vie avec ces élégants coussins décoratifs. Ajoutez de la couleur et du confort.',
      'assets/proposal.pdf',
      [
        'assets/images/pic.jpg',
        'assets/images/picc.jpg',
        'assets/images/piccc.jpg',
      ]
    ),
    Product(
      'Impressions Murales Artistiques',
      'Transformez vos murs avec ces impressions artistiques captivantes. Choisissez parmi une variété de designs.',
      'assets/proposal.pdf',
      [
        'assets/images/pic.jpg',
        'assets/images/picc.jpg',
        'assets/images/piccc.jpg',
      ]
    ),
  ],
),

Category(
  'Mobilier',
  'assets/images/x.png',
  [
    Product(
      'Moulin à Café',
      'Moudre des grains de café frais à la maison avec ce moulin à café haut de gamme. Profitez de saveurs riches.',
      'assets/proposal.pdf',
      [
        'assets/images/pic.jpg',
        'assets/images/picc.jpg',
        'assets/images/piccc.jpg',
      ]
    ),
    Product(
      'Machine à Espresso',
      'Créez des boissons espresso de qualité barista avec cette machine à espresso. Rehaussez votre expérience café.',
      'assets/proposal.pdf',
      [
        'assets/images/pic.jpg',
        'assets/images/picc.jpg',
        'assets/images/piccc.jpg',
      ]
    ),
  ],
),





    // Add more categories and products as needed
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          // Background image covering the entire screen
          Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bgg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
          GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 75,
            mainAxisSpacing: 6,
            children: categories.map((category) {
            return GestureDetector(
            onTap: () {
              // Navigate to ProductScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductScreen(category.products),
                ),
              );
            },
                child: HoverContainer(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1.0,
                      ),
                    ),
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          category.imagePath,
                          width: 300,
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 8),
                        Text(
                          category.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Naviguer vers la page SignUp
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        },
        child: Icon(Icons.arrow_back),
        backgroundColor: Color.fromARGB(255, 81, 45, 10),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

  

  

class HoverContainer extends StatefulWidget {
  final Widget child;

  HoverContainer({required this.child});

  @override
  _HoverContainerState createState() => _HoverContainerState();
}

class _HoverContainerState extends State

<HoverContainer> {
bool _isHovered = false;

@override
    Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _updateHover(true),
      onExit: (_) => _updateHover(false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        transform: _getTransform(),
        child: widget.child,
      ),
    );
  }

  Matrix4 _getTransform() {
    if (_isHovered) {
      return Matrix4.identity()..scale(1.1);
    } else {
      return Matrix4.identity();
    }
  }

  void _updateHover(bool hovered) {
    setState(() {
      _isHovered = hovered;
    });
  }
}

class Category {
  final String title;
  final String imagePath;
  final List<Product> products;

  Category(this.title, this.imagePath, this.products);
}


