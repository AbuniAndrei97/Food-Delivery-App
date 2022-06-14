//
//  ViewControllerPozeFilm.swift
//  proiectios
//
//  Created by user216341 on 6/14/22.
//

import UIKit

class PozeFilmCell: UICollectionViewCell{
    
    @IBOutlet weak var pozeFilmView: UIImageView!
    
}

class ViewControllerPozeFilm: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Poze Locatie"
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    let pozeFilm = ["poza1", "poza2"]
    
}

extension ViewControllerPozeFilm: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! PozeFilmCell
        
        cell.pozeFilmView.image = UIImage(named: pozeFilm[indexPath.row])
        
        return cell
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
