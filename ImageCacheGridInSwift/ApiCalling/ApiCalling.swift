//
//  ImageCollectionViewModel.swift
//  ImageCacherGrid
//
//  Created by mind on 15/04/24.
//

import Foundation
import Combine

class ApiCalling {
    
    let url = URL(string: "https://api.unsplash.com/photos/?client_id=QqlAW2GZ-5i-6ezyr6hom7K3CcBSt3CGLo21o7e_QTQ&per_page=100")
    
    func callApi() -> Future<ImageData,Error> {
        return Future<ImageData,Error> { [weak self] promise in
            let session = URLSession.shared.dataTask(with: (self?.url!)!) { data, response, error in
                guard let response = response as? HTTPURLResponse,
                      200 ... 299 ~= response.statusCode else {
                    promise(.failure(error!))
                    return
                }
                guard let data, error == nil else {
                    promise(.failure(error!))
                    return
                }
                do {
                    let obj = try JSONDecoder().decode([ImageCollection].self, from: data)
                    let objTest = ImageData(id: UUID(), image: obj)
                    promise(.success(objTest))
                    return
                    
                } catch {
                    print(error)
                }
            }
            session.resume()
        }
    }
    
}
