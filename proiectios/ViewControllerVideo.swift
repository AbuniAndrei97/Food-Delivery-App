//
//  ViewControllerVideo.swift
//  proiectios
//
//  Created by user216341 on 6/14/22.
//

import UIKit
import AVKit
import AVFoundation

class ViewControllerVideo: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "video"

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "Marvel Studios' Doctor Strange in the Multiverse of Madness  Official Trailer", ofType: "mp4")!))
        
        let layer = AVPlayerLayer(player: player)
        layer.frame = view.bounds
        view.layer.addSublayer(layer)
        player.play()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
