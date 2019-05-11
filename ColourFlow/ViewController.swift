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

class ViewController: UIViewController {
    var touchCount = 0
    var count = 0
    var colors = [
        UIColor (hexString: "#f44336"),
        UIColor (hexString: "#e91e63"),
        UIColor (hexString: "#9c27b0"),
        UIColor (hexString: "#673ab7"),
        UIColor (hexString: "#3f51b5"),
        UIColor (hexString: "#2196f3"),
        UIColor (hexString: "#03a9f4"),
        UIColor (hexString: "#00bcd4"),
        UIColor (hexString: "#009688"),
        UIColor (hexString: "#4caf50"),
        UIColor (hexString: "#8bc34a"),
        UIColor (hexString: "#cddc39"),
        UIColor (hexString: "#ffeb3b"),
        UIColor (hexString: "#ffc107"),
        UIColor (hexString: "#ff9800"),
        UIColor (hexString: "#ff5722"),
        UIColor (hexString: "#795548"),
        UIColor (hexString: "#9e9e9e"),
        UIColor (hexString: "#607d8b")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        shuffleColors()
    }
    
    func shuffleColors () {
        var shuffled = [UIColor]()
        (0..<colors.count).forEach { _ in
            let rand = Int(arc4random_uniform(UInt32(colors.count)))
            shuffled.append(colors[rand]!)
            colors.remove(at: rand)
        }
        colors = shuffled
    }
    
    func getRandomColor () -> UIColor {
        count += 1
        if count == colors.count {
            count = 0
            shuffleColors()
        }
        return colors[count]!
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            touchCount += 1
            
            let location = touch.location(in: view)
            let over = UIView ()
            let width = 40.0
            let height = 40.0
            over.frame = CGRect(x: location.x - CGFloat(width / 2.0),
                                y: location.y - CGFloat(height / 2.0),
                                width: 40.0,
                                height: 40.0)
            view.addSubview(over)
            var config = UIView.RippleConfiguration (color: getRandomColor())
            config.scaleAnimateDuration = 1.4
            over.rippleAnimate(with: config) {
                over.removeFromSuperview()
            }
        }
    }
    
    @IBAction func aboutPressed(_ sender: UIButton) {
    }
}

