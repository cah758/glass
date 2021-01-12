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
    

    @IBOutlet weak var iRImg: UIImageView!
    
    
    @IBOutlet weak var labelAl: UILabel!
    
    @IBOutlet weak var labelBa: UILabel!
    
    @IBOutlet weak var labelMg: UILabel!
    
    @IBOutlet weak var labelNa: UILabel!
    
    @IBOutlet weak var labelIR: UILabel!
    
    @IBOutlet weak var sliderIndRef: UISlider!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
   
    @IBOutlet weak var alImg: UIImageView!
    
    @IBOutlet weak var baImg: UIImageView!
    
    @IBOutlet weak var mgImg: UIImageView!
    
    @IBOutlet weak var naImg: UIImageView!
    
    var cristales = ["Cristal de construcción flotado", "Cristal de construcción no flotado", "Cristal de vehículo flotado", "Cristal de vehículo no flotado", "Cristal de contenedor", "Cristal de cubertería", "Cristal de luz de coche"]
    
    var selected:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Nuevo cristal"
        pickerView.delegate = self
        pickerView.dataSource = self
        
        sliderIndRef.minimumValue = 1.5112
        sliderIndRef.maximumValue = 1.5339
        sliderIndRef.isUserInteractionEnabled = true
        
       
    }
    
    
    @IBAction func didTapImageView(_ sender: UITapGestureRecognizer) {
       
        alImg.isHighlighted = true
        baImg.isHighlighted = false
        mgImg.isHighlighted = false
        naImg.isHighlighted = false
        iRImg.isHighlighted = false
        
        sliderIndRef.setValue(0.29, animated: true)
        sliderIndRef.minimumValue = 0.29
        
        sliderIndRef.maximumValue = 3.5
    }
    
    @IBAction func didTapIR(_ sender: UITapGestureRecognizer) {
        
      
        alImg.isHighlighted = false
        baImg.isHighlighted = false
        mgImg.isHighlighted = false
        naImg.isHighlighted = false
        iRImg.isHighlighted = true
        sliderIndRef.setValue(1.5112, animated: true)
        sliderIndRef.minimumValue = 1.5112
        sliderIndRef.maximumValue = 1.5339
    }
    
    
    @IBAction func tapImageNa(_ sender: UITapGestureRecognizer) {
        
        alImg.isHighlighted = false
        baImg.isHighlighted = false
        mgImg.isHighlighted = false
        naImg.isHighlighted = true
        iRImg.isHighlighted = false
        sliderIndRef.minimumValue = 10.73
        sliderIndRef.maximumValue = 17.38
        sliderIndRef.setValue(10.73, animated: true)
    }
    
    
    @IBAction func tapImageBa(_ sender: UITapGestureRecognizer) {
        alImg.isHighlighted = false
        baImg.isHighlighted = true
        mgImg.isHighlighted = false
        naImg.isHighlighted = false
        iRImg.isHighlighted = false
        
        sliderIndRef.minimumValue = 0
        sliderIndRef.maximumValue = 3.15
        sliderIndRef.setValue(0, animated: true)
    }
    
    @IBAction func tapImageMg(_ sender: UITapGestureRecognizer) {
        alImg.isHighlighted = false
        baImg.isHighlighted = false
        mgImg.isHighlighted = true
        naImg.isHighlighted = false
        iRImg.isHighlighted = false
        sliderIndRef.minimumValue = 0
        sliderIndRef.maximumValue = 4.49
        sliderIndRef.setValue(0, animated: true)
    }
 
    
    
    @IBAction func guardarCristal(_ sender: Any) {
        //Hace cosas con la BBDD
        
        
        
         performSegue    (withIdentifier: "cancelar", sender: self)
    }
    
    @IBAction func cancelar(_ sender: Any) {
        
        performSegue    (withIdentifier: "cancelar", sender: self)
        
    }
    
    @IBAction func sliderValueChanged(_ sender: Any?){

        if(alImg.isHighlighted){
            labelAl.text = String(format:"%.2f",sliderIndRef.value)
        }else if(baImg.isHighlighted){
            labelBa.text = String(format:"%.2f",sliderIndRef.value)
        }else if(mgImg.isHighlighted){
            labelMg.text = String(format:"%.2f", sliderIndRef.value)
        }else if(naImg.isHighlighted){
            labelNa.text = String(format:"%.2f", sliderIndRef.value)
        }else if(iRImg.isHighlighted){
            labelIR.text = String(format:"%.4f",sliderIndRef.value)
        }
        
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

