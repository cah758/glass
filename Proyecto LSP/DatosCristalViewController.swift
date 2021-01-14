//
//  DatosCristalViewController.swift
//  Proyecto LSP
//
//  Created by Bruno on 12/01/2021.
//  Copyright © 2021 Cristian Alvarez hossein. All rights reserved.
//

import UIKit

class DatosCristalViewController: UIViewController {

    
    
    @IBOutlet weak var nombreCristal: UILabel!
    
    @IBOutlet weak var imgCristal: UIImageView!
    
    @IBOutlet weak var labelAl: UILabel!
    
    @IBOutlet weak var labelIR: UILabel!
    
    @IBOutlet weak var labelNa: UILabel!
    
    @IBOutlet weak var labelBa: UILabel!
    
    @IBOutlet weak var labelMg: UILabel!
    
    var nombreC:String = ""
    var al:Double = 0.0
    var ba:Double = 0.0
    var na:Double = 0.0
    var iR:Double = 0.0
    var mg:Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Traerse las cosas de la BD y ponerlas en su sitio. Y ponerle foto.
        nombreCristal.text = nombreC
        labelAl.text = String(format:"%.2f",al)
        labelBa.text = String(format:"%.2f",ba)
        labelNa.text = String(format:"%.2f",na)
        labelIR.text = String(format:"%.4f",iR)
        labelMg.text = String(format:"%.2f",mg)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
