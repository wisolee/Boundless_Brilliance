//
//  PresentationListCollectionViewCell.swift
//  BoundlessBrilliance
//
//  Created by William Lee on 10/31/18.
//  Copyright © 2018 BoundlessBrilliance. All rights reserved.
//

import UIKit

class PresentationListCollectionViewCell: UICollectionViewCell {

    let month_array: [String] = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    var presentation: PresentationListItemModel? = nil
    
    // MARK: subviews used in cell
    // Referenced examples from alerts-and-pickers (https://github.com/dillidon/alerts-and-pickers)
    
    let arrow = CellArrow()
    
    public lazy var date: UILabel = {
        $0.textAlignment = NSTextAlignment.center
        $0.numberOfLines = 0
        $0.font = UIFont(name: "MeeraInimai-Regular", size: UIFont.labelFontSize)
        return $0
    }(UILabel())
    
    public lazy var time: UILabel = {
        $0.textAlignment = NSTextAlignment.center
        $0.numberOfLines = 0
        $0.font = UIFont(name: "MeeraInimai-Regular", size: UIFont.labelFontSize)
        return $0
    }(UILabel())
    
    public lazy var location: UILabel = {
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 20 : 17)
        $0.textColor = .black
        $0.font = UIFont(name: "MeeraInimai-Regular", size: UIFont.labelFontSize)
        $0.adjustsFontSizeToFitWidth = true
        $0.textAlignment = NSTextAlignment.center
        $0.numberOfLines = 1
        return $0
    }(UILabel())
    
    fileprivate let text_view = UIView()
    
    public lazy var presenter_names: UILabel = {
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        $0.textColor = .gray
        $0.textAlignment = NSTextAlignment.center
        $0.numberOfLines = 1
        return $0
    }(UILabel())
    
    public lazy var notification: UILabel = {
        $0.textColor = .red
        $0.textAlignment = NSTextAlignment.center
        $0.numberOfLines = 1
        $0.adjustsFontSizeToFitWidth = true
        $0.font = .systemFont(ofSize: 9)
        return $0
    }(UILabel())
    
    // MARK: Designated Initializers
    
    // Implementation for required cell init
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // Override default cell init with custom cell init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    // MARK: Private Instance Methods
    
    // Configure custom cell with desired settings
    fileprivate func setup() {
        backgroundColor = UIColor.white
        addSubview(arrow)
        arrow.backgroundColor = UIColor.white
        addSubview(date)
        addSubview(time)
        addSubview(location)
        addSubview(presenter_names)
        addSubview(notification)
    }
    
    // Override default layout with custom layout
    override public func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    // Layout function from alerts and pickers
    func layout() {
        // Set constants for constraints
        let timeWidthRelativeToDate = CGFloat(0.75)
        let vTextInset: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 4 : 2
        let hTextInset: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 12 : 8
        let dateViewHeight: CGFloat = self.bounds.size.height - (layoutMargins.top + layoutMargins.bottom)
        date.frame = CGRect(x: layoutMargins.left + 3, y: layoutMargins.top, width: 0.8 * dateViewHeight, height: dateViewHeight)
        
        // More constants
        let textViewWidth: CGFloat = self.bounds.size.width - 1.75 * date.frame.maxX - 4 * hTextInset
        let locationSize = location.sizeThatFits(CGSize(width: textViewWidth, height: self.bounds.size.height))
        let presenterNamesSize = presenter_names.sizeThatFits(CGSize(width: textViewWidth, height: self.bounds.size.height))
        
        // Create frames for inner objects
        let locationFrameOrigin = CGPoint(x: date.frame.maxX + 4, y:  (self.bounds.size.height / 5))
        let locationFrameSize = CGSize(width: textViewWidth, height: locationSize.height)
        location.frame = CGRect(origin: locationFrameOrigin, size: locationFrameSize)
        
        let presenterFrameOrigin = CGPoint(x: date.frame.maxX + 4, y: location.frame.maxY + vTextInset)
        let presenterFrameSize = CGSize(width: textViewWidth, height: presenterNamesSize.height)
        presenter_names.frame = CGRect(origin: presenterFrameOrigin, size: presenterFrameSize)
        
        let timeFrameOrigin = CGPoint(x: location.frame.maxX + 6, y: layoutMargins.top)
        let timeFrameSize = CGSize(width: timeWidthRelativeToDate * dateViewHeight, height: dateViewHeight)
        time.frame = CGRect(origin: timeFrameOrigin, size: timeFrameSize)
        
        let arrowFrameOrigin = CGPoint(x: time.frame.maxX, y: layoutMargins.top)
        let arrowFrameSize = CGSize(width: self.frame.maxX - time.frame.maxX - 6, height: dateViewHeight)
        arrow.frame = CGRect(origin: arrowFrameOrigin, size: arrowFrameSize)
        
        let notificationFrameOrigin = CGPoint(x: date.frame.maxX + 4, y: presenter_names.frame.maxY + vTextInset + vTextInset)
        let notificationFrameSize = CGSize(width: textViewWidth, height: presenterNamesSize.height)
        notification.frame = CGRect(origin: notificationFrameOrigin, size: notificationFrameSize)
        
        style(view: contentView)
    }
    
    // Styles the cell
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
    
    // Called in PresentationListViewController when configuring custom view cells
    public func configure(with model: PresentationListItemModel) {        
        presentation = model
        location.text = model.location
        presenter_names.text = model.names
        time.text = model.time
        let formattedDate = configureDate(date: model.date)
        date.text = formattedDate
        checkDateUpdateNotification(notification: notification)
    }
    
    // Notifies user if feedback can be submitted for a presentation
    func checkDateUpdateNotification(notification: UILabel) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        
        let timeIndex = presentation!.time.index(presentation!.time.startIndex, offsetBy: 3)
        let timeIndexEnd = presentation!.time.index(timeIndex, offsetBy: 5)
        let timeString = String(presentation!.time[timeIndex...timeIndexEnd])
        
        let date = Date()
        
        let currentDate = dateFormatter.date(from: dateFormatter.string(from: date))
        let presentationDate = dateFormatter.date(from: presentation!.date)
        let currentTime = timeFormatter.date(from: timeFormatter.string(from: date))
        let presentationTime = timeFormatter.date(from: timeString)
        
        if(presentationDate! >= currentDate!){
            notification.text = ""
        } else {
            if (currentTime! >= presentationTime!) {
                notification.text = "!: you can submit feedback on this presentation"
            }
        }
    }
    
    // Configure data with desired settings
    func configureDate(date: String) -> String{
        let placeHolderDate = date
        let indexOfSubstring = placeHolderDate.index(placeHolderDate.startIndex, offsetBy: 5)
        var dateWOYear = String(placeHolderDate[indexOfSubstring...])
        dateWOYear = dateWOYear.replacingOccurrences(of: "-", with: "\n")
        let monthIndex = dateWOYear.index(dateWOYear.startIndex, offsetBy: 1)
        let dayIndex = dateWOYear.index(dateWOYear.startIndex, offsetBy: 2)
        let monthIntString = String(dateWOYear[...monthIndex])
        let month = Int(monthIntString)
        let monthString = month_array[month! - 1]
        return monthString + String(dateWOYear[dayIndex...])
    }
}
