
import UIKit

class Mano {

    //MARK: Properties
    var cartas: [Carta]
    var tamaño: Int {
        get {
            return self.cartas.count
        }
    }

    //MARK: Initializers
    init() {
        self.cartas = [Carta]()
    }

    //MARK: Functions
    func addCarta(_ carta: Carta) {
        self.cartas.append(carta)
    }

    func getCarta(pos index: Int) -> Carta? {
        if (index >= 0) || (index < self.tamaño) {
            return self.cartas[index]
        } else {
            return nil
        }
    }
}
