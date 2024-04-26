import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Candidats',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class Candidate {
  final String name;
  final String description;
  final String party;
  final String imageUrl;

  Candidate({
    required this.name,
    required this.description,
    required this.party,
    required this.imageUrl,
  });
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Candidate> candidates = [
    Candidate(
      name: 'Adewole Adebayo',
      description: 'Candidat sérieux et engagé pour l\'éducation',
      party: 'Parti de l\'éducation',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/b/b0/ADEWOLE_ADEBAYO.jpg',
    ),
    Candidate(
      name: 'Atiku Abubakar',
      description: 'Expert en économie et innovation',
      party: 'Parti de l\'innovation',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/7/76/Atiku_Abubakar-2010_%28cropped%29.jpg',
    ),
    Candidate(
      name: 'Bola Ahmed Tinubu',
      description: 'Passionné par les questions environnementales',
      party: 'Parti vert',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/7/77/Bola_Tinubu_portrait.jpg/800px-Bola_Tinubu_portrait.jpg',
    ),
    Candidate(
      name: 'Rabiu Mussa Kwankwaso',
      description: 'Défenseur des droits de l\'homme',
      party: 'Parti des droits de l\'homme',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/d/d7/Rabiu_Kwankwaso.jpg',
    ),
  ];

  void addCandidate(Candidate candidate) {
    setState(() {
      candidates.add(candidate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Candidats'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 64, 202, 74),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FriendsPage(
                onCandidateAdded: addCandidate,
              ),
            ),
          );
        },
        backgroundColor: Color.fromARGB(255, 33, 187, 56),
        child: Icon(Icons.add),
      ),
      body: Container(
        color: Colors.grey[200], // Fond gris
        child: ListView.builder(
          itemCount: candidates.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    candidates[index].imageUrl,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  candidates[index].name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(candidates[index].description),
                    Text('Parti: ${candidates[index].party}'),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class FriendsPage extends StatelessWidget {
  final Function(Candidate) onCandidateAdded;

  FriendsPage({
    required this.onCandidateAdded,
  });

  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController partyController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulaire'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Nom'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir un nom';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir une description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: partyController,
                decoration: InputDecoration(labelText: 'Parti politique'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir un parti politique';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: imageUrlController,
                decoration: InputDecoration(labelText: 'URL de la photo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir une URL de photo';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Candidate candidate = Candidate(
                      name: nameController.text,
                      description: descriptionController.text,
                      party: partyController.text,
                      imageUrl: imageUrlController.text,
                    );
                    onCandidateAdded(candidate);
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Bouton de couleur verte
                ),
                child: Text('Valider'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}