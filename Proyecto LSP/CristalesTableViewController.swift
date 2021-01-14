//
//  CristalesTableViewController.swift
//  Proyecto LSP
//
//  Created by Bruno on 01/12/2020.
//  Copyright © 2020 Cristian Alvarez hossein. All rights reserved.
//

import UIKit

class CristalesTableViewController: UITableViewController {

    struct cristal:Codable{
        let id:Int
        let aluminum:Double
        let sodium:Double
        let magnesium:Double
        let barium:Double
        let refractive_index:Double
        let attribute_class:String
        let type_consult:String
        let project_id:Int
        let created_at:String
        let updated_at:String
    }
    
    var cristales:[cristal] = []
    var idCaso:Int = 0
    var nombre:String = ""
    
    struct caso:Codable{
        let id:Int
        let nombreCaso:String
        let cristales:[cristal]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = nombre
        
        fetchData()
        
    }

    
    func fetchData(){
        
        let url = URL(string:"https://lps.tabalu.es/api/auth/project/\(idCaso)")
        
        let token = UserDefaults.standard.object(forKey: "token") as! String
        var request = URLRequest(url:url!)
        request.httpMethod = "GET"
        request.setValue("\(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("*/*", forHTTPHeaderField: "Accept")
        request.setValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")
        
        
        let dataTask = URLSession.shared.dataTask(with:request){
            data,response,error in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else{
                if let error = error{
                    print(error)
                }
                return
            }
            
            if response.statusCode == 200{
                let decoder = JSONDecoder()
                do{
                    let crystals = try decoder.decode([cristal].self,from: data)
                    for cr in crystals{
                        print(cr.id, cr.attribute_class)
                    }
                    self.cristales = crystals
                    
                }catch{
                    print("HE MUERTO")
                }
            }else{
                print("RESPUESTA MALA:\(response.statusCode)")
            }
            
            
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
            
            }.resume()
        
    }
    
    
    @IBAction func unwindCristales(_ seg:UIStoryboardSegue){
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cristales.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CristalTableViewCell", for: indexPath) as! CristalTableViewCell

        cell.cristalLbl.text = cristales[indexPath.row].attribute_class
        
        //If elses del att clase para las fotos
        
        return cell
    }
 

    func deleteCristal(id:Int){
        
        let url = URL(string:"https://lps.tabalu.es/api/auth/destroyGlass/\(id)")
        
        let token = UserDefaults.standard.object(forKey: "token") as! String
        var request = URLRequest(url:url!)
        request.httpMethod = "GET"
        request.setValue("\(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("*/*", forHTTPHeaderField: "Accept")
        request.setValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")
        
        
        let dataTask = URLSession.shared.dataTask(with:request){
            data,response,error in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else{
                if let error = error{
                    print(error)
                }
                return
            }
            
            if response.statusCode == 201{
                let alert = UIAlertController(title: "Cristal eliminado correctamente", message: "", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default)
                alert.addAction(okAction)
                self.present(alert,animated: true)
                DispatchQueue.main.async {
                    self.fetchData()
                }
            }else{
                print("RESPUESTA MALA:\(response.statusCode)")
            }
            
            
            }.resume()
        
        
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle != .delete {
            return
        }
        
        let alert = UIAlertController(title: "¿Quieres eliminar este cristal?", message: "", preferredStyle: .alert)
        let aceptar = UIAlertAction(title: "Eliminar", style: .destructive, handler: { _ in
            self.deleteCristal(id:self.cristales[indexPath.row].id)
            self.cristales.remove(at:indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        })
        let cancelar = UIAlertAction(title:"Cancelar", style: .cancel)
        alert.addAction(aceptar)
        alert.addAction(cancelar)
        present(alert, animated:true)
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Eliminar cristal"
    }

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "glassDetails") {
            
            let selectedRow = tableView.indexPath(for: sender as! CristalTableViewCell)?.row
            let viewDestiny = segue.destination as! DatosCristalViewController
            print(viewDestiny.nombreCristal)
            
            viewDestiny.nombreC = cristales[selectedRow!].attribute_class
            viewDestiny.al = cristales[selectedRow!].aluminum
            viewDestiny.ba = cristales[selectedRow!].barium
            viewDestiny.na = cristales[selectedRow!].sodium
            viewDestiny.iR = cristales[selectedRow!].refractive_index
            viewDestiny.mg = cristales[selectedRow!].magnesium
        }
        
    }
    

}
