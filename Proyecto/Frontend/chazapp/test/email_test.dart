import 'package:chazapp/src/core/functions/auth_functions.dart';
import "package:flutter_test/flutter_test.dart";

void main() {
  group("Test de email", () {
    test("Email válido", () {
      const testEmail = "samuevarga@gmail.com";

      expect(isEmailValid(testEmail), true);
    });

    test("Email no válido", () {
      const testEmail = "samuevarga@gmail";

      expect(isEmailValid(testEmail), false);
    });

    test("Email vacío", () {
      const testEmail = "";

      expect(isEmailValid(testEmail), false);
    });
  });
}

// void main() {
//   group("Grupo de tests", () {
//     test("Caso de prueba 1", () {
//       // Código de prueba
//       const value1 = 1;
//       const value2 = 2;

//       // Verificación
//       expect(value1 + value2, 3);
//     });

//     test("Caso de prueba 2", () {
//       // Código de prueba
//       const value1 = 2;
//       const value2 = 2;

//       // Verificación
//       expect(value1 + value2, 4);
//     });
//   });
// }
