//
//  PresentationListCollectionViewCell.swift
//  BoundlessBrilliance
//
//  Created by William Lee on 10/31/18.
//  Copyright © 2018 BoundlessBrilliance. All rights reserved.
//

import UIKit

class PresentationListCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        // Called when collection view dequeues itself
        super.init(frame: frame)
        // Change the background color of the cell
        self.backgroundColor = UIColor(r: 128, g: 128, b: 128)
        setupViews()
    }
    
    
    let presentationName: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.text = "Presentation1"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupViews() {
        addSubview(presentationName)
        // Horizontal Contraint
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-50-[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": presentationName]))
        // Vertical Constraint
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-30-[v0]|", options:
            NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": presentationName]))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initilization Code
    }
    
    public func configure(with model: PresentationListItemModel) {
        presentationName.text = model.name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
