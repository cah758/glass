//
//  RegistroViewController.swift
//  Proyecto LSP
//
//  Created by Bruno on 01/12/2020.
//  Copyright © 2020 Cristian Alvarez hossein. All rights reserved.
//

import UIKit

class RegistroViewController: UIViewController {

    struct newUser:Codable{
    
        let email:String
        let password:String
        let name:String
        let collegiate:String
        
    }

    @IBOutlet weak var nombreUsuarioTF: UITextField!
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var confirmarPWTF: UITextField!
    
    @IBOutlet weak var numColegiadoTF: UITextField!
    
    @IBOutlet weak var registrarseBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Create a gradient layer.
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.white.cgColor, UIColor(named: "AzulCorp")!.cgColor]
        gradientLayer.shouldRasterize = true
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1 )
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    @IBAction func registrarse(_ sender: Any) {
        
        let url = URL(string:"https://lps.tabalu.es/api/auth/signup")
        
        let uploadDataModel = newUser(email:emailTF.text as String!, password:passwordTF.text as String!, name:nombreUsuarioTF.text as String!,collegiate:numColegiadoTF.text as String!)
        
        struct signupData:Codable{
            let message:String
        }
        
        if(uploadDataModel.password != confirmarPWTF.text){
            let alert = UIAlertController(title:"Error", message:"Las contraseñas deben coincidir.", preferredStyle: .alert)
            let okAction = UIAlertAction(title:"Ok", style:.default)
            //okAction.setValue(UIColor(named: "VerdeCorp"), forKey: "titleTextColor")
            alert.addAction(okAction)
            present(alert,animated:true)
        }else if(uploadDataModel.name.isEmpty || uploadDataModel.password.isEmpty || uploadDataModel.email.isEmpty || uploadDataModel.collegiate.isEmpty){
            let alert = UIAlertController(title:"Error", message:"No puede haber campos vacíos.", preferredStyle: .alert)
            let okAction = UIAlertAction(title:"Ok", style:.default)
            //okAction.setValue(UIColor(named: "VerdeCorp"), forKey: "titleTextColor")
            alert.addAction(okAction)
            present(alert,animated:true)
        } else {
            guard let jsonData = try? JSONEncoder().encode(uploadDataModel) else{
                print("Error al codificar los datos.")
                return
            }
        
            var request  = URLRequest(url:url!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField:"Content-Type")
            request.setValue("XMLHttpRequest", forHTTPHeaderField:"X-Requested-With")
            request.setValue("application/json", forHTTPHeaderField:"Accept")
            request.httpBody = jsonData
            
            let dataTask = URLSession.shared.dataTask(with:request){
                data,response,error in
                if let error = error{
                    print(error);return
                }
                
                let httpResponse = response as? HTTPURLResponse
                
                if(httpResponse!.statusCode == 201){
                    DispatchQueue.main.async {
                        
                    
                    let alert = UIAlertController(title:"Usuario creado correctamente",message:"", preferredStyle:.alert)
                        let okAction = UIAlertAction(title:"Ok", style: .default){
                            alertAction in
                            self.performSegue(withIdentifier: "registrado", sender: self)
                        }
                        //okAction.setValue(UIColor(named: "VerdeCorp"), forKey: "titleTextColor")
                    alert.addAction(okAction)
                    self.present(alert,animated:true)
                    }
                    
                }else{
                    DispatchQueue.main.async {
                            let alerta = UIAlertController(title: "Error al crear la cuenta", message: "Los datos introducidos no son válidos.", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "Continuar", style: .default)
                        //okAction.setValue(UIColor(named: "VerdeCorp"), forKey: "titleTextColor")
                            alerta.addAction(okAction)
                            self.present(alerta, animated: true)
                        }
                    print("Moricion")
                    return
                }
                
            }
            dataTask.resume()
        }
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
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
