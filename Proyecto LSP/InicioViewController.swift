//
//  InicioViewController.swift
//  Proyecto LSP
//
//  Created by Bruno on 01/12/2020.
//  Copyright © 2020 Cristian Alvarez hossein. All rights reserved.
//

import UIKit



class InicioViewController: UIViewController {

    struct user:Codable{
        let email:String
        let password:String
    }
    struct loginData:Codable{
        let access_token: String
        let token_type:  String
        let expires_at:  String
    }

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var passwordUsuario: UITextField!
    @IBOutlet weak var iniciarSesionBtn: UIButton!
    @IBOutlet weak var recordarPassBtn: UIButton!
    @IBOutlet weak var registroBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Create a gradient layer.
        let gradientLayer = CAGradientLayer()
        // Set the size of the layer to be equal to size of the display.
        gradientLayer.frame = view.bounds
        // Set an array of Core Graphics colors (.cgColor) to create the gradient.
        // This example uses a Color Literal and a UIColor from RGB values.
        gradientLayer.colors = [UIColor.white.cgColor, UIColor(named: "VerdeCorp")!.cgColor]
        // Rasterize this static layer to improve app performance.
        gradientLayer.shouldRasterize = true
        // Apply the gradient to the backgroundGradientView.
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1 )
        view.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
    @IBAction func iniciarSesion(_ sender: Any) {
        
        let url = URL(string:"https://lps.tabalu.es/api/auth/login")
        
        let uploadDataModel = user(email:email.text as String!, password:passwordUsuario.text as String!)
        
        guard let jsonData = try? JSONEncoder().encode(uploadDataModel) else{
            print("Error al codificar")
            return
        }
       
        var request  = URLRequest(url:url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField:"Content-Type")
        //request.setValue("XMLHttpRequest", forHTTPHeaderField:"X-Requested-With")
        request.setValue("application/json", forHTTPHeaderField:"Accept")
        request.httpBody = jsonData
        
        let dataTask = URLSession.shared.dataTask(with:request){
            data,response,error in
            if let error = error{
                print(error);return
            }
            let response = response as? HTTPURLResponse
            do{
                
                let token =  try JSONDecoder().decode(loginData.self, from: data!).access_token
                
                UserDefaults.standard.set("Bearer " + token, forKey: "token")
                
                DispatchQueue.main.async {
                    if(response?.statusCode == 200){
                        self.performSegue(withIdentifier: "iniciarSesion", sender: self)
                    }
                    
                }
                
            }
            catch {
                DispatchQueue.main.async {
                    if (((response?.statusCode)! >= 400 && (response?.statusCode)! < 500)){
                        let alerta = UIAlertController(title: "Error al iniciar sesión,", message: "Introduce tus datos correctamente", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "Continuar", style: .destructive)
                        alerta.addAction(okAction)
                        self.present(alerta, animated: true)
                    }
                }
            }
        }
        
        dataTask.resume()

        
    }
    
    @IBAction func unwind(_ seg:UIStoryboardSegue){
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
    }
    

}
