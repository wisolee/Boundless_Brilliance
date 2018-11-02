//
//  PresentationListCollectionViewCell.swift
//  BoundlessBrilliance
//
//  Created by William Lee on 10/31/18.
//  Copyright © 2018 BoundlessBrilliance. All rights reserved.
//

import UIKit

class PresentationListCollectionViewCell: UICollectionViewCell {
    
//    override init(frame: CGRect) {
//        // Called when collection view dequeues itself
//        super.init(frame: frame)
//        // Change the background color of the cell
//        self.backgroundColor = UIColor(r: 128, g: 128, b: 128)
//        setupPresNameView()
//    }
    
    //examples from the alerts and pickers app cell file-----------------------------
    public lazy var date: UIImageView = {
        $0.contentMode = .center
        $0.backgroundColor = .yellow
        return $0
    }(UIImageView())
    
    public lazy var time: UIImageView = {
        $0.contentMode = .center
        $0.backgroundColor = .orange
        return $0
    }(UIImageView())
    
    public lazy var location: UILabel = {
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 20 : 17)
        $0.textColor = .black
        $0.text = "Valley Oak Elementary"
        $0.backgroundColor = .green
        $0.numberOfLines = 1
        return $0
    }(UILabel())
    
    fileprivate let textView = UIView()
    
    public lazy var presenterNames: UILabel = {
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        $0.backgroundColor = .blue
        $0.textColor = .gray
        $0.text = "Dweezel the Dragon"
        $0.numberOfLines = 1
        return $0
    }(UILabel())

    //end examples from the alerts and pickers app cell file-----------------------------
    
    // Name Label
    let presentationName: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        label.text = "Presentation1"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    fileprivate func setup(){
        backgroundColor = UIColor(r: 128, g: 128, b: 128)
        addSubview(date)
        addSubview(time)
        addSubview(location)
        addSubview(presenterNames)
        
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    //layout function from alerts and pickers
    func layout(){
        let vTextInset: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 4 : 2
        let hTextInset: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 12 : 8
        let imageViewHeight: CGFloat = self.bounds.size.height - (layoutMargins.top + layoutMargins.bottom) - 15
        date.frame = CGRect(x: layoutMargins.left + 4, y: layoutMargins.top, width: imageViewHeight, height: imageViewHeight)
        let textViewWidth: CGFloat = self.bounds.size.width - 1.5 * date.frame.maxX - 2 * hTextInset
        let locationSize = location.sizeThatFits(CGSize(width: textViewWidth, height: self.bounds.size.height))
        let presenterNamesSize = presenterNames.sizeThatFits(CGSize(width: textViewWidth, height: self.bounds.size.height))
        location.frame = CGRect(origin: CGPoint(x: date.frame.maxX + 4, y: layoutMargins.top), size: CGSize(width: textViewWidth, height: locationSize.height))
        presenterNames.frame = CGRect(origin: CGPoint(x: date.frame.maxX + 4, y: location.frame.maxY + vTextInset), size: CGSize(width: textViewWidth, height: presenterNamesSize.height))
        time.frame = CGRect(origin: CGPoint(x: location.frame.maxX + 4, y: layoutMargins.top), size: CGSize(width: 0.5 * imageViewHeight, height: imageViewHeight))
        textView.bounds.size = CGSize(width: textViewWidth, height: presenterNames.frame.maxY)
        textView.frame.origin.x = date.frame.maxX + hTextInset
        textView.center.y = date.center.y
        
        style(view: contentView)
    }
    
    func style(view: UIView) {
        view.clipsToBounds = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 14
        view.layer.shadowColor = UIColor(r: 0, g: 0, b: 0).cgColor
        view.layer.shadowOffset = CGSize(width: 1, height: 5)
        view.layer.shadowRadius = 8
        view.layer.shadowOpacity = 0.2
        view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 14, height: 14)).cgPath
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.main.scale
    }
    
    
    // Setup() for Name Label
//    func setupPresNameView() {
//        addSubview(presentationName)
//        // Horizontal Contraint
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0]-50-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": presentationName]))
//        // Vertical Constraint
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[v0]-30-|", options:
//            NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": presentationName]))
//    }
    
//    func setupFirstNamesView(){
//
//    }

//    func setupPresTimeView(){
//
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initilization Code
    }
    
    // Called in PresentationListViewController when configuring custom view cells
    public func configure(with model: PresentationListItemModel) {
        presentationName.text = model.name
    }
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    

    
    
    
    
    
}
