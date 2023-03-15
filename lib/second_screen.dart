import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:request_to_oktell/provider.dart';




// Create a Form widget.
class SecondScreenForm extends StatefulWidget {
  //const SecondScreenForm({super.key});
  final String phone;

  const SecondScreenForm({
    Key? key,
    required this.phone,
  }) : super(key: key);

  @override
  SecondScreenFormState createState() {
    return SecondScreenFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class SecondScreenFormState extends State<SecondScreenForm> {

  final _formKey = GlobalKey<FormState>();
  String? somecode;

  void initState() {
    print("initState!");
    postPhone(widget.phone);

    super.initState();
  }

  void postPhone(String phone) async {
    print("postPhone1");
    MwProvider().loadPhone(phone: phone).then((value) {
      print("postPhone");
      somecode = value.somecode;
      // setState(() {});
    }, onError: (o) {
      SnackBar(content: Text(o.toString()));
    });


    //super.postPhone(phone);
    // void initState() {
    //    phone = phone;
    // }
    // super.initState();

    // Create a global key that uniquely identifies the Form widget
    // and allows validation of the form.
    //
    // Note: This is a GlobalKey<FormState>,
    // not a GlobalKey<MyCustomFormState>.


  }
  final TextEditingController _controller = TextEditingController();
  TextFormField _usernameFormField() {
    return TextFormField(
        controller: _controller,
        textAlignVertical: TextAlignVertical.center,
        textInputAction: TextInputAction.next,
        // style: style,
        // textCapitalization: TextCapitalization.words,
        decoration: const InputDecoration(
          labelText: "Code",
          // prefixIcon: Icon(CustomIcons.profile),
        ));
  }
  @override
  Widget build(BuildContext context) {
    print("secondscreen");
    return Scaffold(
        appBar: AppBar(
          title: Text("Second screen"),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(

                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter code';
                  }
                  return null;
                },
              ),
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
                    }
                    if (_controller.text == somecode){
                      print("Success!");
                    }
                    // else {
                    //   return 'Please enter code';
                    // }

                    //_controller.text=''; // else{
                    //
                    // }
                    //compare(_controller.text)
                  },
                  child: const Text('OK'),
                ),
              ),
            ],
          ),
        )
    );
  }
}