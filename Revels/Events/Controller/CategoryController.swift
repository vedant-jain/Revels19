//
//  CategoryController.swift
//  Revels
//
//  Created by Vedant Jain on 24/02/19.
//  Copyright © 2019 Naman Jain. All rights reserved.
//

import UIKit

class CategoryController: UITableViewController {

    private let cellID = "cellID"
    var tapped: String = ""
    var data: [CategoryStruct] = []
    var eventArray: [EventStruct] = []
    
    //gradients
    private var firstColour: [UIColor] = [UIColor.init(r: 227, g: 122, b: 180), UIColor.init(r: 223, g: 168, b: 157), UIColor.init(r: 135, g: 145, b: 179), UIColor.init(r: 33, g: 147, b: 176), UIColor.init(r: 201, g: 75, b: 75)]
    private var secondColour: [UIColor] = [UIColor.init(r: 228, g: 144, b: 151), UIColor.init(r: 247, g: 226, b: 170), UIColor.init(r: 128, g: 91, b: 146), UIColor.init(r: 109, g: 213, b: 237), UIColor.init(r: 75, g: 19, b: 79)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(CategoryTVCell.self, forCellReuseIdentifier: cellID)
        
        tableView.delegate = self
        tableView.dataSource = self

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        
        tableView.backgroundColor = .white
        
        tableView.separatorStyle = .none
        
        self.title = tapped
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.contentInset = .init(top: 0, left: 0, bottom: 16, right: 0)
        
        getEvents()
    }
    
    func getEvents() {
        let jsonURLString: String = "https://api.mitrevels.in/events"
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
    
    @objc func callButtonTapped(_ sender: UIButton!) {
        print("callButtonTapped")
        guard let cell = sender.superview as? CategoryTVCell  else { return }
        let indexPath: Int = (tableView.indexPath(for: cell)?.item)!
        let actionSheet = UIAlertController(title: data[indexPath].name, message: "Call", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "CC 1: " + data[indexPath].cc1_name, style: UIAlertAction.Style.default, handler: { (action) -> Void in
            guard let number = URL(string: "tel://" + self.data[indexPath].cc1_contact) else { return }
            UIApplication.shared.open(number)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "CC 2: " + data[indexPath].cc2_name, style: UIAlertAction.Style.default, handler: { (action) -> Void in
            guard let number = URL(string: "tel://" + self.data[indexPath].cc2_contact) else { return }
            UIApplication.shared.open(number)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { (action) -> Void in
            //cancel
        }))
        
        self.present(actionSheet, animated: true, completion: nil)
        return
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! CategoryTVCell
        
        //background gradient
        cell.backgroundCard.layer.insertSublayer(gradient(frame: CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height), firstColor: firstColour[indexPath.item%firstColour.count], secondColor: secondColour[indexPath.item%secondColour.count]), at: 0)
//        cell.backgroundColor = .gray
        
        //text
        cell.titleLabel.text = data[indexPath.item].name
        cell.descLabel.text = data[indexPath.item].description
        
        if let image = UIImage(named: data[indexPath.item].name.uppercased()) {
            cell.bgImageView.image = image
        } else {
            if tapped.uppercased() == "CULTURAL" {
                cell.bgImageView.image = UIImage(named: "culturalLogo")
            }
            else if tapped.uppercased() == "OPEN" {
                cell.bgImageView.image = UIImage(named: "open")
            }
            else if tapped.uppercased() == "SUPPORTING" {
                cell.bgImageView.image = UIImage(named: "supporting")
            }
        }
        
        //call button
        cell.callButton.tag = indexPath.row
        cell.callButton.addTarget(self, action: #selector(CategoryController.callButtonTapped(_:)), for: UIControl.Event.touchUpInside)
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
        return 300
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let eventsController = EventsController()
        eventsController.tapped = data[indexPath.item].name
        eventsController.eventID = data[indexPath.item].id
        for ele in eventArray {
            if ele.category == eventsController.eventID {
                eventsController.data.append(ele)
            }
        }
        if eventsController.data.count == 0 {return}
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

extension UIImage {
    var noir: UIImage? {
        let context = CIContext(options: nil)
        guard let currentFilter = CIFilter(name: "CIPhotoEffectNoir") else { return nil }
        currentFilter.setValue(CIImage(image: self), forKey: kCIInputImageKey)
        if let output = currentFilter.outputImage,
            let cgImage = context.createCGImage(output, from: output.extent) {
            return UIImage(cgImage: cgImage, scale: scale, orientation: imageOrientation)
        }
        return nil
    }
}
