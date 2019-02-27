//
//  CategoryController.swift
//  Revels
//
//  Created by Vedant Jain on 24/02/19.
//  Copyright © 2019 Naman Jain. All rights reserved.
//

import UIKit

class CategoryController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate {

    private let cellID = "cellID"
    var tapped: String = ""
    var container = CategoryContainer()
    var data: [DataStruct] = []
    var eventArray: [EventStruct] = []
    
    //rgb(201, 75, 75)
    private var firstColour: [UIColor] = [UIColor.init(r: 227, g: 122, b: 180), UIColor.init(r: 247, g: 226, b: 170), UIColor.init(r: 135, g: 145, b: 179), UIColor.init(r: 33, g: 147, b: 176), UIColor.init(r: 201, g: 75, b: 75)]
    //rgb(75, 19, 79)
    private var secondColour: [UIColor] = [UIColor.init(r: 228, g: 144, b: 151), UIColor.init(r: 223, g: 168, b: 157), UIColor.init(r: 128, g: 91, b: 146), UIColor.init(r: 109, g: 213, b: 237), UIColor.init(r: 75, g: 19, b: 79)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView!.register(CategoryCell.self, forCellWithReuseIdentifier: cellID)
        
        collectionView.backgroundColor = .white
        
        self.title = tapped
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        for ele in container.data {
            if ele.type == tapped.uppercased() {
                data.append(ele)
            }
        }
        
        getEvents()
        
        //long press gesture recognizer
        let longPressGestureRecognizer : UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
        longPressGestureRecognizer.minimumPressDuration = 0.5
        longPressGestureRecognizer.delegate = self
        longPressGestureRecognizer.delaysTouchesBegan = true
        self.collectionView?.addGestureRecognizer(longPressGestureRecognizer)
        
        collectionView.dataSource = self;
        collectionView.delegate = self;
    }
    
    func getEvents() {
        let jsonURLString: String = "http://api.mitrevels.in/events"
        guard let url:URL = URL(string: jsonURLString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            //check for error?
            if let err = err {
                print("Failed to get data from url", err)
                return
            }
            guard let data = data else {return}
            //            let dataAsString = String(data: data, encoding: .utf8)
            
            do {
                // success
                self.eventArray = try JSONDecoder().decode(EventContainer.self, from: data).data
            }
            catch let jsonErr {
                print("Error serializing json: ", jsonErr)
            }
            
            }.resume()
        
        print("got data")
    }
    
    @objc func handleLongPress(gestureRecognizer : UILongPressGestureRecognizer) {
        if (gestureRecognizer.state != UIGestureRecognizer.State.began){
            // gestureRecognizer.location(in: view) ~> CategoryCell if pressed on cell, otherwise return
            if let indexPath = self.collectionView.indexPathForItem(at: gestureRecognizer.location(in: self.collectionView)) {
                //code
                let actionSheet = UIAlertController(title: data[indexPath.item].name, message: "Call", preferredStyle: .actionSheet)
                
                actionSheet.addAction(UIAlertAction(title: "CC 1: " + data[indexPath.item].cc1_name, style: UIAlertAction.Style.default, handler: { (action) -> Void in
                    guard let number = URL(string: "tel://" + self.data[indexPath.item].cc1_contact) else { return }
                    UIApplication.shared.open(number)
                }))
                
                actionSheet.addAction(UIAlertAction(title: "CC 2: " + data[indexPath.item].cc2_name, style: UIAlertAction.Style.default, handler: { (action) -> Void in
                    guard let number = URL(string: "tel://" + self.data[indexPath.item].cc2_contact) else { return }
                    UIApplication.shared.open(number)
                }))
                
                actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { (action) -> Void in
                    //cancel
                }))
                
                self.present(actionSheet, animated: true, completion: nil)
                
            }
            
            return
        }

    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CategoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CategoryCell
        cell.layer.insertSublayer(gradient(frame: (cell.bounds), firstColor: firstColour[indexPath.item%firstColour.count], secondColor: secondColour[indexPath.item%secondColour.count]), at: 0)
        cell.titleLabel.text = data[indexPath.item].name
        cell.descLabel.text = data[indexPath.item].description
        cell.ccLabel.text = data[indexPath.item].cc1_name + ": " + data[indexPath.item].cc1_contact + "\n" + data[indexPath.item].cc2_name + ": " + data[indexPath.item].cc2_contact
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let cell = self.collectionView.cellForItem(at: indexPath) as? CategoryCell {
            // estimate
            let approximateWidthOfDescLabel = view.frame.width - 64
            let size = CGSize(width: approximateWidthOfDescLabel, height: 1000)
            let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]
            let estimatedFrame = NSString(string: cell.descLabel.text!).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
            return CGSize(width: (view.frame.width-32), height: estimatedFrame.height + 75 + 52)
        }
        return CGSize(width: (view.frame.width-32), height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let eventsController = EventsController(collectionViewLayout: UICollectionViewFlowLayout())
        eventsController.tapped = data[indexPath.item].name
        eventsController.eventID = data[indexPath.item].id
        eventsController.eventArray = self.eventArray
        self.navigationController?.pushViewController(eventsController, animated: true)
        
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
