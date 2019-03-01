//
//  AboutCollectionViewController.swift
//  Revels
//
//  Created by Vedant Jain on 01/03/19.
//  Copyright © 2019 Naman Jain. All rights reserved.
//

import UIKit

class AboutCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellID = "cellID"
    private let names = ["Saptarshi", "Ritwik", "Harsh", "Akshit", "Ankush", "Naman", "Vaishnavi", "Vedant"]
    private let images: [UIImage] = [UIImage(named: "saptarshi") ?? UIImage(), UIImage(named: "ritwik") ?? UIImage(), UIImage(named: "harsh") ?? UIImage(), UIImage(named: "ankush") ?? UIImage(), UIImage(named: "naman") ?? UIImage(), UIImage(named: "vaishnavi") ?? UIImage(), UIImage(named: "vedant") ?? UIImage()]
    private let posts = [1, 1, 1, 0, 0, 0 ,0, 0]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        self.collectionView.backgroundColor = .white

        // Register cell classes
        self.collectionView!.register(AboutCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        
//        let doneButton = UIButton()
//        doneButton.setTitle("Done", for: .normal)
//        doneButton.addTarget(self, action: #selector(popViewController), for: .touchUpInside)
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(popViewController))
        self.navigationItem.rightBarButtonItem = barButtonItem
        
        self.title = "About Us"
        self.navigationController?.title = "About Us"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    @objc func popViewController() {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width/2)-32, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! AboutCollectionViewCell
        // Configure the cell
        cell.imageView.image = UIImage(named: "ig-1")
        cell.titleLabel.text = names[indexPath.item]
        if Int(names[indexPath.item]) ?? -1 == 0 {
            cell.postLabel.text = "Organizer"
        }
        else {
            cell.postLabel.text = "Category Head"
        }
        return cell
    }

}
