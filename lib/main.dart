import 'dart:io';
import 'package:flutter/material.dart';
import 'package:request_to_oktell/second_screen.dart';

//Суть в чём. Первый экран на котором форма ввода. Водим туда номер телефона в формате 7**********. Без + и 8.
//Нажимаем Ок. По нажатию вызывается second_screen.
//Созанный нами controller передаёт введённый номер в second_screen.
//Если поле ввода пустое, нам пишут Please enter phone.
//Я ещё вывожу в консоль разные сообщения, чтобы отследить, что всё отработало.
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Form Validation';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {

  final TextEditingController _controller = TextEditingController();
  TextFormField _usernameFormField() {
    return TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter phone';
          }
          return null;
        },
        controller: _controller,
        textAlignVertical: TextAlignVertical.center,
        textInputAction: TextInputAction.next,
        textCapitalization: TextCapitalization.words,
        decoration: const InputDecoration(
          labelText: "Phone number",
        ));
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _usernameFormField(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                  print(_controller.text.toString());
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SecondScreenForm(phone: _controller.text)));
                }
              },
              child: const Text('OK'),
            ),
          ),
        ],
      ),
    );
  }
}