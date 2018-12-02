//
//  PresentationListCollectionViewCell.swift
//  BoundlessBrilliance
//
//  Created by William Lee on 10/31/18.
//  Copyright © 2018 BoundlessBrilliance. All rights reserved.
//

import UIKit

class PresentationListCollectionViewCell: UICollectionViewCell {

    let monthArray: [String] = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    var presentation: PresentationListItemModel? = nil

    let arrow = CellArrow()
    //examples from the alerts and pickers app cell file-----------------------------
    public lazy var date: UILabel = {
        $0.textAlignment = NSTextAlignment.center
        $0.numberOfLines = 0
        $0.font = UIFont(name: "MeeraInimai-Regular", size: UIFont.labelFontSize)
        $0.text = "Nov\n02"
        return $0
    }(UILabel())
    
    public lazy var time: UILabel = {
        $0.textAlignment = NSTextAlignment.center
        $0.numberOfLines = 0
        $0.font = UIFont(name: "MeeraInimai-Regular", size: UIFont.labelFontSize)
        $0.text = "3:00"
        return $0
    }(UILabel())
    
    public lazy var location: UILabel = {
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 20 : 17)
        $0.textColor = .black
        $0.font = UIFont(name: "MeeraInimai-Regular", size: UIFont.labelFontSize)
        $0.adjustsFontSizeToFitWidth = true
        $0.text = "Valley Oak Elementary"
        $0.textAlignment = NSTextAlignment.center
        $0.numberOfLines = 1
        return $0
    }(UILabel())
    
    fileprivate let textView = UIView()
    
    public lazy var presenterNames: UILabel = {
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        $0.textColor = .gray
        $0.text = "Dweezel the Dragon"
        $0.textAlignment = NSTextAlignment.center
        $0.numberOfLines = 1
        return $0
    }(UILabel())
    
    public lazy var notification: UILabel = {
        $0.textColor = .red
        $0.text = ""
        $0.textAlignment = NSTextAlignment.center
        $0.numberOfLines = 1
        $0.adjustsFontSizeToFitWidth = true
        $0.font = .systemFont(ofSize: 9)
        return $0
    }(UILabel())
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    fileprivate func setup(){
        backgroundColor = UIColor.white
        addSubview(arrow)
        arrow.backgroundColor = UIColor.white
        addSubview(date)
        addSubview(time)
        addSubview(location)
        addSubview(presenterNames)
        addSubview(notification)
        
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    //layout function from alerts and pickers
    func layout(){
        //set constants for constraints
        let timeWidthRelativeToDate = CGFloat(0.75)
        let vTextInset: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 4 : 2
        let hTextInset: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 12 : 8
        let dateViewHeight: CGFloat = self.bounds.size.height - (layoutMargins.top + layoutMargins.bottom)
        date.frame = CGRect(x: layoutMargins.left + 3, y: layoutMargins.top, width: 0.8 * dateViewHeight, height: dateViewHeight)
        //more constants
        let textViewWidth: CGFloat = self.bounds.size.width - 1.75 * date.frame.maxX - 4 * hTextInset
        let locationSize = location.sizeThatFits(CGSize(width: textViewWidth, height: self.bounds.size.height))
        let presenterNamesSize = presenterNames.sizeThatFits(CGSize(width: textViewWidth, height: self.bounds.size.height))
        //create frames for inner objects
        let locationFrameOrigin = CGPoint(x: date.frame.maxX + 4, y:  (self.bounds.size.height / 5))
        let locationFrameSize = CGSize(width: textViewWidth, height: locationSize.height)
        location.frame = CGRect(origin: locationFrameOrigin, size: locationFrameSize)
        
        let presenterFrameOrigin = CGPoint(x: date.frame.maxX + 4, y: location.frame.maxY + vTextInset)
        let presenterFrameSize = CGSize(width: textViewWidth, height: presenterNamesSize.height)
        presenterNames.frame = CGRect(origin: presenterFrameOrigin, size: presenterFrameSize)
        
        let timeFrameOrigin = CGPoint(x: location.frame.maxX + 6, y: layoutMargins.top)
        let timeFrameSize = CGSize(width: timeWidthRelativeToDate * dateViewHeight, height: dateViewHeight)
        time.frame = CGRect(origin: timeFrameOrigin, size: timeFrameSize)
        
        let arrowFrameOrigin = CGPoint(x: time.frame.maxX, y: layoutMargins.top)
        let arrowFrameSize = CGSize(width: self.frame.maxX - time.frame.maxX - 6, height: dateViewHeight)
        arrow.frame = CGRect(origin: arrowFrameOrigin, size: arrowFrameSize)
        
        let notificationFrameOrigin = CGPoint(x: date.frame.maxX + 4, y: presenterNames.frame.maxY + vTextInset + vTextInset)
        let notificationFrameSize = CGSize(width: textViewWidth, height: presenterNamesSize.height)
        notification.frame = CGRect(origin: notificationFrameOrigin, size: notificationFrameSize)
        
        style(view: contentView)
    }
    
    func style(view: UIView) {
        view.clipsToBounds = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 14
        view.layer.shadowColor = UIColor(r: 0, g: 0, b: 0).cgColor
        view.layer.shadowOffset = CGSize(width: 1, height: 5)
        view.layer.shadowRadius = 8
        view.layer.shadowOpacity = 0.5
        view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 14, height: 14)).cgPath
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.main.scale
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initilization Code
    }
    
    // Called in PresentationListViewController when configuring custom view cells
    public func configure(with model: PresentationListItemModel) {        
        presentation = model
        location.text = model.location
        presenterNames.text = model.names
        time.text = model.time
        let formattedDate = configureDate(date: model.date)
        date.text = formattedDate
        checkDateUpdateNotification(notification: notification)
    }
    
    func checkDateUpdateNotification(notification: UILabel){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let timeIndex = presentation!.time.index(presentation!.time.startIndex, offsetBy: 3)
        let timeIndexEnd = presentation!.time.index(timeIndex, offsetBy: 5)
        let timeString = String(presentation!.time[timeIndex...timeIndexEnd])
        print(presentation!.time[timeIndex...timeIndexEnd])
        let date = Date()
        let currentDate = dateFormatter.date(from: dateFormatter.string(from: date))
        let presentationDate = dateFormatter.date(from: presentation!.date)
//        print(currentDate)
        let currentTime = timeFormatter.date(from: timeFormatter.string(from: date))
        let presentationTime = timeFormatter.date(from: timeString)
        if(presentationDate! >= currentDate!){
            notification.text = ""
        }
        else{
            if(currentTime! >= presentationTime!){
                notification.text = "!: you can submit feedback on this presentation"
            }
        }
    }
    
    func configureDate(date: String) -> String{
        let placeHolderDate = date
        let indexOfSubstring = placeHolderDate.index(placeHolderDate.startIndex, offsetBy: 5)
        var dateWOYear = String(placeHolderDate[indexOfSubstring...])
        dateWOYear = dateWOYear.replacingOccurrences(of: "-", with: "\n")
        let monthIndex = dateWOYear.index(dateWOYear.startIndex, offsetBy: 1)
        let dayIndex = dateWOYear.index(dateWOYear.startIndex, offsetBy: 2)
        let monthIntString = String(dateWOYear[...monthIndex])
        print("month only: " + String(dateWOYear[...monthIndex]) + "|")
        let month = Int(monthIntString)
        print("month int: " + String(month!))
        let monthString = monthArray[month! - 1]
        return monthString + String(dateWOYear[dayIndex...])
    }
}
