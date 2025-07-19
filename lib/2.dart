import 'package:flutter/material.dart';

void main() => runApp(AboutMeApp());

class AboutMeApp extends StatelessWidget {
  const AboutMeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Keana May C. Ilagan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.transparent,
        fontFamily: 'Knewave',
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurpleAccent,
            shape: StadiumBorder(),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLongPressed = false;
  List<String> hobbies = ['Cycling', 'Gaming', 'Watching Movie'];
  final TextEditingController _hobbyController = TextEditingController();

  void _showContactForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 20,
            left: 16,
            right: 16),
        child: ContactForm(),
      ),
    );
  }

  void _addHobby() {
    final hobby = _hobbyController.text.trim();
    if (hobby.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a hobby')),
      );
      return;
    }
    if (hobbies.contains(hobby)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hobby already exists')),
      );
      return;
    }
    setState(() {
      hobbies.add(hobby);
      _hobbyController.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Added hobby: $hobby')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.deepPurple.shade700,
              Colors.deepPurple.shade300,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/unnamed.jpg'),
                      fit: BoxFit.cover,
                      colorFilter:
                          ColorFilter.mode(Colors.black45, BlendMode.darken),
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  top: 40,
                  child: CircleAvatar(
                    radius: 36,
                    backgroundImage: AssetImage('assets/unnamed.jpg'),
                    backgroundColor: Colors.white,
                  ),
                ),
                Positioned(
                  left: 100,
                  top: 50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Keana May Ilagan",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      Text("Cyclist | Explorer",
                          style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                )
              ],
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16),
                children: [
                  Card(
                    color: Colors.deepPurple.shade50,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Hello!",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          Text(
                            "I'm Keana May Ilagan, you can call me Keana. I love cycling and exploring new places.",
                            style: TextStyle(
                                fontSize: 16, color: Colors.deepPurple[900]),
                          ),
                          SizedBox(height: 16),
                          GestureDetector(
                            onLongPress: () {
                              setState(() => isLongPressed = !isLongPressed);
                            },
                            child: AnimatedDefaultTextStyle(
                              duration: Duration(milliseconds: 300),
                              style: TextStyle(
                                fontSize: isLongPressed ? 22 : 16,
                                color: isLongPressed
                                    ? Colors.deepPurpleAccent
                                    : Colors.deepPurple[900],
                                fontWeight: isLongPressed
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                              child: Text('Long press this text!'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text("My Hobbies",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple[100])),
                  SizedBox(height: 10),

                  // Here is the single column list for hobbies
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: hobbies.length,
                    itemBuilder: (context, index) {
                      final hobby = hobbies[index];
                      return Dismissible(
                        key: Key(hobby),
                        background: Container(
                          color: Colors.redAccent,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                        direction: DismissDirection.endToStart,
                        onDismissed: (_) {
                          setState(() => hobbies.remove(hobby));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('$hobby removed')),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple.shade100,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.deepPurple.shade200,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.favorite, color: Colors.pink.shade400),
                              SizedBox(width: 8),
                              Text(
                                hobby,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple[900],
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _hobbyController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.deepPurple.shade50,
                            hintText: 'Add new hobby',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: _addHobby,
                        child: Icon(Icons.add),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(14),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.deepPurple.shade700,
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Center(
            child: ElevatedButton.icon(
              icon: Icon(Icons.contact_mail),
              label: Text('Contact Me'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent,
                shape: StadiumBorder(),
              ),
              onPressed: () => _showContactForm(context),
            ),
          ),
        ),
      ),
    );
  }
}

class ContactForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  ContactForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Wrap(
        children: [
          Text("Send me a message",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          TextFormField(
            controller: _nameController,
            decoration:
                InputDecoration(labelText: 'Name', prefixIcon: Icon(Icons.person)),
            validator: (value) =>
                value == null || value.isEmpty ? 'Name is required' : null,
          ),
          TextFormField(
            controller: _emailController,
            decoration:
                InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email)),
            validator: (value) {
              if (value == null || value.isEmpty) return 'Email required';
              if (!value.contains('@') || !value.contains('.')) return 'Enter valid email';
              return null;
            },
          ),
          TextFormField(
            controller: _messageController,
            decoration: InputDecoration(
                labelText: 'Message', prefixIcon: Icon(Icons.message)),
            maxLines: 3,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Message required';
              if (value.length < 10) return 'Message must be at least 10 characters';
              return null;
            },
          ),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton.icon(
              icon: Icon(Icons.send),
              label: Text('Submit'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Message sent successfully!')),
                  );
                }
              },
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
