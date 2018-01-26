//
//  DownloadOperation.swift
//  65apps-1
//
//  Created by Garafutdinov Ravil on 25/01/2018.
//  Copyright © 2018 RG. All rights reserved.
//

import UIKit

class DownloadOperation: Operation {
    
    public var url: URL?
    public var cell: UITableViewCell?
    public var data: Data?
    
    // можно использовать родные isCancelled и completionBlock при синхронной загрузке изображения
    public var downloadCancelled: Bool = false
    public var downloadCompletionBlock:()->Void = {}
    
    override func cancel() {
        super.cancel()
        downloadCancelled = true
    }
    
    override func main() {
        super.main()
        guard url != nil, cell != nil else { return }
        
        if downloadCancelled {
            print("cancelled before download")
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data, error == nil else { return }
            
            usleep(100000) // задержка для наглядности
            
            if self.downloadCancelled {
                print("cancelled, return after download")
                return
            }
            
            self.data = data
            
            self.downloadCompletionBlock()
        }
        dataTask.resume()
    }
}
