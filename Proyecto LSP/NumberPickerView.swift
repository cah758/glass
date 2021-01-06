//
//  NumberPickerView.swift
//  Proyecto LSP
//
//  Created by Bruno on 06/01/2021.
//  Copyright © 2021 Cristian Alvarez hossein. All rights reserved.
//

import UIKit

class NumberPickerView: UIPickerView {

    var cristales = ["Cristal de construcción flotado", "Cristal de construcción no flotado", "Cristal de vehículo flotado", "Cristal de vehículo no flotado", "Cristal de contenedor", "Cristal de cubertería", "Cristal de luz de coche"]
    
    var selected:String = ""
    
    func numberOfComponents(in weightPickerView: UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return cristales.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, inComponent component:Int) -> String?{
        return cristales[row % cristales.count]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        selected = cristales[component]
    }
}
