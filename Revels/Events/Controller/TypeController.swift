//
//  TypeController.swift
//  Revels
//
//  Created by Vedant Jain on 22/02/19.
//  Copyright © 2019 Naman Jain. All rights reserved.
//

import UIKit

class TypeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let cellID = "cellID"
    private var type: [String] = ["Cultural", "Open", "Supporting"]
    private var eventCount: [Int] = [0, 0, 0]
    var data = [CategoryStruct]()
    
    //gradients
    private var firstColour: [UIColor] = [UIColor.init(r: 227, g: 122, b: 180), UIColor.init(r: 247, g: 226, b: 170), UIColor.init(r: 135, g: 145, b: 179), UIColor.init(r: 33, g: 147, b: 176), UIColor.init(r: 201, g: 75, b: 75)]
    private var secondColour: [UIColor] = [UIColor.init(r: 228, g: 144, b: 151), UIColor.init(r: 223, g: 168, b: 157), UIColor.init(r: 128, g: 91, b: 146), UIColor.init(r: 109, g: 213, b: 237), UIColor.init(r: 75, g: 19, b: 79)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.backgroundColor = .white

        self.title = "Events"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        networking()
        
        collectionView?.register(TypeCell.self, forCellWithReuseIdentifier: cellID)
        
    }
    
    fileprivate func updateCount() {
        for t in 0...2 {
            for ele in data {
                if ele.type == self.type[t].uppercased() {
                    self.eventCount[t] = self.eventCount[t] + 1
                }
            }
        }
        print(eventCount)
        
    }
    
    fileprivate func networking() {
        LoadingOverlay.shared.showOverlay(view: self.view)
        let jsonURLString: String = "https://api.mitrevels.in/categories"
        guard let url:URL = URL(string: jsonURLString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            //check for error?
            if let err = err {
                print("Failed to get data from url", err)
                return
            }
            guard let data = data else {return}
            
            do {
                
                // parse
                self.data = try JSONDecoder().decode(CategoryContainer.self, from: data).data
                
                // get # of categories for each type
                self.updateCount()
                
                //remove loading overlay
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    LoadingOverlay.shared.hideOverlayView()
                }
                
            }
            catch let jsonErr {
                print("Error serializing json: ", jsonErr)
            }
            
        }.resume()
        
        print("got data")
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TypeCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! TypeCell
        cell.layer.insertSublayer(gradient(frame: (cell.bounds), firstColor: firstColour[indexPath.item%firstColour.count], secondColor: secondColour[indexPath.item%secondColour.count]), at: 0)
        cell.title.text = type[indexPath.item]
        cell.category.text = String(eventCount[indexPath.item]) + " categories"
        cell.imageView = UIImageView.init(image: UIImage.init(named: "CellIcons"))
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return type.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let categoryController = CategoryController()
        categoryController.tapped = type[indexPath.item]
        print(categoryController.tapped)
        for ele in data {
            if ele.type == type[indexPath.item].uppercased() {
                categoryController.data.append(ele)
            }
        }
        self.navigationController?.pushViewController(categoryController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 32, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
    }
    
    func gradient(frame:CGRect, firstColor: UIColor, secondColor: UIColor) -> CAGradientLayer {
        let layer = CAGradientLayer()
        layer.frame = frame
        layer.startPoint = CGPoint(x: 0, y: 0.5)
        layer.endPoint = CGPoint(x: 1, y: 0.5)
        layer.colors = [
            firstColor.cgColor, secondColor.cgColor]
        return layer
    }
    
}
