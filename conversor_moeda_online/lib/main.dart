import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Map<String, dynamic> parameters = {'key': '3622d828'};
var request = Uri(
  scheme: 'http',
  host: 'api.hgbrasil.com',
  path: '/finance',
  queryParameters: parameters,
);

void main() async {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
        hintColor: Colors.amber,
        primaryColor: Colors.white,
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
          hintStyle: TextStyle(color: Colors.amber),
        )),
  ));
}

Future<Map> getData() async {
  var response = await http.get(request);
  return convert.jsonDecode(response.body);
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();

  late double dolar;
  late double euro;

  void _realChanged(String text) {
    if (text.isEmpty) {
      dolarController.text = "";
      euroController.text = "";
      return;
    }
    double? real = double.tryParse(text);
    if (real != null) {
      dolarController.text = (real / dolar!).toStringAsPrecision(2);
      euroController.text = (real / euro!).toStringAsPrecision(2);
    }
  }

  void _dolarChanged(String text) {
    if (text.isEmpty) {
      realController.text = "";
      euroController.text = "";
      return;
    }
    double? dolarDouble = double.tryParse(text);
    if (dolarDouble != null) {
      realController.text = (dolarDouble * dolar).toStringAsPrecision(2);
      euroController.text = (dolarDouble * dolar / euro).toStringAsPrecision(2);
    }
  }

  void _euroChanged(String text) {
    if (text.isEmpty) {
      realController.text = "";
      dolarController.text = "";
      return;
    }
    double? euroDouble = double.tryParse(text);
    if (euroDouble != null) {
      realController.text = (euroDouble * euro).toStringAsPrecision(2);
      dolarController.text = (euroDouble * euro / dolar).toStringAsPrecision(2);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("\$ Conversor \$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
          future: getData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case (ConnectionState.waiting):
                return const Center(
                    child: Text(
                  "Carregando dados....",
                  style: TextStyle(color: Colors.amber, fontSize: 25.0),
                  textAlign: TextAlign.center,
                ));
              default:
                if (snapshot.hasError) {
                  return const Center(
                      child: Text(
                    "Erro ao carregar dados :(",
                    style: TextStyle(color: Colors.amber, fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ));
                } else {
                  dolar = snapshot.data?["results"]["currencies"]["USD"]["buy"];
                  euro = snapshot.data?["results"]["currencies"]["EUR"]["buy"];
                  return SingleChildScrollView(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.monetization_on,
                          size: 150.0,
                          color: Colors.amber,
                        ),
                        buildTextField("Reais", "R\$", realController, _realChanged),
                        Divider(),
                        buildTextField("Dolares", "US\$", dolarController, _dolarChanged),
                        Divider(),
                        buildTextField("Euros", "€", euroController, _euroChanged),
                      ],
                    ),
                  );
                }
            }
          }),
    );
  }

  Widget buildTextField(
      String label, String prefix, TextEditingController c, Function f) {
    return TextField(
      controller: c,
      decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.amber),
          border: const OutlineInputBorder(),
          prefixText: prefix),
      style: const TextStyle(color: Colors.amber, fontSize: 25.0),
      onChanged: (text){
        f(text);
      },
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
    );
  }
}
