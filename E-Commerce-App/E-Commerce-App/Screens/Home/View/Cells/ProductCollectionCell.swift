//
//  ProductCollectionCell.swift
//  E-Commerce-App
//
//  Created by Yaşar Duman on 18.11.2023.
//

import UIKit

final class ProductCollectionCell: UICollectionViewCell {
    
    //MARK: - Cell's Identifier
    static let identifier = "ProductCollectionCell"
    
    //MARK: - UI Elements
    private lazy var infoSeperatorView = CustomView(backgroundColor: UIColor.ProductCollectionSeperatorBG, cornerRadius: 10)
    private lazy var imageContainerView = CustomView(backgroundColor: UIColor.white, cornerRadius: 10)
    lazy var productImageView = CustomImageView(image: UIImage(named: "headset"), contentMode: .scaleAspectFit)
    lazy var productFavoriteButton = CustomButton(bgColor: UIColor.ProductCollectionFavoriteButtonBG, color: UIColor.ProductCollectionFavoriteButtonBG, systemImageName: "suit.heart", pointSize: 14,cornerStyle: .capsule)
    private lazy var productInfoHStackView = CustomStackView(axis: .horizontal,alignment: .center)
    private lazy var productInfoVStackView = CustomStackView(axis: .vertical, alignment: .leading)
    lazy var productInfoLabel = TitleLabel(fontSize: 12, textAlignment: .left, fontWeight: .regular)
    lazy var priceLabel = TitleLabel(fontSize: 14, textAlignment: .left, fontWeight: .regular)
    lazy var addToCartButton = CustomButton(bgColor: .clear, color: UIColor.ProductCollectionFavoriteButtonBG, systemImageName: "cart")
  
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        addSubviewsExt(infoSeperatorView, imageContainerView)
        
        configureInfoSeperatorView()
        configureImageContainerView()
        configureProductImageView()
        configureProductFavoriteButton()
        configureProductInfoHStackView()
    }
    
    private func configureInfoSeperatorView() {
        infoSeperatorView.anchor(leading: leadingAnchor,
                                 bottom: bottomAnchor,
                                 trailing: trailingAnchor,
                                 size: .init(heightSize: 100))
    }
    
    private func configureImageContainerView() {
        imageContainerView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, constant: -20).isActive = true
        imageContainerView.anchor(size: .init(heightSize: 100))
        imageContainerView.centerXInSuperview()
        imageContainerView.centerYAnchor.constraint(equalTo: infoSeperatorView.topAnchor).isActive = true
    }
    
    private func configureProductImageView() {
        imageContainerView.addSubview(productImageView)
        productImageView.fillSuperview(padding: .init(top: 10, bottom: 10))
    }
    
    private func configureProductFavoriteButton() {
        imageContainerView.addSubview(productFavoriteButton)
        productFavoriteButton.anchor(top: imageContainerView.topAnchor,
                                     trailing: imageContainerView.trailingAnchor,
                                     padding: .init(top: 4, trailing: 4),
                                     size: .init(width: 25, height: 25))
    }
    
    private func configureProductInfoHStackView() {
        infoSeperatorView.addSubview(productInfoHStackView)
        productInfoHStackView.addArrangedSubviewsExt(productInfoVStackView, addToCartButton)
        productInfoVStackView.addArrangedSubviewsExt(productInfoLabel, priceLabel)
    
        productInfoHStackView.anchor(top: imageContainerView.bottomAnchor,
                                    leading: imageContainerView.leadingAnchor,
                                    trailing: infoSeperatorView.trailingAnchor,
                                    padding: .init(top: 10))
        
        productInfoLabel.text = "Deneme bir başlık"
        priceLabel.text = "£65,00"
        // TODO: - renk düzenlemeri yapılacak tekrardan !!
        productInfoLabel.textColor = .black
        priceLabel.textColor = .black
    }
    
    func configure(with data: Product){
        if let imageURL = data.image {
            productImageView.downloadSetImage(url: imageURL)
        }
        
        productInfoLabel.text = data.title
        
        if let productPrice = data.price {
            priceLabel.text = "£" + String(productPrice)
        }
    }
}
