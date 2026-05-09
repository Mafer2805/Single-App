import 'package:flutter/material.dart';

// Punto de inicio de la aplicación
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  // Widget principal de la app
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Health Advisor', // Título general de la app
      theme: ThemeData(
        // Tema visual global de la aplicación
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color.fromARGB(255, 228, 230, 233)),
          bodyMedium: TextStyle(color: Color.fromARGB(255, 238, 235, 235)),
        ),
      ),
      home: const HomePage(), // Pantalla inicial
    );
  }
}

// Pantalla principal de la aplicación
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// Estado actual de la pantalla principal
class _HomePageState extends State<HomePage> {
  // Controladores para leer lo que el usuario escribe
  final pesoController = TextEditingController();
  final alturaController = TextEditingController();

  // Variables que guardan el resultado del IMC
  double imc = 0;
  String resultado = "";
  Color color = Colors.black;

  //Función que calcula el IMC
  void calcularIMC() {
    // Convierte el texto ingresado a números decimales.
    // tryParse evita que la aplicación falle si el usuario deja un campo vacío o escribe un dato inválido.
    // replaceAll permite aceptar comas en lugar de puntos, por ejemplo: 1,60.
    double? peso = double.tryParse(pesoController.text.replaceAll(',', '.'));
    double? altura = double.tryParse(alturaController.text.replaceAll(',', '.'));

    // Verifica que los datos ingresados sean válidos antes de hacer el cálculo
    if (peso == null || altura == null || altura <= 0) {
      setState(() {
        imc = 0;
        resultado = "Ingresa datos válidos";
        color = Colors.red;
      });
      return;
    }

    double resultadoIMC = peso / (altura * altura);

    // Variables temporales para guardar la clasificación y el color
    String clasificacion;
    Color nuevoColor;

    // Clasificación del IMC según el resultado obtenido
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

    // Actualiza la interfaz con el nuevo resultado
    setState(() {
      imc = resultadoIMC;
      resultado = clasificacion;
      color = nuevoColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Color de fondo de la pantalla
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("BMI Health Advisor"), // Barra superior de la aplicación
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        // Contenido principal de la pantalla
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              // Campo para ingresar el peso
              controller: pesoController,
              keyboardType: TextInputType.number,
              // Color del texto que escribe el usuario
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                labelText: "Peso (kg)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: alturaController,
              keyboardType: TextInputType.number,
              // Color del texto que escribe el usuario
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                labelText: "Altura (m)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            //Botón para calcular el IMC
            ElevatedButton(
              onPressed: calcularIMC,
              // Estilo visual del botón
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
            // Texto que muestra la clasificación del IMC
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
