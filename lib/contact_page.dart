import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'contacts.dart';

class ContactPage extends StatelessWidget{
  final Contacts contact;
  const ContactPage({super.key , required this.contact});

  @override
  Widget build(BuildContext context) {

return Scaffold(
  appBar: AppBar(
    title: Text(contact.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
  ),
  body: Column(
    children: [
      CircleAvatar(radius: 200,
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.black,
          child: Hero(tag: contact.urlImage, child: Image.network(contact.urlImage))),
      const SizedBox(height: 20,),
   RichText(text:
   TextSpan(style: TextStyle(fontSize: 24),
     children:<TextSpan>[
       TextSpan(text: 'Phone: +91-', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black )),
       TextSpan(text: contact.number, style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold, color: Colors.deepPurple))
     ]
   ),
   )
    ],
  ),

);
  }
}