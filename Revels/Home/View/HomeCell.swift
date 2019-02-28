//
//  HomeCell.swift
//  Revels
//
//  Created by Vedant Jain on 15/01/19.
//  Copyright © 2019 Naman Jain. All rights reserved.
//

import UIKit
import Alamofire

class HomeCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var firstColour: [UIColor] = [UIColor.init(r: 227, g: 122, b: 180), UIColor.init(r: 247, g: 226, b: 170), UIColor.init(r: 135, g: 145, b: 179), UIColor.init(r: 33, g: 147, b: 176), UIColor.init(r: 201, g: 75, b: 75)]
    private var secondColour: [UIColor] = [UIColor.init(r: 228, g: 144, b: 151), UIColor.init(r: 223, g: 168, b: 157), UIColor.init(r: 128, g: 91, b: 146), UIColor.init(r: 109, g: 213, b: 237), UIColor.init(r: 75, g: 19, b: 79)]
    
    private let cellID = "cellID"
    
    var dayArray = [ScheduleEvent]()
    
    var events = [Event]()
    var schedule = [Schedule]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // row is 0 for the first row, otherwise 1
    
    let cellCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cellCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cellCollectionView.backgroundColor = .white
        cellCollectionView.showsHorizontalScrollIndicator = false
        cellCollectionView.translatesAutoresizingMaskIntoConstraints = false
        return cellCollectionView
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    let subtitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()

    func setupViews() {
        addSubview(title)
        addSubview(subtitle)
        addSubview(cellCollectionView)
        
        getEvents()
        
        cellCollectionView.dataSource = self
        cellCollectionView.delegate = self
        cellCollectionView.register(DetailsCell.self, forCellWithReuseIdentifier: cellID)
        
        _ = title.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 16, rightConstant: 16, widthConstant: 0, heightConstant: 22)
        _ = subtitle.anchor(title.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 8, leftConstant: 16, bottomConstant: -16, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        _ = cellCollectionView.anchor(subtitle.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 16, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if dayArray.count != 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! DetailsCell
            cell.backgroundCard.layer.insertSublayer(gradient(frame: (cell.bounds), firstColor: firstColour[indexPath.item % firstColour.count], secondColor: secondColour[indexPath.item % secondColour.count]), at: 0)
            cell.titleLabel.text = dayArray[indexPath.item].returnName()
            cell.bodyLabel.text = dayArray[indexPath.item].eventTime
            cell.roundLabel.text = "Round " + String(dayArray[indexPath.item].eventRound)
            cell.locationLabel.text = dayArray[indexPath.item].eventVenue
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! DetailsCell
            cell.backgroundCard.layer.insertSublayer(gradient(frame: (cell.bounds), firstColor: firstColour[indexPath.item % firstColour.count], secondColor: secondColour[indexPath.item % secondColour.count]), at: 0)
            cell.titleLabel.text = "No events"
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if dayArray.count == 0 {return 1}
        return dayArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width-64, height: 200)
    }
    
    func getEvents(){
        LoadingOverlay.shared.showOverlay(view: self.cellCollectionView)
        Alamofire.request("https://api.mitrevels.in/events", method: .get, parameters: nil).responseJSON { response in
            switch response.result {
            case .success:
                if let data = response.data{
                    do{
                        let response = try JSONDecoder().decode(EventResponse.self, from: data)
                        if let events = response.data{
                            self.events = events
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                                self.getSchedule()
                                print("Succesfully got events")
                            }
                        }else{
                            print("Coudnt get data")
                        }
                    }catch let error{
                        print(error)
                    }
                }
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getSchedule(){
        Alamofire.request("https://api.mitrevels.in/schedule", method: .get, parameters: nil).responseJSON { response in
            switch response.result {
            case .success:
                if let data = response.data{
                    do{
                        let response = try JSONDecoder().decode(ScheduleResponse.self, from: data)
                        if let schedule = response.data{
                            self.schedule = schedule
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                                print("Succesfully got schedule")
                                self.makeSchedule()
                            }
                        }else{
                            print("Coudnt get data")
                        }
                    }catch let error{
                        print(error)
                    }
                }
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func makeSchedule(){
        
        var eventId = [Int]()
        for item in events{
            eventId.append(item.id)
        }
        
        let eventDict = NSMutableDictionary(objects: events, forKeys: eventId as [NSCopying])
        
        for item in schedule {
            guard let start = item.start, let end = item.end, let venue = item.location, let round = item.round else {
                return
            }
            let event = eventDict[item.event] as! Event
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
            let startDate = formatter.date(from: start)
            let endDate = formatter.date(from: end)
            formatter.dateFormat = "h:mm a"
            var dateString = formatter.string(from: startDate!)
            dateString.append(" - \(formatter.string(from: endDate!))")
            formatter.dateFormat = "EEEE"
            let dayString = formatter.string(from: startDate!)
            let currentDate = Date()
            let currentDayString = formatter.string(from: currentDate)
            if (currentDayString == dayString) {
                dayArray.append(ScheduleEvent(event: event, time: dateString, venue: venue, round: round))

            //reload collectionview with the schedule
                DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                    self.cellCollectionView.reloadData()
                    LoadingOverlay.shared.hideOverlayView()
                }
            }
        }
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

