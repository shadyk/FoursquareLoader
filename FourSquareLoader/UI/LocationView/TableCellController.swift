//
//  Created by Shady
//  All rights reserved.
//  

import UIKit


final class TableCellController {
    
    private var cell: LocationTableCell?
    var viewModel: Location?
    
    init(viewModel: Location? = nil) {
        self.viewModel = viewModel
    }
    
    func view(in tableView: UITableView) -> UITableViewCell {
        cell = tableView.dequeueReusableCell()
        cell?.lblName.text = "\(viewModel!.name)"
        return cell!
    }
}
