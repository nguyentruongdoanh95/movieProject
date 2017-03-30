//
//  ListMovieViewController.swift
//  final_Movies
//
//  Created by Godfather on 12/29/16.
//  Copyright © 2016 Godfather. All rights reserved.
//

import UIKit
private let moviesBaseContentCell = "moviesBaseContentCell"

class ListMovieViewController: UITableViewController {
    
    var castID:     Int = 0
    var castName:   String = ""
    var movieList:  [Movie] = [Movie]()
    var typeOfMovie:TypeOfMovie?
    var isLoading:  Bool = true
    var page:       Int = 1
    let refeshing = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        self.automaticallyAdjustsScrollViewInsets = false
        getDataForAPI()
        self.title = castName
        tableView.addSubview(refeshing)
        tableView.isUserInteractionEnabled = true
    }
    func setupTableView() {
        tableView.register(MoviesBaseContentCell.self, forCellReuseIdentifier: moviesBaseContentCell)
    }
    
    func getDataForAPI() {
        isLoading = true
        self.startLoading()
        if let typeOfMovie = typeOfMovie {
            OfMovie.share.getListMovie(page: page, type: typeOfMovie.rawValue, responses: { (movieList) in
                if let movieList = movieList {
                    self.movieList = movieList
                    DispatchQueue.main.async(execute: {
                        self.tableView.reloadData()
                    })
                }
                self.isLoading = false
            })
        } else {
            OfMovie.share.getMovieListBy(castId: castID, page: page, response: { (movies) in
                if let movies = movies {
                    self.movieList += movies
                    DispatchQueue.main.async(execute: {
                        self.tableView.reloadData()
                    })
                }
                self.isLoading = false
                self.clearAllNotice()
            })
        }
    }
    
    func loadMore() {
        page += 1
        isLoading = true
        self.startLoading()
        if let typeOfMovie = typeOfMovie {
            OfMovie.share.getListMovie(page: page, type: typeOfMovie.rawValue, responses: { (movieList) in
                if let movieList = movieList {
                    self.movieList = movieList
                    DispatchQueue.main.async(execute: {
                        self.tableView.reloadData()
                    })
                } else {
                    self.page -= 1
                }
                self.isLoading = false
            })
        } else {
            OfMovie.share.getMovieListBy(castId: castID, page: page, response: { (movies) in
                if let movies = movies {
                    self.movieList += movies
                    DispatchQueue.main.async(execute: {
                        self.tableView.reloadData()
                    })
                } else {
                    self.page -= 1
                }
                self.isLoading = false
                self.clearAllNotice()
            })
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
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
            tableView.isUserInteractionEnabled = true
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: moviesBaseContentCell, for: indexPath) as! MoviesBaseContentCell
        cell.getForCell(data: movieList[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movieList[indexPath.item]
        // Bắn sự kiện
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "viewDetail" ), object: nil, userInfo: ["movieId": movie.id])
    }
}
