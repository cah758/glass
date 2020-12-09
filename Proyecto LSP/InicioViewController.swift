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
        let pass:String
    }
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var passwordUsuario: UITextField!
    @IBOutlet weak var iniciarSesionBtn: UIButton!
    @IBOutlet weak var recordarPassBtn: UIButton!
    @IBOutlet weak var registroBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func iniciarSesion(_ sender: Any) {
        
        let url = URL(string:"http://lps.tabalu.es/API/auth/login")
        
        let uploadDataModel = user(email:email.text as String!, pass:passwordUsuario.text as String!)
        
        guard let jsonData = try? JSONEncoder().encode(uploadDataModel) else{
            print("iofeiofeiojefwj")
            return
        }
        
        var request = URLRequest(url:url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField:"Content-Type")
        request.setValue("application/json", forHTTPHeaderField:"Accept")
        request.httpBody = jsonData
        request.httpMethod = "POST"
        let dataTask = URLSession.shared.dataTask(with:request){
            data,_,error in
            if let error = error{
                print(error);return
            }
            do{
                DispatchQueue.main.async {
                    //AQUI VA EL SEGUE
                }
            }
        }
        dataTask.resume()

        
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
