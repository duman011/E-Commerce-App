//
//  HomeVC.swift
//  E-Commerce-App
//
//  Created by Yaşar Duman on 17.11.2023.
//

import UIKit

protocol HomeVCInterface: AnyObject {
    func configureViewController()
    func specialProductReloadData()
    func categoryCollectionReloadData()
    func pushDetailVC(product: Product)
}

final class HomeVC: UIViewController {

    //MARK: - Properties
    private let homeView = HomeView()
    private lazy var viewModel = HomeVM(view: self)
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
 
    
    override func loadView() {
        view = homeView
    }
    
    //MARK: - Configure ViewController
    private func configureNavBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .label
      
        let titleLabel = UILabel()
        titleLabel.text = "E-Commerce 🛒"

        if let customFont = UIFont(name: "Superlative", size: 15) {
            titleLabel.font = customFont
            self.navigationItem.titleView = titleLabel
        } else {
            print("Özel font yüklenirken bir hata oluştu.")
        }
        
        let rightBarButton = UIBarButtonItem(customView: homeView.favoriteButton)
        navigationItem.rightBarButtonItem = rightBarButton
      
    }
 
    
    //MARK: - Register Custom Cell
    private func collectionCellRegister() {
        homeView.specialProductsCollection.register(SpecialCollectionCell.self, forCellWithReuseIdentifier: SpecialCollectionCell.identifier)
        homeView.categoryCollection.register(CategoryCollectionCell.self, forCellWithReuseIdentifier: CategoryCollectionCell.identifier)
        homeView.productCollection.register(ProductCollectionCell.self, forCellWithReuseIdentifier: ProductCollectionCell.identifier)
    }
    
    //MARK: - Setup Delegates
    private func setupDelegates() {
        homeView.specialProductsCollection.dataSource = self
        homeView.specialProductsCollection.delegate = self
        
        homeView.categoryCollection.dataSource = self
        homeView.categoryCollection.delegate = self
        
        homeView.productCollection.dataSource = self
        homeView.productCollection.delegate = self
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension HomeVC:  UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case homeView.specialProductsCollection:
            return viewModel.specialProductsAll.count
        case homeView.categoryCollection:
            return viewModel.categories.count
        case homeView.productCollection:
            return viewModel.productByCategory.count
        default:
            return 0
        }
    }
    
    // MARK: - UICollectionView -> cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case homeView.specialProductsCollection:
            guard let cell = homeView.specialProductsCollection.dequeueReusableCell(withReuseIdentifier: SpecialCollectionCell.identifier, for: indexPath) as? SpecialCollectionCell else {
                return UICollectionViewCell()
            }
            let data = viewModel.specialProductsAll[indexPath.item]
            cell.configure(with: data)
            return cell
            
        case homeView.categoryCollection:
            guard let cell = homeView.categoryCollection.dequeueReusableCell(withReuseIdentifier: CategoryCollectionCell.identifier, for: indexPath) as? CategoryCollectionCell else {
                return UICollectionViewCell()
            }
            let data = viewModel.categories[indexPath.item]
            cell.configure(with: data)
            return cell
            
        case homeView.productCollection:
            guard let cell = homeView.productCollection.dequeueReusableCell(withReuseIdentifier: ProductCollectionCell.identifier, for: indexPath) as? ProductCollectionCell else {
                return UICollectionViewCell()
            }
            cell.delegate = self
            let data = viewModel.productByCategory[indexPath.item]
            cell.configure(with: data)
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    // MARK: - UICollectionViewLayout -> sizeForItemAt
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case homeView.specialProductsCollection:
            return CGSize(width: homeView.specialProductsCollection.frame.width , height: homeView.specialProductsCollection.frame.height)
            
        case homeView.categoryCollection:
            return CGSize(width: homeView.categoryCollection.frame.height, height: homeView.categoryCollection.frame.height)
            
        case homeView.productCollection:
            return CGSize(width: homeView.productCollection.frame.width / 2 - 10, height: (homeView.productCollection.frame.width / 2) - 20)
            
        default:
            return CGSize(width: 20, height: 20)
        }
    }
    
    // MARK: - UICollectionView -> didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case homeView.specialProductsCollection:
            viewModel.specialProductsDidSelectItem(at: indexPath)
            
        case homeView.categoryCollection:
            viewModel.categoryDidSelectItem(at: indexPath)

        case homeView.productCollection:
            viewModel.productByCategoryDidSelectItem(at: indexPath)
            
        default:
            return
        }
    }
}

// MARK: - UIScrollViewDelegate
extension HomeVC: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        switch scrollView{
        case homeView.specialProductsCollection:
            let currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
            homeView.pageControl.currentPage = currentPage
        default:
            return
        }
    }
}

//MARK: - HomeViewInterface
extension HomeVC: HomeVCInterface {
    func pushDetailVC(product: Product) {
        let vc = ProductDetailVC(product: product)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func configureViewController() {
        configureNavBar()
        homeView.delegate = self
        collectionCellRegister()
        setupDelegates()
    }
    
    func specialProductReloadData() {
        homeView.specialProductsCollection.reloadData()
        homeView.pageControl.numberOfPages = viewModel.specialProductsAll.count
    }
    
    func categoryCollectionReloadData() {
        homeView.categoryCollection.reloadData()
        homeView.productCollection.reloadData()
    }
}

extension HomeVC: HomeViewProtocol {
    func goToFavoritePage() {
        let vc = FavoriteProductVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func seeAllOfSpecialProducts() {
        let vc = SpecialProductVC()
        vc.updateUI(with: viewModel.specialProductsAll)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeVC: ProductCollectionCellProtocol {
    func toggleFavoriteStatus(of product: Product) {
        viewModel.toggleFavoriteStatus(for: product)
    }
}
