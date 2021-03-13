//
//  NewsArticlesViewController.swift
//  News
//
//  Created by Alvis Mach on 12/3/21.
//

import UIKit

protocol LoadingActivityIndicator {
    var activityIndicator: UIActivityIndicatorView! {get set}
    func showLoadingIndicator()
    func dismissLoadingIndicator()
}

let showNewsPageSegueIdentifier = "ShowNewsWebPage"

class NewsArticlesViewController: UITableViewController, LoadingActivityIndicator {
    
    var viewModel: NewsArticlesViewModel!
    
    let webService = WebService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView!.register(UINib(nibName: String(describing: NewsCell.self), bundle: nil), forCellReuseIdentifier: newsCellIdentifier)
        
        createActivityIndicator()
        
        loadNews()
    }
    
    private func createActivityIndicator() {
        if #available(iOS 13.0, *) {
            activityIndicator = UIActivityIndicatorView(style: .medium)
        } else {
            activityIndicator = UIActivityIndicatorView(style: .white)
        }
        activityIndicator.color = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: activityIndicator)
    }
    
    private func updateNavigationTitle() {
        navigationItem.title = viewModel.title
    }
    
    /**
     * Fetches news and update UI on completion
     */
    private func loadNews() {
        showLoadingIndicator()
        viewModel = NewsArticlesViewModel(webService: webService)
        viewModel.fetchNews {[weak self] error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                if let error = error {
                    self.showErrorMessage(error.localizedDescription)
                }
                self.updateNavigationTitle()
                self.tableView.reloadData()
            }
        }
    }
    // MARK: - LoadingActivityIndicator
    /**
     * The loading view that will show on top right of navigation bar when news is being fetched.
     */
    var activityIndicator: UIActivityIndicatorView!
    
    func showLoadingIndicator() {
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingIndicator() {
        activityIndicator.stopAnimating()
    }

}

//MARK: - Table view data source
extension NewsArticlesViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.newsArticleCellViewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: newsCellIdentifier, for: indexPath) as! NewsCell
        let cellViewModel = viewModel.newsArticleCellViewModels[indexPath.row]
        cell.configureCell(with: cellViewModel)
        return cell
    }
}

//MARK: - Table view delegate
extension NewsArticlesViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellViewModel = viewModel.newsArticleCellViewModels[indexPath.row]
        let pageViewModel = NewsPageViewModel(newsTitle: cellViewModel.headline, newsUrl: cellViewModel.url)
        performSegue(withIdentifier: showNewsPageSegueIdentifier, sender: pageViewModel)
    }
}

// MARK: - Alert Controller
extension NewsArticlesViewController {
    private func showErrorMessage(_ errorMessage: String) {
        let alertController = UIAlertController(title: "Error!", message: errorMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        navigationController?.present(alertController, animated: true, completion: nil)
    }
}


//MARK: - Navigation
extension NewsArticlesViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  showNewsPageSegueIdentifier {
            if let pageViewController = segue.destination as? NewsPageViewController,
               let pageViewModel = sender as? NewsPageViewModel {
                pageViewController.viewModel = pageViewModel
            }
        }
    }
}
