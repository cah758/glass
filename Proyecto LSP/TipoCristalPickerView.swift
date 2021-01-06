//
//  TipoCristalPickerView.swift
//  Proyecto LSP
//
//  Created by Bruno on 01/12/2020.
//  Copyright © 2020 Cristian Alvarez hossein. All rights reserved.
//

import UIKit

class TipoCristalPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var cristales = ["Cristal de construcción flotado", "Cristal de construcción no flotado", "Cristal de vehículo flotado", "Cristal de vehículo no flotado", "Cristal de contenedor", "Cristal de cubertería", "Cristal de luz de coche"]
    
    var selected:String = ""
    
    func numberOfComponents(in weightPickerView: UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return cristales.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component:Int) -> String?{
        return cristales[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        selected = cristales[component]
    }

}
