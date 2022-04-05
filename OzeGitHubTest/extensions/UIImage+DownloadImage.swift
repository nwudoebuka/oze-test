//
//  UIImage+DownloadImage.swift
//  OzeGitHubTest
//
//  Created by WEMABANK on 02/04/2022.
//

import Foundation
import UIKit

extension UIImageView{
  func downloadFromPath(from: URL) {
      print("Download Started")
      getData(from: from) { data, response, error in
          guard let data = data, error == nil else { return }
          print(response?.suggestedFilename ?? from.lastPathComponent)
          print("Download Finished")
          // always update the UI from the main thread
          DispatchQueue.main.async() { [weak self] in
              self?.image = UIImage(data: data)
          }
      }
  }
  func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
      URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
  }
}
