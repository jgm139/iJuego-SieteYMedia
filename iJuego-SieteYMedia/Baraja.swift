//
//  Baraja.swift
//  iJuego-SieteYMedia
//
//  Created by Máster Móviles on 29/10/2019.
//  Copyright © 2019 Máster Móviles. All rights reserved.
//

import Foundation

class Baraja {
    
    //MARK: Properties
    let NUM_CARTAS = 12
    var cartas = [Carta]()
    
    //MARK: Initializer
    init() {
        for palo in Palo.allCases {
            for j in 1...NUM_CARTAS {
                if j != 8 && j != 9 {
                    self.cartas.append(Carta(j, palo)!)
                }
            }
        }
    }
    
    //MARK: Functions
    func repartirCarta() -> Carta {
        return self.cartas.popLast()!
    }
    
    func barajar() {
        self.cartas.shuffle()
    }
}
