//
//  TopFeedViewModel.swift
//  RedditClient
//
//  Created by Sergey Mozgovoy on 17.11.2020.
//

import UIKit

final class TopFeedViewModel: NSObject {
    
    private(set) var items = [TopFeedViewModelItem]()
    
    var reload: (() -> Void)?
    var onImagePressed: ((_ url: String) -> Void)?

    private var isLoading: Bool = false
    private var after: String?
    
    var api: API? {
        didSet {
            getTopFeed()
        }
    }
    
    @objc func refreshData() {
        after = nil
        getTopFeed(isRefreshed: true)
    }
    
    private func getTopFeed(isRefreshed: Bool = false) {
        guard isLoading == false else {
            return
        }
        
        isLoading = true
        
        let request = GetTopFeedRequest(by: after)
        api?.send(request) { [weak self] (result) in
            switch result {
            case .success(let dataResponse):
                self?.after = dataResponse.data.after
                self?.cofigureItems(by: dataResponse.data, isRefreshed: isRefreshed)
            case .failure(let error):
                print(error)
            }
            
            self?.isLoading = false
        }
    }
    
    private func cofigureItems(by data: DataModel, isRefreshed: Bool = false) {
        if isRefreshed {
            items.removeAll()
        }
        
        if let item = items.first {
            item.appendModels(data.children)
        } else {
            let item = TopFeedViewModelItem(data.children)
            items.append(item)
        }
        reload?()
    }
}

extension TopFeedViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  items.isEmpty {
            return 0
        }
        let item = items[section]
        return item.rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TopFeedTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.delegate = self
        let item = items[indexPath.section]
        cell.model = item.models[indexPath.row]
        return cell
    }
    
    
}

extension TopFeedViewModel: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
//        print(indexPaths)
        
        guard !items.isEmpty else { return }
        guard let lastPrefetchIndexPath = indexPaths.last, lastPrefetchIndexPath.row >= items[lastPrefetchIndexPath.section].rowCount - 10, !isLoading else { return }
        getTopFeed()
    }
}

extension TopFeedViewModel: UITableViewDelegate { }

extension TopFeedViewModel: TopFeedTableViewCellDelegate {
    func imagePressed(_ imageURl: String) {
        onImagePressed?(imageURl)
    }
}
