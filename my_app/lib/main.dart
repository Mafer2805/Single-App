import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Health Advisor',
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final pesoController = TextEditingController();
  final alturaController = TextEditingController();

  double imc = 0;
  String resultado = "";
  Color color = Colors.black;

  void calcularIMC() {
    double peso = double.parse(pesoController.text);
    double altura = double.parse(alturaController.text);

    double resultadoIMC = peso / (altura * altura);

    String clasificacion;
    Color nuevoColor;

    if (resultadoIMC < 18.5) {
      clasificacion = "Bajo peso";
      nuevoColor = Colors.blue;
    } else if (resultadoIMC < 25) {
      clasificacion = "Normal";
      nuevoColor = Colors.green;
    } else if (resultadoIMC < 30) {
      clasificacion = "Sobrepeso";
      nuevoColor = Colors.orange;
    } else {
      clasificacion = "Riesgo alto";
      nuevoColor = Colors.red;
    }

    setState(() {
      imc = resultadoIMC;
      resultado = clasificacion;
      color = nuevoColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("BMI Health Advisor"),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: pesoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Peso (kg)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: alturaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Altura (m)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calcularIMC,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 103, 177, 43),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text("Calcular", style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 30),
            Text(
              "IMC: ${imc.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 24),
            ),
            Text(
              resultado,
              style: TextStyle(fontSize: 26, color: color),
            ),
          ],
        ),
      ),
    );
  }
}
