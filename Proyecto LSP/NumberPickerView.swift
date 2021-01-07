//
//  NumberPickerView.swift
//  Proyecto LSP
//
//  Created by Bruno on 06/01/2021.
//  Copyright © 2021 Cristian Alvarez hossein. All rights reserved.
//

import UIKit

class NumberPickerView: UIPickerView {

    let numeros = Array(0...9)
    
    
    var selected:Int = 0
    
    //var pickerData = [[numeros],[numeros],[numeros],[numeros]]
    
    
    
    
    func numberOfComponents(in weightPickerView: UIPickerView) -> Int{
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return numeros.count
    }
   
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, inComponent component:Int) -> String?{
        return String(numeros[row])
    }
    /*
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        selected = pickerData[0][row]
        print(selected)
    }*/
}
