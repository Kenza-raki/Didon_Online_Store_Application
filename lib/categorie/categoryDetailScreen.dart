import 'dart:html';
import 'dart:ui';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class ProductScreen extends StatelessWidget {
  final List<Product> products;

  // Background image asset path and container decoration
  final String backgroundImage = 'assets/images/bgg.png';
  final Color containerColor = Colors.white.withOpacity(0.2);
  final Color textColor = Colors.white;
  final Color titleColor = Color.fromARGB(255, 81, 45, 10);

  ProductScreen(this.products);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Set Scaffold background to transparent
      body: Stack(
        children: [
          // Background image covering the entire screen
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Positioned widget for the title and back button
          Positioned(
            top: 40,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context); // Navigate back when back button is pressed
                  },
                ),
                Text(
                  'Products',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 48), // Spacer between title and back button
              ],
            ),
          ),
          // Product list view with styled square containers
          Positioned.fill(
            top: 100, // Adjust top spacing for the product grid
            child: GridView.count(
              crossAxisCount: 4, // Adjust the number of columns as needed
              padding: EdgeInsets.all(8),
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
              children: products.map((product) {
                return Container(
                  decoration: BoxDecoration(
                    color: containerColor,
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1.0,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        color: titleColor,
                        child: Center(
                          child: Text(
                            product.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Description:',
                                    style: TextStyle(
                                      color: textColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(
                                    Icons.insert_drive_file, // Use a file icon from Flutter's Icons
                                    size: 64,
                                    color: Colors.red, // Customize icon color
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Text(
                                product.description,
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Price: \$XX.XX', // Add actual price here
                                    style: TextStyle(
                                      color: textColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ElevatedButton(
                                    onPressed: () {
                                      _showProductDetails(context, product);
                                    },
                                    child: Text(
                                      'Tap to View ',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(
                                          Color.fromARGB(255, 81, 45, 10)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

 void _showProductDetails(BuildContext context, Product product) {
  
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent, // Make the dialog background transparent
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Apply blur effect
          child: Container(
            width: 500, // Set the width to a specific size (adjust as needed)
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9), // Set the dialog background color with opacity
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        
                        child: Center(
                          child: Text(
                            product.name,
                            style: TextStyle(
                              color: Color.fromARGB(255, 81, 45, 10),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                
                SizedBox(height: 16),
                   Container(
                  height: 300,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: product.imageUrls.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Image.network(
                            product.imageUrls[index],
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 8),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Download the PDF file
                        downloadPDF(product.pdfAssetPath);
                  },
                  child: Text("Download to view the full PDF" , style: TextStyle(
                              color: Color.fromARGB(255, 81, 45, 10),
                              
                            ),),
                  
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}


void downloadPDF(String pdfAssetPath) async {
    String? pdfAssetUrl;

    try {
      // Charge le manifeste d'actif pour récupérer l'URL de l'actif
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      final Map<String, dynamic> manifest = jsonDecode(manifestContent);

      if (manifest.containsKey(pdfAssetPath)) {
        // Récupère l'URL de l'actif PDF
        pdfAssetUrl = manifest[pdfAssetPath]![0];
      }
    } catch (e) {
      print('Error loading asset manifest: $e');
    }

    if (pdfAssetUrl != null) {
      // Crée un élément d'ancre pour déclencher le téléchargement
      final anchor = html.AnchorElement(href: pdfAssetUrl)
        ..setAttribute('download', '${pdfAssetPath.split('/').last}')
        ..setAttribute('type', 'application/pdf');

      // Ajoute l'élément d'ancre au corps du document et déclenche le téléchargement
      html.document.body!.append(anchor);
      anchor.click();

      // Nettoie : Supprime l'élément d'ancre du DOM après le téléchargement
      anchor.remove();
    } else {
      print('PDF asset URL not found');
    }
  }



class Product {
  final String name;
  final String description;
  final String pdfAssetPath; // Chemin d'actif PDF
  final List<String> imageUrls; // Liste d'URL d'images

  Product(this.name, this.description, this.pdfAssetPath, this.imageUrls);
}
