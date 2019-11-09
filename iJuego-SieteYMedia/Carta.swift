
import UIKit

class Carta {

    //MARK: Properties
    var valor: Int
    var palo: Palo

    //MARK: Initializers
    init?(_ valor: Int,_ palo: Palo) {

        if (valor == 8) || (valor == 9) {
            return nil
        }

        if (valor < 1) || (valor > 12) {
            return nil
        }

        self.valor = valor
        self.palo = palo
    }

    func descripcion() -> String {
        return "El \(self.valor) de \(self.palo)"
    }

}
