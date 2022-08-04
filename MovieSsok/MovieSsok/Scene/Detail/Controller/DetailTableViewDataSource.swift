//
//  DetailTableViewDataSource.swift
//  MovieSsok
//
//  Created by taekki on 2022/08/04.
//

import UIKit

final class DetailTableViewDataSource: NSObject, UITableViewDataSource {
    
    struct Model {
        var identifier = UUID()
    }
    
    private var data = (1...100).map { _ in
        return Model()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonCell.reuseIdentifier, for: indexPath) as? PersonCell else {
            fatalError("Expected `\(PersonCell.self)` type for reuseIdentifier \(PersonCell.reuseIdentifier). Check the configuration in Main.storyboard.")
        }
        return cell
    }
}
