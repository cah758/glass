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
        let id:Int
        let name:String
        let state:Int
        let user_id:Int
        let created_at:String
        let updated_at:String
    }
    
    struct createCase:Codable{
        let name:String
        let state:Int
    }
    //Array para cargar los casos/proyectos. Esta puesto String temporalmente
    var casos:[newCase] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        fetchData()
        
        
    }
    
    func fetchData(){
        
        let url = URL(string:"https://lps.tabalu.es/api/auth/projects")
        
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
                    let posts = try decoder.decode([newCase].self,from: data)
                    for post in posts{
                        print(post.id, post.name)
                    }
                    self.casos = posts
                    
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
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return casos.count
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
            
            let url = URL(string:"https://lps.tabalu.es/api/auth/createProject")
            
            let token = UserDefaults.standard.object(forKey: "token") as! String
            var request = URLRequest(url:url!)
            request.httpMethod = "POST"
            request.setValue("\(token)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")
            
            let n = createCase(name:caseName, state:0)
            
            guard let jsonData = try? JSONEncoder().encode(n) else{
                print("Error al codificar")
                return
            }
            request.httpBody = jsonData
            
            
            let dataTask = URLSession.shared.dataTask(with:request){
                data,_,error in
                if let error = error{
                    print(error);return
                }
                    
                    let alert = UIAlertController(title: "Caso creado correctamente", message: "", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .destructive)
                    alert.addAction(okAction)
                    self.present(alert,animated: true)
                    DispatchQueue.main.async {
                        self.fetchData()
                    }
                    
            }
            
            dataTask.resume()
            
            
        }
        
        let cancelar = UIAlertAction(title:"Cancelar", style: .cancel)
        alert.addTextField()
        
        alert.addAction(guardar)
        alert.addAction(cancelar)
        
        present(alert, animated:true)
        
    }
    
    @IBAction func cerrarSesion(_ sender: Any) {
        
        let url = URL(string:"https://lps.tabalu.es/api/auth/logout")

        var request  = URLRequest(url:url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField:"Content-Type")
        //request.setValue("XMLHttpRequest", forHTTPHeaderField:"X-Requested-With")
        request.setValue("application/json", forHTTPHeaderField:"Accept")
        request.setValue(UserDefaults.standard.string(forKey: "token"), forHTTPHeaderField: "Authorization")
        
        let dataTask = URLSession.shared.dataTask(with:request){
            data,_,error in
            if let error = error{
                print(error);return
            }
            do{
                
                //TODO
                
                
            }
            catch {
                print("Error al cerrar sesion")
            }
        }

       dataTask.resume()
        
        performSegue	(withIdentifier: "cerrarSesion", sender: self)
        
    }
    
    func deleteCaso(id:Int){
        
        let url = URL(string:"https://lps.tabalu.es/api/auth/destroyProject/\(id)")
        
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
                let alert = UIAlertController(title: "Caso eliminado correctamente", message: "", preferredStyle: .alert)
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CasoTableViewCell", for: indexPath) as! CasoTableViewCell
        cell.nombreCasoLbl.text = casos[indexPath.row].name
        
        if(casos[indexPath.row].state == 1){
            cell.estadoCasoImg.image = UIImage(named:"check")
        }else{
            cell.estadoCasoImg.image = UIImage(named:"progress")
        }
    
        return cell
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
        
        let alert = UIAlertController(title: "¿Quieres eliminar este caso?", message: "", preferredStyle: .alert)
        let aceptar = UIAlertAction(title: "Eliminar", style: .destructive, handler: { _ in
            self.deleteCaso(id:self.casos[indexPath.row].id)
            self.casos.remove(at:indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        })
        let cancelar = UIAlertAction(title:"Cancelar", style: .cancel)
        alert.addAction(aceptar)
        alert.addAction(cancelar)
        present(alert, animated:true)
        
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Eliminar caso"
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
        if (segue.identifier != "cerrarSesion") {
            
            let selectedRow = tableView.indexPath(for: sender as! CasoTableViewCell)?.row
            let viewDestiny = segue.destination as! CristalesTableViewController
            viewDestiny.nombre = casos[selectedRow!].name
        }else{
            let viewDestiny = segue.destination as! InicioViewController
            viewDestiny.email.text = ""
            viewDestiny.passwordUsuario.text = ""
            viewDestiny.no = true
        }

    }
    

}
