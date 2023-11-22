//
//  CustomView.swift
//  E-Commerce-App
//
//  Created by Yaşar Duman on 18.11.2023.
//

import UIKit

final class CustomView: UIView {

    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(backgroundColor: UIColor? = nil, clipsToBound: Bool? = nil, cornerRadius: CGFloat? = nil, maskedCorners: CACornerMask? = nil) {
        self.init(frame: .zero)
        set(backgroundColor: backgroundColor, clipsToBound: clipsToBound, cornerRadius: cornerRadius, maskedCorners: maskedCorners)
    }
    
    // MARK: - Configuration
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func set(backgroundColor: UIColor? = nil, clipsToBound: Bool? = nil, cornerRadius: CGFloat? = nil, maskedCorners: CACornerMask? = nil) {
        if let backgroundColor = backgroundColor {
            self.backgroundColor = backgroundColor
        }
        if let clipsToBound = clipsToBound {
            self.clipsToBounds = clipsToBound
        }
        if let cornerRadius = cornerRadius {
            layer.cornerRadius = cornerRadius
        }
        if let maskedCorners = maskedCorners {
            layer.maskedCorners = maskedCorners
        }
    }

}
