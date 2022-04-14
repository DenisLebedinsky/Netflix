//
//  SearchResultsViewController.swift
//  Netflix
//
//  Created by Denis Lebedinsky on 11.04.2022.
//

import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject {
    func searchResultsViewControllerDidTapItem(_ viewModel: TitlePreviewViewModel)
}

class SearchResultsViewController: UIViewController {

    public var titles:[Title] = [Title]()
    
    public weak var delegate: SearchResultsViewControllerDelegate?
    
    public let searchResultsCollecionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor  = .systemBackground
        view.addSubview(searchResultsCollecionView)
        
        searchResultsCollecionView.delegate = self
        searchResultsCollecionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        searchResultsCollecionView.frame = view.bounds
    }

}

extension SearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = searchResultsCollecionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let title = titles[indexPath.row]
        cell.configure(with: title.poster_path ?? "")
      
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let title = titles[indexPath.row]
        let titleName = title.original_title ?? ""
        
        APICaller.shared.getMovie(with: titleName) { [weak self] results in
            switch results {
            case .success(let videoElement):
                self?.delegate?.searchResultsViewControllerDidTapItem(TitlePreviewViewModel(title: titleName, youtubeVideo: videoElement, titleOverview: title.overview ?? ""))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
    }
    
}
