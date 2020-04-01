//
//  BaseNetworking.swift
//  Test
//
//  Created by Dipanjan Pal on 01/04/20.
//  Copyright © 2020 Dipanjan Pal. All rights reserved.
//

import Foundation
class BaseNetworking{
    
    //MARK: - common get api function
    static func getApi(completion : @escaping (_ model : WikiParaModel) -> ()){
        let url = URL(string: CommonConstants.shared.BASEURL)
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print("fetching error ===>> ", error as Any )
            }
            else{
                do {
                    let responseModel = try JSONDecoder().decode(WikiParaModel.self, from: data!)
                    print("responseModel ===>>> ", responseModel)
                    completion(responseModel)
                }
                catch let err {
                    print("decoding error ===>> ", err)
                }
            }
        }
        task.resume()
    }
}
