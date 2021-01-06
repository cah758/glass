//
//  AddGlassViewController.swift
//  Proyecto LSP
//
//  Created by r on 25/11/2020.
//  Copyright © 2020 Cristian Alvarez hossein. All rights reserved.
//

import UIKit

class AddGlassViewController: UIViewController {
    
    
    @IBOutlet weak var sliderIndRef: UISlider!
    
    @IBOutlet weak var tipoCristalPicker: TipoCristalPickerView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
         self.title = "Nuevo cristal"
        
        
    }
    
}
