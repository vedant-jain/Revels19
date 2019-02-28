//
//  EventsController.swift
//  Revels
//
//  Created by Vedant Jain on 26/02/19.
//  Copyright © 2019 Naman Jain. All rights reserved.
//

import UIKit

class EventsController: UITableViewController {
    
    var tapped = ""
    var eventID = 0
    private let cellID = "cellID"
    var eventArray: [EventStruct] = []
    private var data: [EventStruct] = []
    
    //gradients
    private var firstColour: [UIColor] = [UIColor.init(r: 227, g: 122, b: 180), UIColor.init(r: 247, g: 226, b: 170), UIColor.init(r: 135, g: 145, b: 179), UIColor.init(r: 33, g: 147, b: 176), UIColor.init(r: 201, g: 75, b: 75)]
    private var secondColour: [UIColor] = [UIColor.init(r: 228, g: 144, b: 151), UIColor.init(r: 223, g: 168, b: 157), UIColor.init(r: 128, g: 91, b: 146), UIColor.init(r: 109, g: 213, b: 237), UIColor.init(r: 75, g: 19, b: 79)]
    
    fileprivate func extractEvents() {
        for ele in eventArray {
            if ele.category == eventID {
                data.append(ele)
            }
        }
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(EventTableViewCell.self, forCellReuseIdentifier: cellID)
        
        tableView.backgroundColor = .white
        
        self.title = tapped
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
//        tableView.rowHeight = UITableView.automaticDimension
        
        extractEvents()
        
        tableView.dataSource = self;
        tableView.delegate = self;

        tableView.separatorStyle = .none
        tableView.contentInset = .init(top: 8, left: 0, bottom: 8, right: 0)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EventTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! EventTableViewCell
        cell.backgroundCard.layer.insertSublayer(gradient(frame: CGRect(x: 0, y: 0, width: cell.frame.width-32, height: cell.frame.height-32), firstColor: firstColour[indexPath.item%firstColour.count], secondColor: secondColour[indexPath.item%secondColour.count]), at: 0)
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
