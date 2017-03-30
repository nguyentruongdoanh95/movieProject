//
//  MenuBar.swift
//  final_Movies
//
//  Created by Godfather on 12/23/16.
//  Copyright © 2016 Godfather. All rights reserved.
//

import UIKit
var arrOptions: Array<String> = ["Top Rated", "Popular", "Now Playing", "Upcoming"]
private let menuBarCell: String = "menuBarCell"
class MenuBar: UIView {
    
    var homeVC: HomeViewController? // Thể hiện
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupCollectionView()
        setupUnderlineView()
    }
    lazy var _collectionView: UICollectionView = {
        let flowLayout  = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection    = .horizontal
        let myColl                    = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        myColl.backgroundColor        = .white
        myColl.showsHorizontalScrollIndicator   = false
        myColl.isPagingEnabled                  = true
        myColl.register(MenuBarCell.self, forCellWithReuseIdentifier: menuBarCell)
        myColl.dataSource   = self
        myColl.delegate     = self
        myColl.translatesAutoresizingMaskIntoConstraints = false
        return myColl
    }()
    private func setupCollectionView(){
        addSubview(_collectionView)
        addConstraintsWithVSF(formatString: "H:|[v0]|", views: _collectionView)
        addConstraintsWithVSF(formatString: "V:|[v0]|", views: _collectionView)
        // Khi run thì mặc định sẽ là cell đầu tiên
        let indexPath = IndexPath(item: 1, section: 0)
        _collectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.centeredHorizontally)
    }
    
    let underlineView: UIView = {
        let v             = UIView()
        v.backgroundColor = .white
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var leftconstraintsUnderLine: NSLayoutConstraint? // custom khi scroll theo chiều x
    private func setupUnderlineView() {
        addSubview(underlineView)
        underlineView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive      = true
        underlineView.heightAnchor.constraint(equalToConstant: 3).isActive              = true
        underlineView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4).isActive  = true
        // Hiệu ứng khi scroll thì left thay đổi
        leftconstraintsUnderLine =  underlineView.leftAnchor.constraint(equalTo: self.leftAnchor)
        leftconstraintsUnderLine?.isActive          = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// Cấu hình cho Menubar
extension MenuBar: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrOptions.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: menuBarCell, for: indexPath) as! MenuBarCell
        cell.nameOptionLabel.text = arrOptions[indexPath.item]
        return cell
    }
}

extension MenuBar: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 4, height: frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Khi chọn cell nào thì cell trong HomeVC sẽ scroll tương ứng
        homeVC?.scrollToMenuIndex(indexMenu: indexPath.item)
    }
}
