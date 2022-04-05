//
//  UILabel+Font.swift
//  OzeGitHubTest
//
//  Created by WEMABANK on 30/03/2022.
//

import Foundation
import UIKit

extension UILabel{
  static func labelRegular(text: String, textSize : CGFloat = 16,
                       textColor : UIColor = .black,  alignment: NSTextAlignment = .center) -> UILabel{
      let label = UILabel()
      label.text = text
      label.font = UIFont(name: "HelveticaNeue-Regular", size: textSize)
      label.textAlignment = .center
      label.numberOfLines = 0
      label.textColor = textColor
      return label
  }
  static func labelBold(text: String, textSize : CGFloat = 16,
                        textColor : UIColor = .black, alignment: NSTextAlignment = .center) -> UILabel{
      let label = UILabel()
      label.text = text
      label.font = UIFont(name: "HelveticaNeue-Bold", size: textSize)
    label.textAlignment = .center
      label.numberOfLines = 0
      label.textColor = textColor
      return label
  }
}
