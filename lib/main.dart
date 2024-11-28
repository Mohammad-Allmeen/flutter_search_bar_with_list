import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search_bar_with_list/contact_page.dart';
import 'package:search_bar_with_list/contacts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {

   MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController searchController = TextEditingController();
  List<Contacts> contacts = availableContacts;

  @override
  Widget build(BuildContext context) {
return Scaffold(
  appBar: AppBar(
    title: const Text('Flutter search bar'),
    backgroundColor: Colors.white,
  ),
  body: SafeArea(child: Padding(padding: EdgeInsets.symmetric(horizontal: 10),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Contacts', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
        const SizedBox(
          height: 20,
        ),
        TextField(
          controller: searchController,
          onChanged: searchContacts,
          decoration: InputDecoration(
            hintText: 'Search',
            prefixIcon: Icon(Icons.search, color: Colors.deepPurple,),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.deepPurple),
            ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Colors.black,
                )
              )
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(child: ListView.builder(
          itemCount: contacts.length,
            itemBuilder:(context, index)
            {
            final singleContact = contacts[index];
            return Padding(padding: EdgeInsets.all(5),
              child: ListTile(
                //onTap: ()=> Navigator.push(context, CupertinoPageRoute(builder: (context)=> ContactPage(contact: singleContact))),
                onTap: () => Navigator.push(
                  context,
                  _createRoute(singleContact),
                ),
                leading: Hero(
                  tag: singleContact.urlImage,
                  child: ClipOval(
                    child: Image.network(singleContact.urlImage, width: 60, height: 60, fit: BoxFit.cover,),
                  ),
                ),
                title: Text(singleContact.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.deepPurple),),
                subtitle: Text(singleContact.number, style: TextStyle(fontWeight: FontWeight.w600),),
                trailing: Icon(Icons.contacts, size: 18, color: Colors.deepPurple),
                hoverColor: Colors.black,
                focusColor: Colors.black,
              ),
            );
            }
        )
        )
    ],
  ),
  )
  ),
);
  }
  // FADE ANIMATION
//this code defines a route with a custom fade transition animation for navigating from one page to the ContactPage
  Route _createRoute(Contacts contact) { //function defination
    return PageRouteBuilder( //PageRouteBuilder is a special type of route that allows for custom transitions (animations) between pages. It takes two key arguments: pageBuilder and transitionsBuilder.
      pageBuilder: (context, animation, secondaryAnimation) => //pageBuilder defines the page that will be displayed when this route is pushed. It returns the ContactPage widget, passing in the Contacts object as a parameter.
          ContactPage(contact: contact),
      transitionsBuilder: (context, animation, secondaryAnimation, child) { //transitionsBuilder is where you define how the page transition will look. It takes context, animation, secondaryAnimation, and child as arguments.
        return FadeTransition( //FadeTransition is a widget that animates the opacity of its child widget.
          opacity: animation, //opacity: animation means that the animation object is controlling the fade effect.
          child: child,
        );
      },
    );
  }

  void searchContacts(String query){
    final suggestions = contacts.where((contact)
    { //The where method is called on the contacts list. The where method is a higher-order function that applies a specified condition (defined in the following lines) to each element in the list, filtering elements based on whether they meet this condition.
      final contactTitle = contact.name.toLowerCase(); // to convert the contact name to lowercase
      final input=  query.toLowerCase();// the input given to lowercase
      final contactNumber = contact.number.toLowerCase();
      return contactTitle.contains(input)|| contactNumber.contains(input);
    }).toList();
    setState(() {
      contacts = query.isEmpty ? availableContacts : suggestions;
    });
  }
}


