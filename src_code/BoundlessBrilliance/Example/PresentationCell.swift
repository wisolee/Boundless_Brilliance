////
////  PresentationCell.swift
////  BoundlessBrilliance
////
////  Created by Adam on 11/2/18.
////  Copyright © 2018 BoundlessBrilliance. All rights reserved.
////
//
//import Foundation
//import UIKit
//import _SwiftUIKitOverlayShims
//
//extension UICollectionViewCell {
//    
//    
//    @available(iOS 11.0, *)
//    public enum DragState : Int {
//        
//        
//        case none
//        
//        
//        case lifting
//        
//        
//        case dragging
//    }
//}
//
//@available(iOS 6.0, *)
//open class UICollectionReusableView : UIView {
//    
//    
//    open var reuseIdentifier: String? { get }
//    
//    
//    // Override point.
//    // Called by the collection view before the instance is returned from the reuse queue.
//    // Subclassers must call super.
//    open func prepareForReuse()
//    
//    
//    // Classes that want to support custom layout attributes specific to a given UICollectionViewLayout subclass can apply them here.
//    // This allows the view to work in conjunction with a layout class that returns a custom subclass of UICollectionViewLayoutAttributes from -layoutAttributesForItem: or the corresponding layoutAttributesForHeader/Footer methods.
//    // -applyLayoutAttributes: is then called after the view is added to the collection view and just before the view is returned from the reuse queue.
//    // Note that -applyLayoutAttributes: is only called when attributes change, as defined by -isEqual:.
//    open func apply(_ layoutAttributes: UICollectionViewLayoutAttributes)
//    
//    
//    // Override these methods to provide custom UI for specific layouts.
//    open func willTransition(from oldLayout: UICollectionViewLayout, to newLayout: UICollectionViewLayout)
//    
//    open func didTransition(from oldLayout: UICollectionViewLayout, to newLayout: UICollectionViewLayout)
//    
//    
//    @available(iOS 8.0, *)
//    open func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes
//}
//
//@available(iOS 6.0, *)
//open class UICollectionViewCell : UICollectionReusableView {
//    
//    
//    open var contentView: UIView { get } // add custom subviews to the cell's contentView
//    
//    
//    // Cells become highlighted when the user touches them.
//    // The selected state is toggled when the user lifts up from a highlighted cell.
//    // Override these methods to provide custom UI for a selected or highlighted state.
//    // The collection view may call the setters inside an animation block.
//    open var isSelected: Bool
//    
//    open var isHighlighted: Bool
//    
//    
//    // Override this method to modify the visual appearance for a particular
//    // dragState.
//    //
//    // Call super if you want to add to the existing default implementation.
//    //
//    @available(iOS 11.0, *)
//    open func dragStateDidChange(_ dragState: UICollectionViewCell.DragState)
//    
//    
//    // The background view is a subview behind all other views.
//    // If selectedBackgroundView is different than backgroundView, it will be placed above the background view and animated in on selection.
//    open var backgroundView: UIView?
//    
//    open var selectedBackgroundView: UIView?
//}
