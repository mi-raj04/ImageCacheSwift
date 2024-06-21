//
//  ViewController.swift
//  ImageCacheGridInSwift
//
//  Created by mind on 15/04/24.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    @IBOutlet weak var networkUnavailableView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    private var cancellables = Set<AnyCancellable>()
    var data:ImageData?
    let model = ImageCollectionViewModel()
    let reachability = Reachability()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Images"
        reachability.$isConnected.sink { value in
            if value {
                self.collectionView.isHidden = false
                self.networkUnavailableView.isHidden = true
            } else {
                self.collectionView.isHidden = true
                self.networkUnavailableView.isHidden = false
            }
        }.store(in: &cancellables)
        model.getData()
        model.$imageList.sink { result in
            self.data = result
            self.collectionView.reloadData()
        }.store(in: &cancellables)
    }
}

extension ViewController: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.image.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "ImageViewCell", for: indexPath) as? ImageViewCell
        cell?.setupCell(str: data?.image[indexPath.row].urls?.small ?? "")
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.bounds.size.width / 3), height: self.view.bounds.size.width / 2 - 20)
    }
}
