//
//  InfoMovieCell.swift
//  final_Movies
//
//  Created by Godfather on 12/27/16.
//  Copyright © 2016 Godfather. All rights reserved.
//

import UIKit

protocol MovieDetailTableViewCellDelegate : class {
    func addWatchList(videoId: Int)
}

class InfoMovieCell: BaseCellTable {
    weak var delegate:  MovieDetailTableViewCellDelegate?
    var movie:     MovieDetail?
    
    func setUpCell(data: MovieDetail) {
        scoreLabel.text         = data.vote_average.convertToStringWithOneDecimal()
        popularityContent.text  = data.popularity.convertToStringWithOneDecimal()
        titleContent.text       = data.title
        budgetContent.text      = data.budget.convertToStringWithOneDecimal()
        revenueContent.text     = data.revenue.convertToStringWithOneDecimal()
        dateContent.text        = data.release_date
        
        
        var genreNameList:[String] = [String]()
        for genre in data.genres {
            genreNameList.append(genre.name)
        }
        genreContent.text = genreNameList.joined(separator: ", ")
        guard let imgUrl = URL(string: data.poster_path) else {
            self.imageMovie.image = nil
            return
        }
        imageMovie.kf.indicatorType = .activity
        imageMovie.kf.indicator?.startAnimatingView()
        imageMovie.kf.setImage(with: imgUrl, placeholder: nil, options: [.transition(.fade(0.25)), .backgroundDecode]) { (img, error, cache, url) in
            if let img = img {
                DispatchQueue.main.async(execute: {
                    self.imageMovie.image = img
                    self.imageMovie.kf.indicator?.stopAnimatingView()
                })
            }else {
                DispatchQueue.main.async(execute: {
                    self.imageMovie.image = nil
                    self.imageMovie.kf.indicator?.stopAnimatingView()
                })
            }
        }
        let content: String? = data.title
        if let videoTitle = content {
            let size            = CGSize(width: frame.width, height: 1000)
            let options         = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedRect   = NSString(string: videoTitle).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
            
            if estimatedRect.size.height > 24 {
                nameFilmLabelHeightContraint?.constant = 60
            } else {
                nameFilmLabelHeightContraint?.constant = 24
            }
        }
        let genre: String? = genreNameList.joined(separator: ", ")
        if let videoGenre = genre {
            let size            = CGSize(width: frame.width - 100, height: 1000)
            let options         = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedRect   = NSString(string: videoGenre).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
            
            if estimatedRect.size.height > 24 {
                genreFilmLabelHeightContraint?.constant = 60
            } else {
                genreFilmLabelHeightContraint?.constant = 24
            }
        }
    }
    
    override func setupInCell() {
        autoLayout()
    }
    
