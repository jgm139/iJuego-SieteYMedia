//
//  Juego.swift
//  iJuego-SieteYMedia
//
//  Created by Máster Móviles on 29/10/2019.
//  Copyright © 2019 Máster Móviles. All rights reserved.
//

import Foundation

class Juego {
    
    //MARK: Properties
    var manoHumano: Mano
    var baraja: Baraja
    
    //MARK: Initializer
    init() {
        self.manoHumano = Mano()
        self.baraja = Baraja()
    }
    
    //MARK: Functions
    func sumaTotalMano() -> Double {
        var sumaTotal = 0.0
        
        for i in 0..<self.manoHumano.tamaño {
            switch self.manoHumano.getCarta(pos: i)!.valor {
                case 10, 11, 12:
                    sumaTotal += 0.5
                default:
                    sumaTotal += Double(self.manoHumano.getCarta(pos: i)!.valor)
            }
        }
        
        return sumaTotal
    }
    
    func extraerCartaDeLaBaraja() -> Bool{
        let sum = sumaTotalMano()
        var extract = false
        
        if  sum >= 7.5 {
            print("El jugador superó 7.5")
            print(plantarse())
        } else {
            self.baraja.barajar()
            extract = true
            self.manoHumano.addCarta(self.baraja.repartirCarta())
        }
        
        return extract
    }
    
    func plantarse() -> String {
        var resultado = ""
        var ganaJugador = false
        let parteEntera = Int.random(in: 1...7)
        let parteDecimal = Int.random(in: 0...1)
        var valorCasa = 0.0
        
        if parteDecimal == 1 && parteEntera == 7 {
            valorCasa = 7.5
        } else {
            valorCasa = Double(parteEntera)
        }
        
        let valorJugador = sumaTotalMano()
        
        if valorJugador > 7.5 || valorJugador < valorCasa {
            resultado = "Gana la máquina con un " + String(valorCasa) + " y el jugador pierde con " + String(valorJugador)
        } else { // valorJugador > valorCasa
            resultado = "Gana el jugador con un " + String(valorJugador) + " y la máquina pierde con " + String(valorCasa)
            ganaJugador = true
        }
        
        informarDelResultado(resultado: resultado, gana: ganaJugador, puntuacion: (jugador: valorJugador, maquina: valorCasa))
        
        return resultado
    }
    
    func informarDelResultado(resultado: String, gana: Bool, puntuacion: (jugador: Double, maquina: Double)) {
        let nc = NotificationCenter.default
        nc.post(name: NSNotification.Name("resultado"), object: nil, userInfo: ["resultado":resultado, "gana": gana, "jugador":puntuacion.jugador, "maquina":puntuacion.maquina])
    }
}
