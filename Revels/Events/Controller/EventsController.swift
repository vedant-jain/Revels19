//
//  EventsController.swift
//  Revels
//
//  Created by Vedant Jain on 26/02/19.
//  Copyright © 2019 Naman Jain. All rights reserved.
//

import UIKit

class EventsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var tapped = ""
    var eventID = 0
    private let cellID = "cellID"
    var eventArray: [EventStruct] = []
    private var data: [EventStruct] = []
    private var firstColour: [UIColor] = [UIColor.init(r: 227, g: 122, b: 180), UIColor.init(r: 247, g: 226, b: 170), UIColor.init(r: 135, g: 145, b: 179), UIColor.init(r: 33, g: 147, b: 176), UIColor.init(r: 201, g: 75, b: 75)]
    private var secondColour: [UIColor] = [UIColor.init(r: 228, g: 144, b: 151), UIColor.init(r: 223, g: 168, b: 157), UIColor.init(r: 128, g: 91, b: 146), UIColor.init(r: 109, g: 213, b: 237), UIColor.init(r: 75, g: 19, b: 79)]
    
    fileprivate func extractEvents() {
        for ele in eventArray {
            if ele.id == eventID {
                data.append(ele)
            }
        }
        
        print(data)
        
        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView!.register(EEventCell.self, forCellWithReuseIdentifier: cellID)
        
        collectionView.backgroundColor = .white
        
        self.title = tapped
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        extractEvents()
        
        collectionView.dataSource = self;
        collectionView.delegate = self;
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {if let cell = self.collectionView.cellForItem(at: indexPath) as? EEventCell {
        // estimate
        let approximateWidthOfDescLabel = view.frame.width - 64
        let size = CGSize(width: approximateWidthOfDescLabel, height: 1000)
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]
        let estimatedFrame = NSString(string: cell.descLabel.text!).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return CGSize(width: (view.frame.width-32), height: estimatedFrame.height + 75 + 52)
        }
        return CGSize(width: (view.frame.width-32), height: 200)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! EEventCell
        cell.layer.insertSublayer(gradient(frame: (cell.bounds), firstColor: firstColour[indexPath.item%firstColour.count], secondColor: secondColour[indexPath.item%secondColour.count]), at: 0)
        cell.titleLabel.text = data[indexPath.item].name
        cell.descLabel.text = data[indexPath.item].short_desc
        if (String(data[indexPath.item].min_size) == String(data[indexPath.item].max_size)) {
            cell.sizeLabel.text = "Participant(s): " + String(data[indexPath.item].min_size)
        } else {
            cell.sizeLabel.text = "Participant(s): " + String(data[indexPath.item].min_size) + "-" + String(data[indexPath.item].max_size)
        }
        cell.delegateCardLabel.text = "Delegate card: " + String(data[indexPath.item].del_card_type)
        return cell
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
