import 'package:flutter/material.dart';

void main() {
  runApp(const AplicacionPrincipal());
}

class AplicacionPrincipal extends StatelessWidget {
  const AplicacionPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PantallaVerificadorAnagramas(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PantallaVerificadorAnagramas extends StatefulWidget {
  const PantallaVerificadorAnagramas({super.key});

  @override
  State<PantallaVerificadorAnagramas> createState() => _EstadoPantallaVerificadorAnagramas();
}

class _EstadoPantallaVerificadorAnagramas extends State<PantallaVerificadorAnagramas> {
  final TextEditingController _controladorPrimeraFrase = TextEditingController();
  final TextEditingController _controladorSegundaFrase = TextEditingController();
  String _resultado = '';

  @override
  void dispose() {
    _controladorPrimeraFrase.dispose();
    _controladorSegundaFrase.dispose();
    super.dispose();
  }

  /// Verifica si dos frases son anagramas
  bool _sonAnagramas(String frase1, String frase2) {
    // Limpiar: convertir a minúsculas, eliminar espacios y caracteres especiales
    String limpia1 = frase1
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-záéíóúñ]'), '')
        .replaceAll(' ', '');
    String limpia2 = frase2
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-záéíóúñ]'), '')
        .replaceAll(' ', '');

    // Si las longitudes son diferentes, no son anagramas
    if (limpia1.length != limpia2.length) {
      return false;
    }

    // Ordenar las letras y comparar
    List<String> letras1 = limpia1.split('')..sort();
    List<String> letras2 = limpia2.split('')..sort();
    
    return letras1.join() == letras2.join();
  }

  void _verificarAnagramas() {
    String frase1 = _controladorPrimeraFrase.text;
    String frase2 = _controladorSegundaFrase.text;

    if (frase1.isEmpty || frase2.isEmpty) {
      setState(() {
        _resultado = 'Ingresa ambas frases para verificar';
      });
      return;
    }

    if (_sonAnagramas(frase1, frase2)) {
      setState(() {
        _resultado = 'Las frases son anagramas';
      });
    } else {
      setState(() {
        _resultado = 'Las frases NO son anagramas';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verificador de Anagramas'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Título
            const Text(
              'Verificador de Anagramas',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            // Primera entrada
            TextField(
              controller: _controladorPrimeraFrase,
              decoration: InputDecoration(
                labelText: 'Ingresa primera frase',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Segunda entrada
            TextField(
              controller: _controladorSegundaFrase,
              decoration: InputDecoration(
                labelText: 'Ingresa segunda frase',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Botón Verificar
            ElevatedButton(
              onPressed: _verificarAnagramas,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Verificar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Resultado
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _resultado.isNotEmpty ? _resultado : 'Esperando verificación...',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
