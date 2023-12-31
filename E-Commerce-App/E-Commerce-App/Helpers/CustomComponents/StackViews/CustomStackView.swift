//
//  CustomStackView.swift
//  E-Commerce-App
//
//  Created by Yaşar Duman on 17.11.2023.
//

import UIKit

final class CustomStackView: UIStackView {

    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Convenience Initializer
    convenience init(axis: NSLayoutConstraint.Axis? = nil, alignment: UIStackView.Alignment? = nil, distiribution: UIStackView.Distribution? = nil, spacing: CGFloat? = nil, backgroundColor: UIColor? = nil, cornerRadius: CGFloat? = nil) {
        self.init(frame: .zero)
       set(axis: axis, alignment: alignment, distiribution: distiribution, spacing: spacing, backgroundColor: backgroundColor, cornerRadius: cornerRadius)
    }
    
   // MARK: - Configuration
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Customization
    private func set(axis: NSLayoutConstraint.Axis? = nil, alignment: UIStackView.Alignment? = nil ,distiribution: UIStackView.Distribution? = nil, spacing: CGFloat? = nil, backgroundColor: UIColor? = nil, cornerRadius: CGFloat? = nil) {
        
        if let axis = axis { self.axis = axis }
        if let alignment = alignment { self.alignment = alignment }
        if let distiribution = distiribution { self.distribution = distiribution }
        if let spacing = spacing { self.spacing = spacing }
        if let backgroundColor = backgroundColor { self.backgroundColor = backgroundColor }
        if let cornerRadius = cornerRadius { layer.cornerRadius = cornerRadius }
    }
}
