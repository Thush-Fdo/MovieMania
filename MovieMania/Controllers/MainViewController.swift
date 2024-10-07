//
//  MainViewController.swift
//  MovieMania
//
//  Created by Thush-Fdo on 13/09/2024.
//

import UIKit

class MainViewController: UIViewController {
    
    var tableView = UITableView(frame: .zero, style: .plain)
    
    //ViewModel
    var viewModel: MainViewModel = MainViewModel()
    
    var cellDataSource: [MovieTableCellViewModel] = []
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.color = .red
        view.hidesWhenStopped = true
        view.startAnimating()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureTableView()
        configureActivityLoader()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getData()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Latest Movies"
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.register(MainMovieCell.self, forCellReuseIdentifier: MainMovieCell.reuseID)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemBackground
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    
    func configureActivityLoader() {
        view.addSubview(activityIndicator)
        activityIndicator.bringSubviewToFront(self.view)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func bindViewModel() {
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let self = self, let isLoading = isLoading else {
                return
            }
            
            DispatchQueue.main.async {
                if isLoading {
                    self.activityIndicator.startAnimating()
                }
                else {
                    self.activityIndicator.stopAnimating()
                }
            }
        }
        
        viewModel.cellDataSource.bind { [weak self] movies in
            guard let self = self, let movies = movies else {
                return
            }
            
            self.cellDataSource = movies
            self.reloadTableView()
        }
    }
}
extension MainViewController {
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func openMovieDetails(movieID: Int) {
        guard let movie = viewModel.getMovie(with: movieID) else { return }
        
        let detailsViewModel = MovieDetailsViewModel(movie: movie)
        let detailsController = MovieDetailsViewController(viewModel: detailsViewModel)
        
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(detailsController, animated: true)
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainMovieCell.reuseID) as! MainMovieCell
        
        cell.set(viewmodel: (cellDataSource[indexPath.row]))
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieId = cellDataSource[indexPath.row].id
        self.openMovieDetails(movieID: movieId)
    }
}

