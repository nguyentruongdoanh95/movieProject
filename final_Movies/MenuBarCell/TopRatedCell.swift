//
//  TopRatedCell.swift
//  final_Movies
//
//  Created by Godfather on 12/27/16.
//  Copyright © 2016 Godfather. All rights reserved.
//

import UIKit
private let contentCell:String = "contentCell"

class TopRatedCell: BaseCellCollection {
    // Khai báo các biến cần sử dụng
    var page        = 1
    var isFirstLoad = true
    let refeshing   = UIRefreshControl()
    var isLoading   = false
    var arrMovie:Array<Movie> = []
    
    override func setupInCell() {
        autoLayout()
        getDataForAPI()
    }
    
    lazy var collectionview: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 4
        let myColl = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        myColl.register(ContentCell.self, forCellWithReuseIdentifier: contentCell)
        myColl.translatesAutoresizingMaskIntoConstraints = false
        myColl.backgroundColor = UIColor(red: 222/255, green: 227/255, blue: 227/255, alpha: 1)
        myColl.delegate = self
        myColl.dataSource = self
        return myColl
    }()
    
    
    func getDataForAPI() {
        if isFirstLoad {
            self.startLoading()
            ForAPI.share.getListMovie(page: page, type: TypeOfMovie.topRated.rawValue, responses: { (movieList) in
                for item in movieList {
                    self.arrMovie.append(item)
                }
                DispatchQueue.main.async {
                    self.collectionview.reloadData()
                    self.stopLoading()
                }
            })
        }
    }
    
    func loadMore() {
        page += 1
        if isFirstLoad {
            self.startLoading()
            ForAPI.share.getListMovie(page: page, type: TypeOfMovie.topRated.rawValue, responses: { (movieList) in
                for item in movieList {
                    self.arrMovie.append(item)
                }
                DispatchQueue.main.async {
                    self.collectionview.reloadData()
                    self.stopLoading()
                }
            })
        }
        
    }
    func autoLayout() {
        addSubview(collectionview)
        addConstraintsWithVSF(formatString: "H:|[v0]|", views: collectionview)
        addConstraintsWithVSF(formatString: "V:|[v0]|", views: collectionview)
        collectionview.contentInset            = UIEdgeInsets(top: 25, left: 0, bottom: 0, right: 0)
        collectionview.scrollIndicatorInsets   = UIEdgeInsets(top: 25, left: 0, bottom: 0, right: 0)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if refeshing.isRefreshing {
            page = 1
            getDataForAPI()
            refeshing.endRefreshing()
        }
        if isLoading { return }
        
        let offSetY = scrollView.contentOffset.y             // Coordinates khi cuộn chiều y
        let heightOfContent = scrollView.contentSize.height  // Height nội dung
        if heightOfContent - offSetY - scrollView.bounds.size.height <= 1 {
            // Loadmore
            self.loadMore()
        }
    }
    
}


// Cấu hình...
extension TopRatedCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrMovie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCell, for: indexPath) as! ContentCell
        cell.getForCell(data: arrMovie[indexPath.item])
        return cell
    }
}


extension TopRatedCell: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionview.frame.width, height: collectionview.frame.height * 3 / 7)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Bắn sự kiện tại đây và HomeController sẽ lắng nghe sự kiện đc bắn
        let movie = arrMovie[indexPath.item]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "viewDetail" ), object: nil, userInfo: ["movieId": movie.id]) // Dữ liệu kèm theo khi đc bắn là id
    }
}
