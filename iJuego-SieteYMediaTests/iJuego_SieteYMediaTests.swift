//
//  iJuego_SieteYMediaTests.swift
//  iJuego-SieteYMediaTests
//
//  Created by Máster Móviles on 29/10/2019.
//  Copyright © 2019 Máster Móviles. All rights reserved.
//

import XCTest
@testable import iJuego_SieteYMedia

class iJuego_SieteYMediaTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCartaValida() {
        let carta = Carta(3, Palo.oros)
        XCTAssert(carta?.valor == 3 && carta?.palo == Palo.oros, "Comprobando que una carta con datos correctos almacene correctamente")
    }
    
    func testCartaNil() {
        let carta = Carta(-1, Palo.bastos)
        XCTAssertNil(carta, "Comprobando que una carta con datos incorrectos devuelva nil")
    }
    
    func testReparteCartaBaraja() {
        let barajaTest = Baraja()
        let cartaRepartida = barajaTest.repartirCarta()
        let existeCartaEnBaraja = barajaTest.cartas.contains() {
            item in
            if item === cartaRepartida {
                return true
            } else {
                return false
            }
        }
        XCTAssert(existeCartaEnBaraja == false, "Comprobando que se reparte correctamente")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
