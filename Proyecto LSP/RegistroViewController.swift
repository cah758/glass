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
    
    @IBOutlet weak var cancelarBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let name = UserDefaults.standard.string(forKey: "token") ?? ""
        print(name)

        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func registrarse(_ sender: Any) {
        
        let url = URL(string:"https://lps.tabalu.es/api/auth/signup")
        
        let uploadDataModel = newUser(email:emailTF.text as String!, password:passwordTF.text as String!, name:nombreUsuarioTF.text as String!,collegiate:numColegiadoTF.text as String!)
        
        struct signupData:Codable{
            let message:String
        }
        
        if(uploadDataModel.password != confirmarPWTF.text){
            let alert = UIAlertController(title:"Error", message:"Las contraseñas deben coincidir", preferredStyle: .alert)
            let okAction = UIAlertAction(title:"Ok", style:.default)
            alert.addAction(okAction)
            present(alert,animated:true)
        }else{
            guard let jsonData = try? JSONEncoder().encode(uploadDataModel) else{
                print("nnioagiongaweriongewion")
                return
            }
        
            var request  = URLRequest(url:url!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField:"Content-Type")
            //request.setValue("XMLHttpRequest", forHTTPHeaderField:"X-Requested-With")
            request.setValue("application/json", forHTTPHeaderField:"Accept")
            request.httpBody = jsonData
            
            print(uploadDataModel.password)
            
            let dataTask = URLSession.shared.dataTask(with:request){
                data,response,error in
                if let error = error{
                    print(error);return
                }
                
                let httpResponse = response as? HTTPURLResponse
                
                if(httpResponse!.statusCode == 201){
                    DispatchQueue.main.async {
                        
                    
                    let alert = UIAlertController(title:"Usuario creado correctamente",message:"", preferredStyle:.alert)
                        let okAction = UIAlertAction(title:"Ok", style: .destructive){
                            alertAction in
                            self.performSegue(withIdentifier: "registrado", sender: self)
                        }
                    alert.addAction(okAction)
                    self.present(alert,animated:true)
                    }
                    
                }else{
                    print("Moricion")
                    return
                }
                
            }
            dataTask.resume()
        }
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
