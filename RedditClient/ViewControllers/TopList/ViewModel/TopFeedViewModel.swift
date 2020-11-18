//
//  TopFeedViewModel.swift
//  RedditClient
//
//  Created by Sergey Mozgovoy on 17.11.2020.
//

import UIKit

class TopFeedViewModel: NSObject {
    
    private(set) var items = [TopFeedViewModelItem]()

    var reload: (() -> Void)?

    var api: API? {
        didSet {
            getTopFeed()
        }
    }
    
    private func getTopFeed() {
        let request = GetTopFeedRequest()
        api?.send(request) { [weak self] (result) in
            switch result {
            case .success(let dataResponse):
                self?.cofigureItems(by: dataResponse.data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func cofigureItems(by data: DataModel) {
        let item = TopFeedViewModelItem(data.children)
        items.append(item)
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
        let item = items[indexPath.section]
        cell.model = item.models[indexPath.row]
        return cell
    }
    
}

extension TopFeedViewModel: UITableViewDelegate {
    
}
