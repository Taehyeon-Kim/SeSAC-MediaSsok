//
//  DetailTableViewDataSource.swift
//  MovieSsok
//
//  Created by taekki on 2022/08/04.
//

import UIKit

struct Person {
    let name: String
    let originalName: String
    let profilePath: String
}

final class DetailTableViewDataSource: NSObject, UITableViewDataSource {

    private var dataSource: [Person] = []
    
    func updateData(_ person: [Person]) {
        self.dataSource = person
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonCell.reuseIdentifier, for: indexPath) as? PersonCell else {
            fatalError("Expected `\(PersonCell.self)` type for reuseIdentifier \(PersonCell.reuseIdentifier). Check the configuration in Main.storyboard.")
        }
        cell.configure(with: dataSource[indexPath.row])
        return cell
    }
}
