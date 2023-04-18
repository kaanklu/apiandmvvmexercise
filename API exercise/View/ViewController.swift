//
//  ViewController.swift
//  API exercise
//
//  Created by Kaan Kalaycıoğlu on 16.04.2023.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var currencyList : [String] = []
    var valueList : [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource=self
        tableView.delegate=self
        let url = URL(string:"https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                
        }
            guard let data = data else{
                print(error?.localizedDescription ?? "error smthng")
                return
            }
            
            do {
                if let jsonData = try JSONSerialization.jsonObject(with: data) as? [[String : String]] {
                    
                    for i in jsonData {
                        if let currency = i["currency"] {
                            self.currencyList.append(currency)
                        }
                        if let value = i["price"] {
                            self.valueList.append(value)
                        }
                        
                    }
                    
                    
                }
            }catch{
                print("errorrr")
            }
            
            
            
        }.resume()
            }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoCell") as! CryptoTableViewCell
        cell.currencyLabel.text = currencyList[indexPath.row]
        cell.valueLabel.text = valueList[indexPath.row]
        return cell 
        
    }

    
}
