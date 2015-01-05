//
//  DetailsViewController.swift
//  SwiftTutorials
//
//  Created by Michael Reining on 1/4/15.
//  Copyright (c) 2015 Mike Reining. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, APIControllerProtocol {
    var album: Album?
    var tracks = [Track]()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var albumCover: UIImageView!
    @IBOutlet weak var tracksTableView: UITableView!
    lazy var api : APIController = APIController(delegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = self.album?.title
        albumCover.image = UIImage(data: NSData(contentsOfURL: NSURL(string: self.album!.largeImageURL)!)!)
        
        if self.album != nil {
            api.lookupAlbum(self.album!.collectionId)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TrackCell") as TrackCell
        let track = tracks[indexPath.row]
        cell.titleLabel?.text = track.title
        cell.playIcon?.text = "▶️"
        
        return cell
    }
    
    // MARK: API Controller Protocol
    
    func didReceiveAPIResults(results: NSDictionary) {
        var resultsArr: NSArray = results["results"] as NSArray
        dispatch_async(dispatch_get_main_queue(), {
            self.tracks = Track.tracksWithJSON(resultsArr)
            self.tracksTableView.reloadData()
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
    }
}