    let viewBackground: UIView = {
        let v               = UIView()
        v.backgroundColor   = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let imageMovie: UIImageView = {
        let img  = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    lazy var watchButton: UIButton = {
        let btn = UIButton(type: UIButtonType.system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Add Watchlist", for: UIControlState.normal)
        btn.addTarget(self, action: #selector(handleWatchlist), for: UIControlEvents.touchUpInside)
        return btn
    }()
    
    func handleWatchlist() {
        print("Done!")
    }
    // MARK: Info movie
    let titleLabel: UILabel = {
        let lbl         = UILabel()
        lbl.text        = "Title:"
        lbl.textColor   = .black
        lbl.textAlignment   = .center
        lbl.font            = UIFont.boldSystemFont(ofSize: 14)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let dateLabel: UILabel = {
        let lbl         = UILabel()
        lbl.text        = "Date:"
        lbl.textAlignment   = .center
        lbl.textColor       = .black
        lbl.font            = UIFont.boldSystemFont(ofSize: 14)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let budgetLabel: UILabel = {
        let lbl     = UILabel()
        lbl.text    = "Budget:"
        lbl.textAlignment   = .center
        lbl.textColor       = .black
        lbl.font            = UIFont.boldSystemFont(ofSize: 14)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let popularityLabel: UILabel = {
        let lbl     = UILabel()
        lbl.text    = "Popularity:"
        lbl.textAlignment   = .center
        lbl.textColor       = .black
        lbl.font            = UIFont.boldSystemFont(ofSize: 14)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    let revenueLabel: UILabel = {
        let lbl     = UILabel()
        lbl.text    = "Revenue:"
        lbl.textAlignment   = .center
        lbl.textColor       = .black
        lbl.font            = UIFont.boldSystemFont(ofSize: 14)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    let genreLabel: UILabel = {
        let lbl     = UILabel()
        lbl.text    = "Genre(s):"
        lbl.textAlignment   = .center
        lbl.textColor       = .black
        lbl.font            = UIFont.boldSystemFont(ofSize: 14)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    /// Content
    let titleContent: UILabel = {
        let lbl             = UILabel()
        lbl.font            = UIFont.italicSystemFont(ofSize: 14)
        lbl.numberOfLines   = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let dateContent: UILabel = {
        let lbl     = UILabel()
        lbl.font    = UIFont.italicSystemFont(ofSize: 14)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let budgetContent: UILabel = {
        let lbl     = UILabel()
        lbl.font    = UIFont.italicSystemFont(ofSize: 14)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let popularityContent: UILabel = {
        let lbl             = UILabel()
        lbl.font            = UIFont.italicSystemFont(ofSize: 14)
        lbl.numberOfLines   = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    let revenueContent: UILabel = {
        let lbl             = UILabel()
        lbl.font            = UIFont.italicSystemFont(ofSize: 14)
        lbl.numberOfLines   = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    let genreContent: UILabel = {
        let lbl             = UILabel()
        lbl.font            = UIFont.italicSystemFont(ofSize: 14)
        lbl.numberOfLines   = 2
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    // MARK: View điểm
    let viewScore: UIView = {
        let v               = UIView()
        v.backgroundColor   = .clear
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    let imageBackground: UIImageView = {
        let img     = UIImageView()
        img.image   = #imageLiteral(resourceName: "vote")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let scoreLabel: UILabel = {
        let lbl         = UILabel()
        lbl.textColor   = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    var nameFilmLabelHeightContraint: NSLayoutConstraint?
    var genreFilmLabelHeightContraint: NSLayoutConstraint?
    func autoLayout() {
        addSubview(viewBackground)
        addConstraintsWithVSF(formatString: "H:|[v0]|", views: viewBackground)
        addConstraintsWithVSF(formatString: "V:|-4-[v0]|", views: viewBackground)
        
        viewBackground.addSubview(imageMovie)
        viewBackground.addConstraintsWithVSF(formatString: "V:|-8-[v0]-8-|", views: imageMovie)
        imageMovie.leftAnchor.constraint(equalTo: viewBackground.leftAnchor, constant: 8).isActive       = true
        imageMovie.widthAnchor.constraint(equalTo: viewBackground.widthAnchor, multiplier: 1/3).isActive = true
        
        viewBackground.addSubview(viewScore)
        viewScore.trailingAnchor.constraint(equalTo: imageMovie.trailingAnchor).isActive = true
        viewScore.topAnchor.constraint(equalTo: viewBackground.topAnchor).isActive       = true
        viewScore.widthAnchor.constraint(equalToConstant: 44).isActive  = true
        viewScore.heightAnchor.constraint(equalToConstant: 52).isActive = true
        
        viewScore.addSubview(imageBackground)
        viewScore.addConstraintsWithVSF(formatString: "H:|[v0]|", views: imageBackground)
        viewScore.addConstraintsWithVSF(formatString: "V:|[v0]|", views: imageBackground)
        
        viewScore.addSubview(scoreLabel)
        scoreLabel.centerXAnchor.constraint(equalTo: viewScore.centerXAnchor).isActive = true
        scoreLabel.centerYAnchor.constraint(equalTo: viewScore.centerYAnchor).isActive = true
        
        
        viewBackground.addSubview(titleLabel)
        viewBackground.addSubview(dateLabel)
        viewBackground.addSubview(popularityLabel)
        viewBackground.addSubview(genreLabel)
        viewBackground.addSubview(budgetLabel)
        viewBackground.addSubview(revenueLabel)
        
        titleLabel.leftAnchor.constraint(equalTo: imageMovie.rightAnchor, constant: 12).isActive  = true
        titleLabel.topAnchor.constraint(equalTo: viewBackground.topAnchor, constant: 12).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        
        dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive          = true
        dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12).isActive = true
        
        budgetLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive        = true
        budgetLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 6).isActive = true
        
        popularityLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive          = true
        popularityLabel.topAnchor.constraint(equalTo: budgetLabel.bottomAnchor, constant: 6).isActive = true
        
        revenueLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive               = true
        revenueLabel.topAnchor.constraint(equalTo: popularityLabel.bottomAnchor, constant: 6).isActive  = true
        
        genreLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive              = true
        genreLabel.topAnchor.constraint(equalTo: revenueLabel.bottomAnchor, constant: 6).isActive    = true
        genreLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        
        
        viewBackground.addSubview(titleContent)
        viewBackground.addSubview(dateContent)
        viewBackground.addSubview(popularityContent)
        viewBackground.addSubview(genreContent)
        viewBackground.addSubview(budgetContent)
        viewBackground.addSubview(revenueContent)
        
        titleContent.topAnchor.constraint(equalTo: viewBackground.topAnchor, constant: 12).isActive  = true
        titleContent.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 4).isActive    = true
        titleContent.widthAnchor.constraint(equalToConstant: 150).isActive                           = true
        nameFilmLabelHeightContraint = NSLayoutConstraint(item: titleContent, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: self, attribute: .height, multiplier: 0, constant: 24)
        nameFilmLabelHeightContraint?.isActive = true
        
        dateContent.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor).isActive          = true
        dateContent.leftAnchor.constraint(equalTo: dateLabel.rightAnchor, constant: 4).isActive  = true
        
        budgetContent.centerYAnchor.constraint(equalTo: budgetLabel.centerYAnchor).isActive          = true
        budgetContent.leftAnchor.constraint(equalTo: budgetLabel.rightAnchor, constant: 4).isActive  = true
        
        popularityContent.centerYAnchor.constraint(equalTo: popularityLabel.centerYAnchor).isActive = true
        popularityContent.leftAnchor.constraint(equalTo: popularityLabel.rightAnchor, constant: 4).isActive  = true
        revenueContent.centerYAnchor.constraint(equalTo: revenueLabel.centerYAnchor).isActive          = true
        revenueContent.leftAnchor.constraint(equalTo: revenueLabel.rightAnchor, constant: 4).isActive  = true
        
        genreContent.topAnchor.constraint(equalTo: genreLabel.topAnchor).isActive                 = true
        genreContent.leftAnchor.constraint(equalTo: genreLabel.rightAnchor, constant: 4).isActive = true
        genreContent.widthAnchor.constraint(equalToConstant: 150).isActive                        = true
        genreFilmLabelHeightContraint = NSLayoutConstraint(item: genreContent, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: self, attribute: .height, multiplier: 0, constant: 24)
        genreFilmLabelHeightContraint?.isActive = true
        
        
        viewBackground.addSubview(watchButton)
        watchButton.bottomAnchor.constraint(equalTo: viewBackground.bottomAnchor, constant: -8).isActive = true
        watchButton.rightAnchor.constraint(equalTo: viewBackground.rightAnchor, constant: -4).isActive   = true
        
    }
    
}


