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
    
    @IBOutlet weak var tipoCristalLabel: UILabel!
    
    @IBOutlet weak var alImg: UIImageView!
    
    @IBOutlet weak var baImg: UIImageView!
    
    @IBOutlet weak var mgImg: UIImageView!
    
    @IBOutlet weak var naImg: UIImageView!
    
    var attClase:String = ""
    var tipoConsulta:String = ""
    struct newCristal:Codable{
        let aluminum:Double
        let sodium:Double
        let magnesium:Double
        let barium:Double
        let refractive_index:Double
        let attribute_class:String
        let type_consult:String
        let project_id:Int
    }
    
    var proyectoId:Int = -1
    
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
       
        #if LPSAlgoritmo
            pickerView.isHidden = true
            tipoCristalLabel.isHidden = true
        #endif
       
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
        
        #if LPSAlgoritmo
            attClase = algoritmo()
            tipoConsulta = "Automatica"
        #else
        attClase = selected
            tipoConsulta = "Manual"
        #endif
        
        let alerta = UIAlertController(title: "¿Quieres guardar este cristal?", message: "Vas a crear un cristal del tipo: \n\(attClase)", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Guardar", style: .default, handler:{ action in
                self.guardarGlass()
        })
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .destructive)
        
        alerta.addAction(okAction)
        alerta.addAction(cancelAction)
        present(alerta,animated: true)
        
    }
    
    func guardarGlass(){
        let a = Double(labelAl.text!)
        let so = Double(labelNa.text!)
        let mag = Double(labelMg.text!)
        let bar = Double(labelBa.text!)
        let indr = Double(labelIR.text!)
        
        let c = newCristal(aluminum: a!, sodium: so!, magnesium: mag!, barium: bar!, refractive_index: indr!, attribute_class: attClase, type_consult: tipoConsulta, project_id: proyectoId)
        
        let url = URL(string:"https://lps.tabalu.es/api/auth/createGlass")
        
        let token = UserDefaults.standard.object(forKey: "token") as! String
        var request = URLRequest(url:url!)
        request.httpMethod = "POST"
        request.setValue("\(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")
        
        guard let jsonData = try? JSONEncoder().encode(c) else{
            print("Error al codificar")
            return
        }
        request.httpBody = jsonData
        
        
        let dataTask = URLSession.shared.dataTask(with:request){
            data,_,error in
            if let error = error{
                print(error);return
            }
            
            let alert = UIAlertController(title: "Cristal creado correctamente", message: "", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .destructive)
            alert.addAction(okAction)
            self.present(alert,animated: true)
            DispatchQueue.main.async {
                
            }
            
        }
        
        dataTask.resume()
        
        performSegue(withIdentifier: "cancelar", sender: self)
        
    }
    
    @IBAction func cancelar(_ sender: Any) {
        
        performSegue(withIdentifier: "cancelar", sender: self)
        
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
    
    #if LPSAlgoritmo
    func algoritmo() -> String{
        
        var cristal:String = ""
        let aluminio = (labelAl.text! as NSString).floatValue
        let bario = (labelBa.text! as NSString).floatValue
        let magnesio = (labelMg.text! as NSString).floatValue
        let sodio = (labelNa.text! as NSString).floatValue
        let indiceRef = (labelIR.text! as NSString).floatValue
        
        if(magnesio < 2.55){
            if(sodio < 13.82){
                if(indiceRef < 1.52){
                    cristal = "Cristal de contenedor"
                }else{
                    cristal = "Cristal de construcción no flotado"
                }
            }else{
                if(bario < 0.2){
                    cristal = "Cristal de cubertería"
                }else{
                    cristal = "Cristal de faro de coche"
                }
            }
        }else{
            if(aluminio < 1.42){
                if(indiceRef < 1.52){
                    cristal = "Cristal de vehículo flotado"
                }else{
                    if(sodio < 13.61){
                        if(magnesio < 3.67){
                            cristal = "Cristal de construcción flotado"
                        }else{
                            cristal = "Cristal de construcción no flotado"
                        }
                    }else{
                        cristal = "Cristal de construcción flotado"
                    }
                }
            }else{
                if(bario < 0.65){
                    cristal = "Cristal de construcción no flotado"
                }else{
                    cristal = "Cristal de faro de coche"
                }
            }
        }
        
        return cristal
    }
    #endif
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "cancelar"){
            let viewDestino = segue.destination as! CristalesTableViewController
            viewDestino.fetchData()
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

