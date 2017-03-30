//
//  File.swift
//  final_Movies
//
//  Created by Godfather on 12/29/16.
//  Copyright © 2016 Godfather. All rights reserved.
//

import UIKit
import Kingfisher

class MoviesBaseContentCell: BaseCellTable {
    
    func getForCell(data: Movie) {
        
        nameFilm.text = data.title
        
        if let url = URL(string: data.backdrop_path) {
            imageMovie.kf.indicatorType = .activity
            imageMovie.kf.indicator?.startAnimatingView()
            imageMovie.kf.setImage(with: url, placeholder: nil, options: [.transition(.fade(0.25))], progressBlock: nil, completionHandler: { (img, error, cache, url) in
                self.imageMovie.kf.indicator?.stopAnimatingView()
                self.imageMovie.image = resizeImage(image: img!, targetSize: CGSize(width: 1000, height: 1000))
            })
        }
        
        scoreLabel.text = data.vote_average.convertToStringWithOneDecimal()
        // Ước lượng height nameFilm
        let content: String? = data.title
        if let videoTitle = content {
            let size = CGSize(width: frame.width - 100, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedRect = NSString(string: videoTitle).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
            
            if estimatedRect.size.height > 24 {
                nameFilmLabelHeightContraint?.constant = 44
            } else {
                nameFilmLabelHeightContraint?.constant = 24
            }
        }
        
    }
    
    override func setupInCell() {
        self.layoutIfNeeded()
        autoLayout()
    }
    
    let viewBackground: UIView = {
        let v               = UIView()
        v.backgroundColor   = UIColor(red: 222/255, green: 227/255, blue: 227/255, alpha: 1)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    // MARK: View hình film
    let viewImage: UIView = {
        let v               = UIView()
        v.backgroundColor  = .clear
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let imageMovie: UIImageView = {
        let img         = UIImageView()
        img.contentMode = .scaleToFill
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    // MARK: View thông tin film
    let viewLabel: UIView = {
        let v                   = UIView()
        v.backgroundColor       = .white
        v.layer.cornerRadius    = 5
        v.layer.masksToBounds   = false
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let nameFilm: UILabel = {
        let lbl             = UILabel()
        lbl.text            = "IP Man"
        lbl.font            = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment   = .left
        lbl.numberOfLines   = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let typeFilm: UILabel = {
        let lbl             = UILabel()
        lbl.text            = "Action, Romantic"
        lbl.font            = UIFont.systemFont(ofSize: 12)
        lbl.textColor       = UIColor.gray
        lbl.textAlignment   = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let separator: UIView = {
        let v               = UIView()
        v.backgroundColor   = .gray
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var detailButton: UIButton = {
        let btn = UIButton(type: UIButtonType.system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "detail")?.withRenderingMode(.alwaysOriginal), for: UIControlState.normal)
        btn.addTarget(self, action: #selector(handleDetail), for: UIControlEvents.touchUpInside)
        return btn
    }()
    
    func handleDetail() {
        print("Detail Film")
    }
    
    let decriptionFilm: UILabel = {
        let lbl             = UILabel()
        lbl.text            = "Hồ Thị Ngọc Phúc sinh năm 1995 hiện đang là sinh viên trường ĐH Tôn Đức Thắng"
        lbl.numberOfLines   = 3
        lbl.font            = UIFont.systemFont(ofSize: 12)
        lbl.textColor       = UIColor.gray
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    // MARK: View điểm
    let viewScore: UIView = {
        let v                   = UIView()
        v.backgroundColor       = UIColor(red: 255/255, green: 205/255, blue: 0/255, alpha: 1)
        v.layer.cornerRadius    = 22
        v.layer.masksToBounds   = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let scoreLabel: UILabel = {
        let lbl             = UILabel()
        lbl.text            = "7.5"
        lbl.textColor       = .white
        lbl.textAlignment   = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    // MARK: Func autoLayout
    var nameFilmLabelHeightContraint: NSLayoutConstraint?
    func autoLayout() {
        addSubview(viewBackground)
        addConstraintsWithVSF(formatString: "H:|[v0]|", views: viewBackground)
        addConstraintsWithVSF(formatString: "V:|[v0]|", views: viewBackground)
        
        viewBackground.addSubview(viewLabel)
        addConstraintsWithVSF(formatString: "H:|-4-[v0]-4-|", views: viewLabel)
        viewLabel.bottomAnchor.constraint(equalTo: viewBackground.bottomAnchor, constant: 0).isActive = true
        viewLabel.heightAnchor.constraint(equalTo: viewBackground.heightAnchor, multiplier: 3/4).isActive = true
        
        addSubview(viewImage)
        addConstraintsWithVSF(formatString: "V:|-24-[v0]-8-|", views: viewImage)
        viewImage.leftAnchor.constraint(equalTo: viewBackground.leftAnchor, constant: 16).isActive = true
        viewImage.widthAnchor.constraint(equalTo: viewBackground.widthAnchor, multiplier: 3/8).isActive = true
        
        viewImage.addSubview(imageMovie)
        viewImage.addConstraintsWithVSF(formatString: "H:|[v0]|", views: imageMovie)
        viewImage.addConstraintsWithVSF(formatString: "V:|[v0]|", views: imageMovie)
        
        addSubview(viewScore)
        viewScore.centerXAnchor.constraint(equalTo: viewImage.trailingAnchor).isActive = true
        viewScore.bottomAnchor.constraint(equalTo: viewImage.bottomAnchor, constant: -8).isActive = true
        viewScore.widthAnchor.constraint(equalToConstant: 44).isActive = true
        viewScore.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        viewScore.addSubview(scoreLabel)
        scoreLabel.centerXAnchor.constraint(equalTo: viewScore.centerXAnchor).isActive = true
        scoreLabel.centerYAnchor.constraint(equalTo: viewScore.centerYAnchor).isActive = true
        
        
        
        viewLabel.addSubview(detailButton)
        detailButton.topAnchor.constraint(equalTo: viewLabel.topAnchor, constant: 4).isActive = true
        detailButton.rightAnchor.constraint(equalTo: viewLabel.rightAnchor, constant: -4).isActive = true
        detailButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        detailButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        viewLabel.addSubview(nameFilm)
        nameFilm.leftAnchor.constraint(equalTo: viewImage.rightAnchor, constant: 22).isActive = true
        nameFilm.topAnchor.constraint(equalTo: viewLabel.topAnchor, constant: 4).isActive    = true
        nameFilm.rightAnchor.constraint(equalTo: detailButton.leftAnchor).isActive = true
        nameFilmLabelHeightContraint = NSLayoutConstraint(item: nameFilm, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: self, attribute: .height, multiplier: 0, constant: 24)
        nameFilmLabelHeightContraint?.isActive = true
        
        viewLabel.addSubview(typeFilm)
        typeFilm.leadingAnchor.constraint(equalTo: nameFilm.leadingAnchor).isActive = true
        typeFilm.topAnchor.constraint(equalTo: nameFilm.bottomAnchor).isActive = true
        typeFilm.heightAnchor.constraint(equalToConstant: 20).isActive = true
        typeFilm.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        viewLabel.addSubview(separator)
        separator.leadingAnchor.constraint(equalTo: nameFilm.leadingAnchor).isActive = true
        separator.topAnchor.constraint(equalTo: typeFilm.bottomAnchor, constant: 1).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator.rightAnchor.constraint(equalTo: viewLabel.rightAnchor, constant: -4).isActive = true
        
        viewLabel.addSubview(decriptionFilm)
        decriptionFilm.leadingAnchor.constraint(equalTo: nameFilm.leadingAnchor).isActive = true
        decriptionFilm.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 4).isActive = true
        decriptionFilm.rightAnchor.constraint(equalTo: viewLabel.rightAnchor, constant: -4).isActive = true
        
    }
}
