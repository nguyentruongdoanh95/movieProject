//
//  MovieCollCell.swift
//  final_Movies
//
//  Created by Godfather on 12/28/16.
//  Copyright © 2016 Godfather. All rights reserved.
//

import UIKit
private let contentDataListCell = "contentDataListCell"
// Protocol
protocol MovieDetailListTableViewCellDelegate : class {
    func moveToMoveListVCBy(castId: Int, castName: String)
}

class DataListCell: BaseCellTable {
    weak var delegate:  MovieDetailListTableViewCellDelegate?
    lazy var movieList: [Movie] = [Movie]()
    lazy var castList:  [Cast]  = [Cast]()
    
    override func setupInCell() {
        autoLayout()
    }
    lazy var _collectionView: UICollectionView = {
        let flowLayout                  = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing   = 0
        flowLayout.scrollDirection      = .horizontal
        let myColl = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        myColl.backgroundColor                  = .white
        myColl.showsHorizontalScrollIndicator   = false
        myColl.isPagingEnabled                  = true
        myColl.register(ContentDataListCell.self, forCellWithReuseIdentifier: contentDataListCell)
        myColl.dataSource   = self
        myColl.delegate     = self
        myColl.translatesAutoresizingMaskIntoConstraints = false
        return myColl
    }()

    
    private func autoLayout() {
        addSubview(_collectionView)
        addConstraintsWithVSF(formatString: "H:|[v0]|", views: _collectionView)
        addConstraintsWithVSF(formatString: "V:|[v0]|", views: _collectionView)
    }
}

// Cấu hình
extension DataListCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if movieList.count > 0 {
            return movieList.count
        }else {
            return castList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentDataListCell , for: indexPath) as! ContentDataListCell
        
        if movieList.count > 0 {
            let movie = movieList[indexPath.item]
            cell.getForCell(data: movie)
        }else {
            let cast = castList[indexPath.item]
            cell.getForCell(data: cast)
        }
        return cell
    }
}
extension DataListCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 4, height: frame.height)
    }
}

extension DataListCell : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if movieList.count > 0 {
            let movie = movieList[indexPath.item]
            // Bắn sự kiện
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "viewDetail" ), object: nil, userInfo: ["movieId": movie.id])
        }else if castList.count > 0 {
            let cast = castList[indexPath.item]
            delegate?.moveToMoveListVCBy(castId: cast.id, castName: cast.name)
        }
    }
}
