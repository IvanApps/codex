import 'package:appweather/ui/ui_constants.dart';
import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  final VoidCallback onTap;

  const EmptyWidget({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/welcome.jpg',
            fit: BoxFit.cover,
          ),
        ),
        SafeArea(
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: maxPageWidth,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Image.asset(
                    'assets/logo.png',
                    height: 70,
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  Text(
                    '¡Hola!\nBienvenido',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Por favor, agrega una ciudad...',
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    child: Text(
                      'Ingresar',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.lightBlue,
                      shape: StadiumBorder(),
                      elevation: 10,
                    ),
                    onPressed: onTap, //() => handleNavigationPress(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
