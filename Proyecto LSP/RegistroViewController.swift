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
        let confPassword:String
        let username:String
        let nColegiado:String
        
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
        
        let uploadDataModel = newUser(email:emailTF.text as String!, password:passwordTF.text as String!, confPassword:confirmarPWTF.text as String!, username:nombreUsuarioTF.text as String!,nColegiado:numColegiadoTF.text as String!)
        
        struct signupData:Codable{
            let access_token: String
            let token_type:  String
            let expires_at:  String
        }
        
        if(uploadDataModel.password != uploadDataModel.confPassword){
            let alert = UIAlertController(title:"Error", message:"Las contraseñas deben coincidir", preferredStyle: .alert)
            let okAction = UIAlertAction(title:"Ok", style:.default)
            alert.addAction(okAction)
            present(alert,animated:true)
        }else{
            guard let jsonData = try? JSONEncoder().encode(uploadDataModel) else{
                print("iofeiofeiojefwj")
                return
            }
        
            var request  = URLRequest(url:url!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField:"Content-Type")
            //request.setValue("XMLHttpRequest", forHTTPHeaderField:"X-Requested-With")
            request.setValue("application/json", forHTTPHeaderField:"Accept")
            request.httpBody = jsonData
            
            print(uploadDataModel.password)
            request.httpMethod = "POST"
            let dataTask = URLSession.shared.dataTask(with:request){
                data,_,error in
                if let error = error{
                    print(error);return
                }
                do{
                    //print(String(data: data!, encoding: .utf8))
                    let token = try JSONDecoder().decode(signupData.self, from: data!).access_token
                    
                    UserDefaults.standard.set(token, forKey: "token")
                    
                    
                    DispatchQueue.main.async {
                        
                    }
                    
                }
                catch {
                    print("esto peta por todos sitios")
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
