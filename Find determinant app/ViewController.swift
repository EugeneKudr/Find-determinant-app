//
//  ViewController.swift
//  Find determinant app
//
//  Created by Евгений Испольнов on 24.04.2020.
//  Copyright © 2020 Евгений Испольнов. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    // MARK: - Private Properties
    private var arrayCount: Int = 4
    private var matrix: Array<Array<Int>> = [[]]
    private let sectionInserts = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    private let sectionDistance: CGFloat = 5
    private var matrixDeterminantService: MatrixDeterminantServiceProtocol!
        
    // MARK: - IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var matrixSizeLabel: UILabel!
    @IBOutlet private weak var resultLabel: UILabel!
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        matrixDeterminantService = MatrixDeterminantService()
        collectionView.delegate = self
        collectionView.dataSource = self
        createAndRandomizeMatrix()
        updateMatrixSizeLabel()
    }
    
    // MARK: - Private methods
    private func updateMatrixSizeLabel() {
        matrixSizeLabel.text = "\(arrayCount)x\(arrayCount)"
    }
    
    private func randomizeMatrix() {
        for i in 0..<arrayCount {
            matrix[i] = matrix[i].map { _ in
                return Int.random(in: 0...9)
            }
        }
    }
    
    private func createAndRandomizeMatrix() {
        matrix = Array(repeating: Array(repeating: 0, count: arrayCount), count: arrayCount)
        randomizeMatrix()
    }
    
    // MARK: - IBActions
    @IBAction func fillMatrixButton(_ sender: UIButton) {
        randomizeMatrix()
        collectionView.reloadData()
    }
    
    @IBAction func plusButton(_ sender: UIButton) {
        if arrayCount < 8 {
            arrayCount += 1
            createAndRandomizeMatrix()
            collectionView.reloadData()
            updateMatrixSizeLabel()
        }
    }
    
    @IBAction func minusButton(_ sender: UIButton) {
        if arrayCount > 1 {
            arrayCount -= 1
            createAndRandomizeMatrix()
            collectionView.reloadData()
            updateMatrixSizeLabel()
        }
    }
    
    @IBAction func findDeterminantButton(_ sender: UIButton) {
        resultLabel.text = "\(matrixDeterminantService.findDeterminant(matrix: matrix, N: arrayCount))"
    }
    
    // MARK: - CollectionView delegate methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return arrayCount * arrayCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "matrixCell", for: indexPath) as! MatrixCell
    
        cell.setText(text: "\(matrix[indexPath.item / arrayCount][indexPath.item % arrayCount])")
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Calculate width of the cell
        let paddingWidth = sectionDistance * CGFloat(arrayCount) + 2 * sectionInserts.left
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / CGFloat(arrayCount)
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionDistance
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionDistance
    }
}
