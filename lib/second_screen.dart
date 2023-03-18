import 'package:flutter/material.dart';
import 'package:request_to_oktell/provider.dart';


//Когда нас перебрасывает на второй экран, нас перебрасывает на второе поле ввода, в то же время значение переданное
//в controller на первом экране (теперь называется phone), отправляется в 1с.
//В свою очередь, 1с связывается с октеллом и вызывает звонок, получает от октелла код,
//И присылает его обратно во флаттер. В somecode.
//Дальше, когда нам поступает звонок, мы вводим 4 цифры в поле ввода. Теперь controller -- это введённый 4значный код.
//И controller сравнивается с somecode.
//Если цифры правильные, в консоль выводится Success!
//Если нет, то Wrong.
//Если поле ввода пустое, нам пишут Please enter code.

// Create a Form widget.
class SecondScreenForm extends StatefulWidget {
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
final _formKey = GlobalKey<FormState>();
class SecondScreenFormState extends State<SecondScreenForm> {

//В somecode храним код из 4 цифр, который возвращает 1с.
  String? somecode;

  void initState() {
    print("initState!${widget.phone}");
    postPhone(widget.phone);

    super.initState();
  }

  void postPhone(String phone) async {
    print("postPhone1");
    print(phone);
    MwProvider().loadPhone(phone: phone).then((value) {
      print("postPhone");
      somecode = value.somecode;
      // setState(() {});
    }, onError: (o) {
      SnackBar(content: Text(o.toString()));
    });
  }

  final TextEditingController _controller = TextEditingController();
  TextFormField _somecodeFormField() {
    return TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter code';
          }
          return null;
        },
        controller: _controller,
        textAlignVertical: TextAlignVertical.center,
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
          labelText: "Code",
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
              _somecodeFormField(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_controller.text.toString() == somecode.toString()){
                      print("Success!");
                    }
                     else {
                       print("Wrong");
                     }

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