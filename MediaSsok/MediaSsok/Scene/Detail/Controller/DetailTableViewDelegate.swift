//
//  DetailTableViewDelegate.swift
//  MovieSsok
//
//  Created by taekki on 2022/08/04.
//

import UIKit

final class DetailTableViewDelegate: NSObject, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
