//
//  HomeViewController.swift
//  final_Movies
//
//  Created by Godfather on 12/26/16.
//  Copyright © 2016 Godfather. All rights reserved.
//

import UIKit

private let toprated    = "topratedCell"
private let popular     = "popularCell"
private let nowplaying  = "nowplayingCell"
private let upcoming    = "upcomingCell"

class HomeViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // NotificationCenter: bắn sự kiện và lắng nghe sự kiện
         NotificationCenter.default.addObserver(self, selector: #selector(moveToDetailVCBy(noti:)), name: NSNotification.Name(rawValue: "viewDetail") , object: nil)
        setupNavigation()
        setupMenuBar()
        configureColletionView()
        setupBarButton()
    }
    // Lắng nghe sự kiện để push qua màn hình khác
    @objc private func moveToDetailVCBy(noti: Notification) {
        guard let userInfo  = noti.userInfo else {return}
        guard let movieId   = userInfo["movieId"] as? Int else {return}
        let detailVC        = DeatailMovieViewController()
        detailVC.idMovie    = movieId
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func setupNavigation() {
        navigationController?.navigationBar.isTranslucent = false
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 88, height: view.frame.height))
        titleLabel.text = "Top Rated"
        titleLabel.textColor     = .white
        titleLabel.textAlignment = .left
        titleLabel.font          = UIFont.boldSystemFont(ofSize: 14)
        navigationItem.titleView = titleLabel
    }
    // Khởi tạo 1 menu bar tự custom
    lazy var menuBar: MenuBar = {
        let mb      = MenuBar()
        mb.homeVC   = self
        mb.translatesAutoresizingMaskIntoConstraints = false
        return mb
    }()
    func setupMenuBar() {
        view.addSubview(menuBar)
        view.addConstraintsWithVSF(formatString: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithVSF(formatString: "V:|[v0(50)]", views: menuBar)
    }
    // Tạo bar button
    func setupBarButton() {
        let searchButton = UIBarButtonItem(image: UIImage(named: "search")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSearch))
        let userButton = UIBarButtonItem(image: UIImage(named: "user")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleUser))
        navigationItem.rightBarButtonItems = [userButton ,searchButton]
    }
    func handleSearch() {
        print("Search")
    }
    
    func handleUser() {
        print("User")
    }

    func configureColletionView() {
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection      = .horizontal
            flowLayout.minimumLineSpacing   = 0
        }
        collectionView?.backgroundColor         = .white
        collectionView?.isPagingEnabled         = true
        collectionView?.contentInset            = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets   = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.register(TopRatedCell.self, forCellWithReuseIdentifier: toprated)
        collectionView?.register(PopularCell.self, forCellWithReuseIdentifier: popular)
        collectionView?.register(NowPlayingCell.self, forCellWithReuseIdentifier: nowplaying)
        collectionView?.register(UpcomingCell.self, forCellWithReuseIdentifier: upcoming)
    }
    
    // ********************************************************************************** //
    // ********************************************************************************** //
    // ********************************************************************************** //
    // ********************************************************************************** //
    // ********************************************************************************** //
    // ********************************************************************************** //
    // Thay đổi title khi chọn vào 1 cell của menu bar
    private func setTitleWhenScrollMenuIndex(index: Int) {
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.text = "\(arrOptions[index])"
        }
    }
    // Khi chọn vào 1 cell menubar thì collectionview sẽ scroll đến cell tương ứng vs vị trí indexMenu
    func scrollToMenuIndex(indexMenu: Int) {
        let indexPath = IndexPath(item: indexMenu, section: 0)
        collectionView?.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.centeredHorizontally)
        setTitleWhenScrollMenuIndex(index: indexMenu)
    }
    // Thay đổi constant của underline trong menubar
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        menuBar.leftconstraintsUnderLine?.constant = offSet / 4
    }
    
    // Khi scroll collectionview --> bắt vị trí cell của menubar để thay đổi tilte
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let memory              = targetContentOffset.move().x
        let index               = memory / (view.frame.width)
        let selectedIndexPath   = IndexPath(item: Int(index), section: 0)
        menuBar._collectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.centeredHorizontally)
        setTitleWhenScrollMenuIndex(index: Int(index))
    }
    // ********************************************************************************** //
    // ********************************************************************************** //
    // ********************************************************************************** //
    // ********************************************************************************** //
    // ********************************************************************************** //
    // ********************************************************************************** //
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Cấu hình cho collection View
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let indexRow = indexPath.item
        switch indexRow {
        case 0:
            return collectionView.dequeueReusableCell(withReuseIdentifier: toprated, for: indexPath) as! TopRatedCell
        case 1:
            return collectionView.dequeueReusableCell(withReuseIdentifier: popular, for: indexPath) as! PopularCell
        case 2:
            return collectionView.dequeueReusableCell(withReuseIdentifier: nowplaying, for: indexPath) as! NowPlayingCell
        default:
            return collectionView.dequeueReusableCell(withReuseIdentifier: upcoming, for: indexPath) as! UpcomingCell
        }
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}
