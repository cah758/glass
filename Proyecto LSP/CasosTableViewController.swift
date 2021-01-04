//
//  CasosTableViewController.swift
//  Proyecto LSP
//
//  Created by Bruno on 01/12/2020.
//  Copyright © 2020 Cristian Alvarez hossein. All rights reserved.
//

import UIKit

class CasosTableViewController: UITableViewController {

    struct newCase:Codable{
        let nombre:String
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string:"https://lps.tabalu.es/api/auth/projects")
        guard let jsonData = try? JSONEncoder().encode(<#T##value: Encodable##Encodable#>)
        
        var request = URLRequest(url:url!)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = jsonData
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
    @IBAction func addCase(_ sender: Any) {
        
        let alert = UIAlertController(title:"Nuevo caso", message: "Añade un nuevo caso", preferredStyle: .alert)
        let guardar = UIAlertAction(title:"Guardar", style: .default){
            [unowned self] action in
            guard let textField = alert.textFields?.first,
                let caseName = textField.text else{
                    return
            }
            //Aqui se hace lo de guardar en la BBDD creo
            
            let url = URL(string:"https://lps.tabalu.es/api/auth/projects")
            
            let uploadDataModel = newCase(nombre: caseName)
            
            struct createdCase:Codable{
                
            }
            
            guard let jsonData = try? JSONEncoder().encode(uploadDataModel) else{
                print("Error creando el caso")
                return
            }
            
            var request = URLRequest(url:url!)
            request.httpMethod = "POST"
            request.setValue("application/json",forHTTPHeaderField: "Content-Type")
            request.setValue("application/json",forHTTPHeaderField: "Accept")
            request.httpBody = jsonData
            
            let dataTask = URLSession.shared.dataTask(with: request){
                data,response,error in
                if let error = error{
                    print(error);return
                }
                let httpResponse = response as? HTTPURLResponse
                if(httpResponse!.statusCode != 201){
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title:"Error",message:"Ha habido un error.", preferredStyle:.alert)
                        let okAction = UIAlertAction(title:"Ok", style: .cancel)
                        
                        alert.addAction(okAction)
                        self.present(alert,animated:true)
                    }
                    
                }
                
            }
            dataTask.resume()
            
            print(caseName)
            self.tableView.reloadData()
        }
        
        let cancelar = UIAlertAction(title:"Cancelar", style: .cancel)
        alert.addTextField()
        
        alert.addAction(guardar)
        alert.addAction(cancelar)
        
        present(alert, animated:true)
        
    }
    
    @IBAction func cerrarSesion(_ sender: Any) {
        
        
        
        performSegue(withIdentifier: "cerrarSesion", sender: self)
        
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
