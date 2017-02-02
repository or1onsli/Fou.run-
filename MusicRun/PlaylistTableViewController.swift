//
//  PlaylistTableViewController.swift
//  Fou.run()
//
//  Copyright © 2016 Shock&Awe. All rights reserved.
//
import UIKit

class PlaylistTableViewController: UITableViewController {
    
    var songs: [Song] = [Song]()
    var songToPlay = ""
    var songArray: Array<Int> = []
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateArray()
        let sfondo = SfondoSfumato(size: self.view.frame.size)
        tableView.backgroundView = sfondo
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false

      }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return songs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PlaylistTableViewCell
        cell.backgroundColor = .clear
        
        let bgColor = UIView()
        bgColor.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        
        cell.selectedBackgroundView = bgColor
        
//        let item = mediaItems.items
        let item = songs[indexPath.row]
        cell.coverView.image = item.cover
        cell.songTitle.text = item.title
        cell.songTitle.font = UIFont(name: "Galindo-Regular", size: 20)
        cell.artist.text = item.artist
        cell.artist.font = UIFont(name: "Galindo-Regular", size: 13)
        return cell
    }
    
    func populateArray(){
        
        songs = [
            Song(title: "Lady Marmelade", artist: "Christina Aguilera & All Saints", playableSong: "allsaints.mp3", songArray: allsaints, cover: #imageLiteral(resourceName: "all_saints")),
            Song(title: "Candyman", artist: "Christina Aguilera", playableSong: "christina.mp3", songArray: christina, cover: #imageLiteral(resourceName: "candyman")),
            Song(title: "Play Hard", artist: "David Guetta ft. Ne-Yo & Akon", playableSong: "David Guetta - Play Hard ft. Ne-Yo, Akon (Lyrics).mp3", songArray: david_play, cover: #imageLiteral(resourceName: "david_play")),
            Song(title: "Turn me On", artist: "David Guetta ft. Nicki Minaj", playableSong: "David Guetta ft. Nicki Minaj - Turn Me On (Lyric Video) (1).mp3", songArray: david_turn, cover: #imageLiteral(resourceName: "david_turn")),
            Song(title: "Born to be Abramo", artist: "Elio e le Storie Tese", playableSong: "Elio e le Storie Tese - Born to be Abramo ∞ - Ω.mp3", songArray: elio, cover: #imageLiteral(resourceName: "elio")),
            Song(title: "Telephone", artist: "Lady Gaga", playableSong: "Lady Gaga   Telephone   Lyrics on screen.mp3", songArray: lady_telephone, cover: #imageLiteral(resourceName: "telephone")),
            Song(title: "Just Dance", artist: "Lady Gaga", playableSong: "Lady GaGa just dance lyrics.mp3", songArray: lady_just, cover: #imageLiteral(resourceName: "just")),
            Song(title: "Live Your Life", artist: "MIKA", playableSong: "Live Your Life -  MIKA.mp3", songArray: mika_live, cover: #imageLiteral(resourceName: "mika")),
            Song(title: "Uptown Funk", artist: "Mark Ronson", playableSong: "Mark Ronson - Uptown Funk (feat. Bruno Mars) - Lyrics.mp3", songArray: ronson, cover: #imageLiteral(resourceName: "uptown")),
            Song(title: "Start me Up", artist: "Rolling Stones", playableSong: "Rolling Stones-start me up.mp3", songArray: rolling, cover: #imageLiteral(resourceName: "rolling")),
            Song(title: "Surfin' USA", artist: "Beach Boys", playableSong: "beach.mp3", songArray: beach, cover: #imageLiteral(resourceName: "surfin"))
        ]
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        self.songToPlay = songs[indexPath.row].playableSong
        self.songArray = songs[indexPath.row].songArray
        self.index = indexPath.row
        print("sto nel didselect: \(songToPlay)")
        
    }
    
    override var prefersStatusBarHidden: Bool{
        
        return true
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destination = segue.destination as! GameViewController
        destination.song = self.songToPlay
        destination.songArray = self.songArray
        destination.index = self.index
    }
}
