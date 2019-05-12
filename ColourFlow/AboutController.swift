// This file is part of ColourFlow.
// Copyright (C) 2019  Iván Alejandro Ávalos Díaz
//
// ColourFlow is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// ColourFlow is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Foobar.  If not, see <https://www.gnu.org/licenses/>.

import UIKit

class AboutController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if indexPath.section == 0 && indexPath.row == 1 {
            if let link = URL (string: "https://avalos.dulcedosystems.com") {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(link, options: [:]) { _ in
                        cell?.isSelected = false
                    }
                } else {
                    UIApplication.shared.openURL(link)
                    cell?.isSelected = false
                }
            }
        }
        if indexPath.section == 2 && indexPath.row == 1 {
            if let link = URL (string: "https://github.com/ivan-avalos/ColourFlow-iOS") {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(link, options: [:]) { _ in
                        cell?.isSelected = false
                    }
                } else {
                    UIApplication.shared.openURL(link)
                    cell?.isSelected = false
                }
            }
        }
        
        

    }
    
    @IBAction func donePressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

}
