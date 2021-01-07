//
//  AddGlassViewController.swift
//  Proyecto LSP
//
//  Created by r on 25/11/2020.
//  Copyright © 2020 Cristian Alvarez hossein. All rights reserved.
//

import UIKit

class AddGlassViewController: UIViewController{
    

    @IBOutlet weak var guardar: UIBarButtonItem!
    

    @IBOutlet weak var sliderLabel: UILabel!
    
    @IBOutlet weak var labelAl: UILabel!
    
    @IBOutlet weak var labelBa: UILabel!
    
    @IBOutlet weak var labelMg: UILabel!
    
    @IBOutlet weak var labelNa: UILabel!
    
    @IBOutlet weak var labelIR: UILabel!
    
    @IBOutlet weak var sliderIndRef: UISlider!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    var cristales = ["Cristal de construcción flotado", "Cristal de construcción no flotado", "Cristal de vehículo flotado", "Cristal de vehículo no flotado", "Cristal de contenedor", "Cristal de cubertería", "Cristal de luz de coche"]
    
    var selected:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Nuevo cristal"
        pickerView.delegate = self
        pickerView.dataSource = self
        sliderLabel.text = ""
        sliderIndRef.minimumValue = 1.5112
        sliderIndRef.maximumValue = 1.5339
        
        
    }
    
    @IBAction func guardarCristal(_ sender: Any) {
        //Hace cosas con la BBDD
        
        
        
         performSegue    (withIdentifier: "cancelar", sender: self)
    }
    
    @IBAction func cancelar(_ sender: Any) {
        
        performSegue    (withIdentifier: "cancelar", sender: self)
        
    }
    @IBAction func sliderValueChanged(_ sender: Any) {
        //sliderLabel.text = "\(sliderIndRef.value)"
        sliderLabel.text = String(format:"%.4f",sliderIndRef.value)
    }
    
    
}

extension AddGlassViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return cristales.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component:Int) -> String?{
        return cristales[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        self.selected = cristales[pickerView.selectedRow(inComponent: 0)]
        print(selected)
    }
    
}

extension AddGlassViewController: UIImagePickerControllerDelegate{
    
    
    
}
