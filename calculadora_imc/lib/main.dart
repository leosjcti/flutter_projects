import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "nforme seus dados";
    });
  }

  void calculate() {
    setState(() {
      double wight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = wight / (height * height);

      switch(imc) {
        case < 18.6: _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(3)})"; break;
        case >= 18.6 && < 24.9: _infoText = "Peso ideal (${imc.toStringAsPrecision(3)})"; break;
        case >= 24.9 && < 29.9: _infoText = "Levemente acima do peso (${imc.toStringAsPrecision(3)})"; break;
        case >= 29.9 && < 34.9: _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(3)})"; break;
        case >= 34.9 && < 39.9: _infoText = "Obesidade grau II (${imc.toStringAsPrecision(3)})"; break;
        case >= 40: _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(3)})"; break;
        default: break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(onPressed: _resetFields, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.perm_identity_outlined,
                size: 120.0,
                color: Colors.green,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: "Peso (Kg)",
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: weightController,
                validator: (value) {
                  if (value!.isEmpty)
                    return "insira o seu peso";
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: "Altura (Cm)",
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.green, fontSize: 25.0),
                controller: heightController,
                validator: (value) {
                  if (value!.isEmpty)
                    return "insira sua altura";
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate()) {
                        calculate();
                      }
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: const Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.green, fontSize: 25.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
