//
//  TableViewController.swift
//  65apps-1
//
//  Created by Garafutdinov Ravil on 22/01/2018.
//  Copyright © 2018 RG. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    let downloadQueue = OperationQueue()
    var operationsDict = Dictionary<UITableViewCell, DownloadOperation>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadQueue.name = "customImagesQueue"
        downloadQueue.qualityOfService = .background
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TVCellIdentifier", for: indexPath)
        
        let url = URL(string: "http://placehold.it/375x150?text=\(indexPath.row + 1)")
        if url != nil {
            downloadImage(withURL: url!, forCell: cell)
        }

        return cell
    }
    
    // простой вариант с GCD, есть баг при быстрой перемотке;
    // если изменить требование сигнатуры функции, можно использовать
/*    func downloadImage(withURL url: URL, forCell cell: UITableViewCell) {
        DispatchQueue.global().async {
            let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() {
                    cell.imageView?.image = UIImage(data: data)
                }
            }
            dataTask.resume()
        }
    }*/
    
    func downloadImage(withURL url: URL, forCell cell: UITableViewCell) {
        if let existingOperation = operationsDict[cell] {
            print("existing operation displaced, cancelling")
            existingOperation.cancel()
        }
        
        let downloadOperation = DownloadOperation()
        downloadOperation.url = url
        downloadOperation.cell = cell
        downloadOperation.downloadCompletionBlock = {
            if downloadOperation.downloadCancelled {
                print("downloadCancelled in completion block")
                return
            }
            
            DispatchQueue.main.async() {
                guard downloadOperation.data != nil else {return}
                print("image set")
                cell.imageView?.image = UIImage(data: downloadOperation.data!)
            }
        }
        downloadQueue.addOperation(downloadOperation)
        
        operationsDict[cell] = downloadOperation
    }
}
