//
//  WebService.swift
//  API exercise
//
//  Created by Kaan Kalaycıoğlu on 17.04.2023.
//

import Foundation

class WebService {
    
    func getCurrencies(url:URL, completion : @escaping ([CryptoCurrency]?) -> ()) {
        
        URLSession.shared.dataTask(with: url) { Data, response, error in
            if error == nil {
                do {
                    let currencyList = try JSONDecoder().decode([CryptoCurrency].self,from: Data!)
                    print(currencyList)
                        completion(currencyList)
                    
                }catch{
                    print("error")
                }
                
                
            }
            else if error != nil {
                print(error?.localizedDescription ?? "error")
                completion(nil)
            }
        }.resume()
                
    }
}
