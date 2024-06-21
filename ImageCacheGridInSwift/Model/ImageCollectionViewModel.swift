//
//  ImageCollectionViewModel.swift
//  ImageCacheGridInSwift
//
//  Created by mind on 15/04/24.
//

import Foundation
import Combine

class ImageCollectionViewModel:ObservableObject,Identifiable {
    var id = UUID()
    @Published var imageList:ImageData?
    private var cancellables = Set<AnyCancellable>()
    
    func getData() {
        let apicalling = ApiCalling()
        apicalling.callApi()
            .sink { completion in
                switch completion {
                case .finished:
                    print("Finished")
                case .failure(let err):
                    print("Error is \(err.localizedDescription)")
                }
            } receiveValue: { [weak self] imageResult in
                DispatchQueue.main.async {
                    self?.imageList = imageResult
                }
            }
            .store(in: &cancellables)
    }
}
