//
//  ViewController.swift
//  PeticionOpenLibrary
//
//  Created by Administrador on 18/10/17.
//  Copyright © 2017 palauturf. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITextFieldDelegate {
    
    var colorVerde = UIColor(red: 94/255, green: 173/255, blue: 53/255, alpha: 1)
    
    var colorRojo = UIColor(red: 204/255, green: 34/255, blue: 53/255, alpha: 1)
    
    @IBOutlet weak var numISBN: UITextField!
    
    @IBOutlet weak var estadoConexionLbl: UILabel!
    
    @IBOutlet weak var textoResultado: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        numISBN.delegate = self
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func textFieldDoneEditing(sender: UITextField) {
       
        sender.resignFirstResponder()
        asincrono()
        
    }
    
    @IBAction func backGroundTap(sender: UIControl) {
        
        numISBN.resignFirstResponder()
        
    }
  
    func asincrono() {
      
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:\(numISBN.text!)"
        let url = URL(string: urls)
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { (data, response, error) in
    
            DispatchQueue.main.async(execute: {
            
                if error == nil {
                    
                let texto = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("\(response!)")
                self.textoResultado.text = "\(texto!)"
                self.estadoConexionLbl.text = "Conexión Exitosa"
                self.estadoConexionLbl.backgroundColor = self.colorVerde
                }
                
                else if error != nil {
                
                self.estadoConexionLbl.text = "Conexión Fallida"
                self.estadoConexionLbl.backgroundColor = self.colorRojo
                }
            }
        )}
    
        task.resume()
        textoResultado.text = urls
    
    }
   
    //self.resultadoTextView.text = "Buscando Sitio \(urls)"
    
}
