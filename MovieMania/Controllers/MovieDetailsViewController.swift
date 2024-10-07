//
//  MovieDetailsViewController.swift
//  MovieMania
//
//  Created by Thush-Fdo on 08/10/2024.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    var imageView = UIImageView(frame: .zero)
    var titleLabel = UILabel(frame: .zero)
    var descLabel = UILabel(frame: .zero)
    
    var viewModel: MovieDetailsViewModel!
    
    init(viewModel: MovieDetailsViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        setupView()
        configView()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Details"
    }
    
    func setupView() {
        view.addSubviews(imageView, titleLabel, descLabel)
        
        let padding:CGFloat = 15
        
        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        
        descLabel.font = .systemFont(ofSize: 16, weight: .regular)
        descLabel.numberOfLines = 0
        descLabel.textAlignment = .justified
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.round(15)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 25),
            
            descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            descLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            descLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
        
    }
    
    func configView() {
        titleLabel.text = viewModel.movieTitle
        descLabel.text = viewModel.desc
        
        NetworkManager.shared.downloadImage(from: viewModel.movieImage ?? "") { [weak self] Image in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.imageView.image = Image
            }
        }
    }

}
