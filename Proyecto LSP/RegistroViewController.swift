//
//  RegistroViewController.swift
//  Proyecto LSP
//
//  Created by Bruno on 01/12/2020.
//  Copyright © 2020 Cristian Alvarez hossein. All rights reserved.
//

import UIKit

class RegistroViewController: UIViewController {

    

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
