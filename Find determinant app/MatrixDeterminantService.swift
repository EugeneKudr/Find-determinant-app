//
//  MatrixDeterminantService.swift
//  Find determinant app
//
//  Created by Евгений Испольнов on 25.04.2020.
//  Copyright © 2020 Евгений Испольнов. All rights reserved.
//

import Foundation

protocol MatrixDeterminantServiceProtocol {
    func findDeterminant(matrix: [[Int]], N: Int) -> Int
}

class MatrixDeterminantService: MatrixDeterminantServiceProtocol {
    func findDeterminant(matrix: [[Int]], N: Int) -> Int {
        var result = 0
        var temp = Array(repeating: Array(repeating: 0, count: matrix.count), count: matrix.count)
        var sign = 1
        
        // Base case
        if N == 1 {
            return matrix[0][0]
        } else {
            // Recursive case
            for f in 0..<N {
                temp = getCofactor(matrix: matrix, p: 0, q: f, N: N)
                result += sign * matrix[0][f] * findDeterminant(matrix: temp, N: N - 1)
                sign = -sign
            }
            
            return result
        }
    }
    
    private func getCofactor(matrix: [[Int]], p: Int, q: Int, N: Int) -> [[Int]] {
        var i = 0
        var j = 0
        var temp = Array(repeating: Array(repeating: 0, count: matrix.count), count: matrix.count)
        
        for row in 0..<N {
            for col in 0..<N {
                if row != p && col != q {
                    temp[i][j] = matrix[row][col]
                    j += 1
                    
                    if j == N - 1 {
                        j = 0
                        i += 1
                    }
                }
            }
        }
        
        return temp
    }
}
