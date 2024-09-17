import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Sign In',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignInPage(),
    );
  }
}

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String password = '';

  void _signIn() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(
            name: name,
            email: email,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onChanged: (value) {
                  name = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                onChanged: (value) {
                  email = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                onChanged: (value) {
                  password = value;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _signIn,
                child: Text('Sign In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  final String name;
  final String email;

  MainPage({
    required this.name,
    required this.email,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 2) {
        _logout();
      }
    });
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Konfirmasi Logout"),
          content: Text("Apakah anda yakin ingin logout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Tutup dialog jika memilih "Tidak"
              },
              child: Text("Tidak"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => SignInPage()),
                  (route) => false,
                );
              },
              child: Text("Ya"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String appBarTitle = '';
    if (_selectedIndex == 0)
      appBarTitle = 'Profile';
    else if (_selectedIndex == 1) appBarTitle = 'Makanan & Minuman Favorit';

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          ProfilePage(
            name: widget.name,
            email: widget.email,
          ),
          Menu(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_cafe),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  final String name;
  final String email;

  ProfilePage({
    required this.name,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Card(
            elevation: 4, // Memberikan sedikit bayangan pada kartu
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(10), // Membuat sudut yang melengkung
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Icon(Icons.person,
                        size: 40, color: Colors.blue), // Ikon profil
                    title: Text(
                      name,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Name',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    leading: Icon(Icons.email,
                        size: 40, color: Colors.blue), // Ikon email
                    title: Text(
                      email,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      'Email',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final List<Map<String, String>> favoriteCoffees = [
    {
      'name': 'Espresso',
      'image':
          'https://www.mldspot.com/storage/generated/June2021/Panduan%20Singkat%20Cara%20Membuat%20Kopi%20Espresso.jpg',
    },
    {
      'name': 'Cappuccino',
      'image':
          'https://news.ralali.com/wp-content/uploads/2021/07/capuccino-1536x1024.jpg',
    },
    {
      'name': 'Latte',
      'image': 'https://mesinkopi.me/wp-content/uploads/2018/08/latte.jpg ',
    },
    {
      'name': 'Americano',
      'image':
          'https://coffeforus.com/wp-content/uploads/2022/12/Americano-coffee-recipe.jpg',
    },
    {
      'name': 'Nasi Goreng',
      'image':
          'https://www.sugarspicenmore.com/wp-content/uploads/2022/08/Nasi-Goreng-3-rotated.jpg',
    },
    {
      'name': 'Kebab',
      'image':
          'https://i.pinimg.com/originals/b6/df/95/b6df95511324ed23f95dff7eeefba447.jpg',
    },
    {
      'name': 'Mie Ayam',
      'image': 'https://www.resepistimewa.com/wp-content/uploads/mie-ayam.jpg',
    },
    {
      'name': 'Mix Plate',
      'image':
          'https://asset-a.grid.id/crop/0x0:0x0/700x465/photo/2020/03/02/1729979134.jpg',
    },
  ];

  String query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search Here',
            hintStyle: TextStyle(color: const Color.fromARGB(255, 249, 1, 1)),
            border: InputBorder.none,
            prefixIcon:
                Icon(Icons.search, color: const Color.fromARGB(255, 254, 0, 0)),
          ),
          onChanged: (value) {
            setState(() {
              query = value.toLowerCase();
            });
          },
          style: TextStyle(color: const Color.fromARGB(255, 9, 9, 9)),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: favoriteCoffees.length,
        itemBuilder: (context, index) {
          final coffee = favoriteCoffees[index];
          if (query.isEmpty || coffee['name']!.toLowerCase().contains(query)) {
            return Card(
              elevation: 4, // Menambahkan bayangan pada setiap kartu
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(10)),
                      child: Image.network(
                        coffee['image']!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      coffee['name']!,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center, // Pusatkan teks
                    ),
                  ),
                ],
              ),
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
