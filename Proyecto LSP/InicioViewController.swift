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
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.white.cgColor, UIColor(named: "AzulCorp")!.cgColor]
        gradientLayer.shouldRasterize = true
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
                        let alerta = UIAlertController(title: "Error al iniciar sesión", message: "Introduce tus datos correctamente", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "Continuar", style: .default)
                        //okAction.setValue(UIColor(named: "VerdeCorp"), forKey: "titleTextColor")
                        alerta.addAction(okAction)
                        self.present(alerta, animated: true)
                    }
                }
            }
        }
        
        dataTask.resume()

        
    }
    @IBAction func forgotPass(_ sender: UIButton) {
        let alerta = UIAlertController(title: "Recordar contraseña", message: "", preferredStyle: .alert)
        
        alerta.addTextField { (inputTextField : UITextField) -> Void in
            inputTextField.placeholder = "Correo electrónico"
        }
        
        let okAction = UIAlertAction(title: "Continuar", style: .default) { _ in
            let url = URL(string:"https://lps.tabalu.es/api/auth/remember/\(alerta.textFields?.first?.text ?? "")")
            
            var request  = URLRequest(url:url!)
            request.httpMethod = "POST"
            
            let dataTask = URLSession.shared.dataTask(with:request){
                data,response,error in
                if let error = error{
                    print(error);return
                }
                let response = response as? HTTPURLResponse
                
                if(response?.statusCode == 200) {
                    self.confirmEmail()
                    
                } else {
                    self.errorConfirmEmail()
                }
            }
            dataTask.resume()
            
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: .destructive)
        
        //okAction.setValue(UIColor(named: "VerdeCorp"), forKey: "titleTextColor")
        
        alerta.addAction(cancelAction)
        alerta.addAction(okAction)
        self.present(alerta, animated: true)
    }
    
    func confirmEmail() {
        let alerta2 = UIAlertController(title: "Correo enviado", message: "Compruebe su bandeja de entrada", preferredStyle: .alert)
        let okAction2 = UIAlertAction(title: "OK", style: .default)
        //okAction2.setValue(UIColor(named: "VerdeCorp"), forKey: "titleTextColor")
        alerta2.addAction(okAction2)
        self.present(alerta2, animated: true)
    }
    
    func errorConfirmEmail() {
        let alerta2 = UIAlertController(title: "Correo inexistente", message: "Pruebe a darse de alta", preferredStyle: .alert)
        let okAction2 = UIAlertAction(title: "OK", style: .default)
        //okAction2.setValue(UIColor(named: "VerdeCorp"), forKey: "titleTextColor")
        alerta2.addAction(okAction2)
        self.present(alerta2, animated: true)
    }
    
    @IBAction func unwind(_ seg:UIStoryboardSegue){
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
   // }
    

}
