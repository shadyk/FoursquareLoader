//
//  Created by Shady
//  All rights reserved.
//  

import UIKit

class LineSeparator: UIView {

    convenience init(){
        let frame = CGRect(x: 0, y: 0, width: 1, height: 2)
        self.init(frame: frame)
        backgroundColor = .lightGray
    }
}
