//
//  DeatailMovieViewController.swift
//  final_Movies
//
//  Created by Godfather on 12/28/16.
//  Copyright © 2016 Godfather. All rights reserved.
//

import UIKit
import AVFoundation
import youtube_parser
import AVKit            // AVPlayerViewController

private let infoMovieCell = "infoMovieCell"
private let dataListCell = "dataListCell"

class DeatailMovieViewController: UIViewController {
    // Khai báo các biến cần sử dụng
    var idMovie:        Int = 0
    var isFirstLoad         = true
    let group               = DispatchGroup()
    var movie:          MovieDetail?            // Chứa thông tin film
    var videos:         [Video] = [Video]()
    var recommendMovies:[Movie] = [Movie]()     // Chứa film đc đề xuất
    var similarMovies:  [Movie] = [Movie]()     // Chứa film tương tự
    var casts:          [Cast]  = [Cast]()      // Chứa diễn viên
    let avController            = AVPlayerViewController() // Chơi video
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        autoLayout()
        //self.automaticallyAdjustsScrollViewInsets = false
        getDataForAPI()
    }
    
    
    let playerVideoView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var tableview: UITableView = {
        let tbl = UITableView(frame: .zero, style: UITableViewStyle.plain)
        tbl.translatesAutoresizingMaskIntoConstraints = false
        tbl.register(InfoMovieCell.self, forCellReuseIdentifier: infoMovieCell)
        tbl.register(DataListCell.self, forCellReuseIdentifier: dataListCell)
        tbl.dataSource = self
        tbl.delegate   = self
        return tbl
    }()
    
    private func autoLayout() {
        view.addSubview(tableview)
        view.addSubview(playerVideoView)
        view.addConstraintsWithVSF(formatString: "H:|[v0]|", views: playerVideoView)
        view.addConstraintsWithVSF(formatString: "H:|[v0]|", views: tableview)
        view.addConstraintsWithVSF(formatString: "V:|[v0(165)][v1]|", views: playerVideoView, tableview)
    }
    
    private func getDataForAPI() {
        if isFirstLoad {
            group.enter()
            OfMovie.share.movieDetail(id: idMovie, response: { (movieDetail) in
                if let movieDetail = movieDetail {
                    self.movie = movieDetail
                }
                self.group.leave()
            })
            
            group.enter()
            OfMovie.share.getVideosByMovieId(id: idMovie, response: { (videos) in
                if let videos = videos, videos.count > 0 {
                    self.videos = videos
                    for video in videos {
                        
                        if video.type != .trailer && video.size != 720 && video.site != "YouTube" {continue}
                        
                        guard let youtubeURL = URL(string: "https://www.youtube.com/watch?v=\(video.key)") else {continue}
                        Youtube.h264videosWithYoutubeURL(youtubeURL, completion: { (info, error) in
                            guard let urlStr    = info?["url"] as? String else {return}
                            guard let videoURL  = URL(string: urlStr) else {return}
                            let avPlayerView    = AVPlayerLayer(player: AVPlayer(url: videoURL))
                            avPlayerView.frame  = self.playerVideoView.frame
                            self.avController.view.frame                     = self.playerVideoView.frame
                            self.avController.allowsPictureInPicturePlayback = false
                            self.avController.player                         = avPlayerView.player
                            self.avController.delegate                       = self
                            self.playerVideoView.addSubview(self.avController.view)
                            
                        })
                    }
                }
                self.group.leave()
            })
            
            group.enter()
            OfMovie.share.getCastListBy(movieId: idMovie, page: 1, response: { (castList) in
                if let castList = castList {
                    self.casts  = castList
                }
                self.group.leave()
            })
            
            group.enter()
            OfMovie.share.getRecommendMoviesBy(movieId: idMovie, page: 1, response: { (movies) in
                if let movies = movies {
                    self.recommendMovies = movies
                }
                self.group.leave()
            })
            
            group.enter()
            OfMovie.share.getSimilarMoviesBy(movieId: idMovie, page: 1, response: { (movies) in
                if let movies = movies {
                    self.similarMovies = movies
                }
                self.group.leave()
            })
            
            let resultGroupWait = group.wait(timeout: DispatchTime.now() + 30)
            if resultGroupWait == .success {
                self.tableview.reloadData()
            }else {
                print("time out")
            }
            self.clearAllNotice()
            isFirstLoad = false
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    //    func checkListMovies(cell: MovieDetailListTableViewCell, movieList: [Any]) {
    //        if movieList.count == 0  {
    //            cell.noResultView.isHidden = false
    //            cell.collectionView.isHidden = true
    //        }else {
    //            cell.noResultView.isHidden = true
    //            cell.collectionView.isHidden = false
    //        }
    //    }
    
    
}


// MARK: Cấu hình
extension DeatailMovieViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let indexSection = indexPath.section
        switch indexSection {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: infoMovieCell, for: indexPath) as! InfoMovieCell
            guard let movie = self.movie else { return cell }
            cell.setUpCell(data: movie)
            cell.movie = movie
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: dataListCell, for: indexPath) as! DataListCell
            cell.castList = casts
            cell.delegate = self    // Protocol
            cell._collectionView.reloadData()
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: dataListCell, for: indexPath) as! DataListCell
            cell.movieList = recommendMovies
            cell._collectionView.reloadData()
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: dataListCell, for: indexPath) as! DataListCell
            cell.movieList = similarMovies
            cell._collectionView.reloadData()
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: infoMovieCell, for: indexPath) as! InfoMovieCell
            guard let movie = self.movie else { return cell }
            cell.setUpCell(data: movie)
            cell.movie = movie
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            return "Cast"
        case 2:
            return "Recommendations"
        case 3:
            return "Similar"
        default:
            return nil
        }
    }
}

extension DeatailMovieViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let indexSection = indexPath.section
        switch indexSection {
        case 0:
            return 220
        default:
            return 150
        }
    }
}

// Liên quan đến chơi video (play, pause)
extension DeatailMovieViewController : AVPlayerViewControllerDelegate {
    func playerViewControllerWillStartPictureInPicture(_ playerViewController: AVPlayerViewController) {
        playerViewController.player?.play()
    }
    
    func playerViewControllerWillStopPictureInPicture(_ playerViewController: AVPlayerViewController) {
        playerViewController.player?.pause()
    }
}

// Adopt protocol

extension DeatailMovieViewController: MovieDetailListTableViewCellDelegate {
    func moveToMoveListVCBy(castId: Int, castName: String) {
        let movieListVC = ListMovieViewController()
        movieListVC.castID = castId
        movieListVC.castName = castName
        avController.player?.pause()
        self.navigationController?.pushViewController(movieListVC, animated: true)
    }
}

