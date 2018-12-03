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
        let time_width_relative_to_date = CGFloat(0.75)
        let v_text_inset: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 4 : 2
        let h_text_inset: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 12 : 8
        let date_view_height: CGFloat = self.bounds.size.height - (layoutMargins.top + layoutMargins.bottom)
        date.frame = CGRect(x: layoutMargins.left + 3, y: layoutMargins.top, width: 0.8 * date_view_height, height: date_view_height)
        
        // More constants
        let text_view_width: CGFloat = self.bounds.size.width - 1.75 * date.frame.maxX - 4 * h_text_inset
        let location_size = location.sizeThatFits(CGSize(width: text_view_width, height: self.bounds.size.height))
        let presenter_names_size = presenter_names.sizeThatFits(CGSize(width: text_view_width, height: self.bounds.size.height))
        
        // Create frames for inner objects
        let location_frame_origin = CGPoint(x: date.frame.maxX + 4, y:  (self.bounds.size.height / 5))
        let location_frame_size = CGSize(width: text_view_width, height: location_size.height)
        location.frame = CGRect(origin: location_frame_origin, size: location_frame_size)
        
        let presenter_frame_origin = CGPoint(x: date.frame.maxX + 4, y: location.frame.maxY + v_text_inset)
        let presenter_frame_size = CGSize(width: text_view_width, height: presenter_names_size.height)
        presenter_names.frame = CGRect(origin: presenter_frame_origin, size: presenter_frame_size)
        
        let time_frame_origin = CGPoint(x: location.frame.maxX + 6, y: layoutMargins.top)
        let time_frame_size = CGSize(width: time_width_relative_to_date * date_view_height, height: date_view_height)
        time.frame = CGRect(origin: time_frame_origin, size: time_frame_size)
        
        let arrow_frame_origin = CGPoint(x: time.frame.maxX, y: layoutMargins.top)
        let arrow_frame_size = CGSize(width: self.frame.maxX - time.frame.maxX - 6, height: date_view_height)
        arrow.frame = CGRect(origin: arrow_frame_origin, size: arrow_frame_size)
        
        let notification_frame_origin = CGPoint(x: date.frame.maxX + 4, y: presenter_names.frame.maxY + v_text_inset + v_text_inset)
        let notification_frame_size = CGSize(width: text_view_width, height: presenter_names_size.height)
        notification.frame = CGRect(origin: notification_frame_origin, size: notification_frame_size)
        
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
        let formatted_date = configureDate(date: model.date)
        date.text = formatted_date
        checkDateUpdateNotification(notification: notification)
    }
    
    // Notifies user if feedback can be submitted for a presentation
    func checkDateUpdateNotification(notification: UILabel) {
        let date_formatter = DateFormatter()
        date_formatter.dateFormat = "yyyy-MM-dd"
        let time_formatter = DateFormatter()
        time_formatter.dateFormat = "HH:mm"
        
        let time_index = presentation!.time.index(presentation!.time.startIndex, offsetBy: 3)
        let time_index_end = presentation!.time.index(time_index, offsetBy: 5)
        let time_string = String(presentation!.time[time_index...time_index_end])
        
        let date = Date()
        
        let current_date = date_formatter.date(from: date_formatter.string(from: date))
        let presentation_date = date_formatter.date(from: presentation!.date)
        let current_time = time_formatter.date(from: time_formatter.string(from: date))
        let presentation_time = time_formatter.date(from: time_string)
        
        if(presentation_date! >= current_date!) {
            notification.text = ""
        } else {
            if (current_time! >= presentation_time!) {
                notification.text = "!: you can submit feedback on this presentation"
            }
        }
    }
    
    // Configure data with desired settings
    func configureDate(date: String) -> String {
        let place_holder_date = date
        let index_of_substring = place_holder_date.index(place_holder_date.startIndex, offsetBy: 5)
        var date_wo_year = String(place_holder_date[index_of_substring...])
        date_wo_year = date_wo_year.replacingOccurrences(of: "-", with: "\n")
        let month_index = date_wo_year.index(date_wo_year.startIndex, offsetBy: 1)
        let day_index = date_wo_year.index(date_wo_year.startIndex, offsetBy: 2)
        let month_int_string = String(date_wo_year[...month_index])
        let month = Int(month_int_string)
        let month_string = month_array[month! - 1]
        return month_string + String(date_wo_year[day_index...])
    }
}
