//
//  MainMovieCell.swift
//  MovieMania
//
//  Created by Thush-Fdo on 07/10/2024.
//

import UIKit

class MainMovieCell: UITableViewCell {
    
    static let reuseID = "MainMovieCellID"
    
    let bg = UIView(frame: .zero)
    let movieImage = UIImageView(frame: .zero)
    let movieName = UILabel(frame: .zero)
    let rateLabel = UILabel(frame: .zero)
    let dateLabel = UILabel(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bg.addBorder(color: .label, width: 1)
        bg.round(15)
        movieImage.round(8)
        
        backgroundColor = .clear
        bg.backgroundColor = .lightGray
    }
    
    
    private func configure() {
        addSubview(bg)
        bg.addSubviews(movieImage, movieName, dateLabel, rateLabel)
        
        let aspectRatio: CGFloat = 85/120
        let padding: CGFloat = 8
        
        movieName.numberOfLines = 0
        movieName.lineBreakMode = .byWordWrapping
        
        movieName.font = .systemFont(ofSize: 14, weight: .semibold)
        dateLabel.font = .systemFont(ofSize: 12, weight: .regular)
        rateLabel.font = .systemFont(ofSize: 12, weight: .thin)
        
        bg.translatesAutoresizingMaskIntoConstraints = false
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        movieName.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        rateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bg.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            bg.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            bg.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            bg.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            
            movieImage.topAnchor.constraint(equalTo: bg.topAnchor, constant: padding),
            movieImage.leadingAnchor.constraint(equalTo: bg.leadingAnchor, constant: padding),
            movieImage.bottomAnchor.constraint(equalTo: bg.bottomAnchor, constant: -padding),
            movieImage.widthAnchor.constraint(equalTo: movieImage.heightAnchor, multiplier: aspectRatio),
            
            movieName.topAnchor.constraint(equalTo: movieImage.topAnchor),
            movieName.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: padding),
            movieName.trailingAnchor.constraint(equalTo: bg.trailingAnchor, constant: -padding),
            movieName.heightAnchor.constraint(equalToConstant: 15),
            
            rateLabel.bottomAnchor.constraint(equalTo: bg.bottomAnchor, constant: -padding),
            rateLabel.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: padding),
            rateLabel.trailingAnchor.constraint(equalTo: bg.trailingAnchor, constant: -padding),
            rateLabel.heightAnchor.constraint(equalToConstant: 14),
            
            dateLabel.bottomAnchor.constraint(equalTo: rateLabel.topAnchor, constant: -padding),
            dateLabel.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: bg.trailingAnchor, constant: -padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 14)
            
        ])
    }
    
    func set(viewmodel: MovieTableCellViewModel) {
        movieName.text = viewmodel.title
        dateLabel.text = viewmodel.date
        rateLabel.text = viewmodel.rating
        
        NetworkManager.shared.downloadImage(from: viewmodel.imageUrl ?? "") { [weak self] Image in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.movieImage.image = Image
            }
        }
    }
    
}
