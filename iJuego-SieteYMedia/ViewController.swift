//
//  ViewController.swift
//  iJuego-SieteYMedia
//
//  Created by Máster Móviles on 29/10/2019.
//  Copyright © 2019 Máster Móviles. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Properties
    var juego = Juego()
    var vistasCartas = [UIImageView]()
    var cartasMostradas = 0
    var puntuacionJugador = 0.0
    var puntuacionMaquina = 0.0
    var resultadoPartida = ""
    @IBOutlet weak var button_pedir_carta: UIButton!
    @IBOutlet weak var button_plantarse: UIButton!
    @IBOutlet weak var button_nueva_partida: UIButton!
    @IBOutlet weak var partidasGanadas: UILabel!
    @IBOutlet weak var partidasPerdidas: UILabel!
    
    //MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.subscribeResultadoMano()
        // Do any additional setup after loading the view.
    }
    
    func subscribeResultadoMano() {
        let nc = NotificationCenter.default
        nc.addObserver(self, selector:#selector(self.receive), name:NSNotification.Name("resultado"), object: nil)
    }
    
    @objc func receive(notificacion:Notification) {
        if let userInfo = notificacion.userInfo {
            let resultado = userInfo["resultado"] as! String
            self.resultadoPartida = resultado
            
            let ganaJugador = userInfo["gana"] as! Bool
            let j = userInfo["jugador"] as! Double
            let m = userInfo["maquina"] as! Double
            self.puntuacionJugador = j
            self.puntuacionMaquina = m
            button_pedir_carta.isEnabled = false
            button_plantarse.isEnabled = false
            showAlert()
            
            if ganaJugador {
                if var num = Int(self.partidasGanadas.text!) {
                    num += 1
                    self.partidasGanadas.text = "\(num)"
                }
            } else {
                if var num = Int(self.partidasPerdidas.text!) {
                    num += 1
                    self.partidasPerdidas.text = "\(num)"
                }
            }
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(
            title: "Fin del juego",
            message: self.resultadoPartida,
            preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(
            title: "OK",
            style: UIAlertAction.Style.default)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func dibujarCarta(carta: Carta, enPosicion : Int) {
        let limitesPantalla = UIScreen.main.bounds
        
        let anchoPantalla = limitesPantalla.width
        let altoPantalla = limitesPantalla.height
        
        let finalWidth = anchoPantalla/4
        let finalHeight = altoPantalla/6
        
        var finalX = CGFloat(Int(finalWidth) + Int(finalWidth) * (enPosicion - 1))
        var finalY = finalHeight
        
        if finalX > altoPantalla {
            finalX = finalWidth
            finalY += finalHeight
        }
        
        let nombreImagen = String(carta.valor) + String(carta.palo.rawValue)
        // Creamos un objeto imagen
        let imagenCarta = UIImage(named: nombreImagen)
        // Para que la imagen sea un componente más del UI, la encapsulamos en un UIImageView
        let cartaView = UIImageView(image: imagenCarta)
        // Inicialmente la colocamos fuera de la pantalla y más grande para que parezca más cercana
        // "frame" son los límites de la vista, definen pos y tamaño
        cartaView.frame = CGRect(x: -200, y: -200, width: 200, height: 300)
        // La rotamos, para que al "repartirla" haga un efecto de giro
        cartaView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi));
        // La añadimos a la vista principal, si no no sería visible
        self.view.addSubview(cartaView)
        // Guardamos la vista en el array, para luego poder eliminarla
        self.vistasCartas.append(cartaView)
        // Animación de repartir carta
        UIView.animate(withDuration: 0.5){
            // "efecto caida": la llevamos a la posición final
            cartaView.frame = CGRect(x: finalX, y: finalY, width: finalWidth, height: finalHeight);
            // 0 como ángulo "destino", para que rote mientras "cae"
            cartaView.transform = CGAffineTransform(rotationAngle:0);
        }
    }
    
    func borrarCartas() {
        //Quitamos las cartas de la pantalla
        for vistaCarta in self.vistasCartas {
            vistaCarta.removeFromSuperview()
        }
        
        self.vistasCartas = []
    }
    
    @IBAction func pedirCarta(_ sender: Any) {
        if cartasMostradas == 0 {
            button_plantarse.isEnabled = true
            button_nueva_partida.isEnabled = true
        }
        
        let extract = juego.extraerCartaDeLaBaraja()
        
        if extract {
            dibujarCarta(carta: juego.manoHumano.getCarta(pos: cartasMostradas)!, enPosicion: cartasMostradas)
            cartasMostradas += 1
        }
    }
    
    @IBAction func plantarse(_ sender: Any) {
        let resultado = juego.plantarse()
        borrarCartas()
        cartasMostradas = 0
        print(resultado)
    }
    
    @IBAction func nuevaPartida(_ sender: Any) {
        juego = Juego()
        button_plantarse.isEnabled = false
        button_pedir_carta.isEnabled = true
        borrarCartas()
        cartasMostradas = 0
    }
    
}

