#!/usr/bin/python3

from typing import List
import numpy as np

class Unsold:
    def __init__(self, a: int, b: int):
        self.a = a
        self.b = b
        self.XY_joint_law = np.zeros((5, 5))
        self.X_marginal_law = np.zeros(5)
        self.Y_marginal_law = np.zeros(5)
        self.Z_law = np.zeros(9)
        
    def calc_prob(self, x: int, y: int) -> float:
        numerator = (self.a - x) * (self.b - y)
        denominator = (5 * self.a - 150) * (5 * self.b - 150)
        return numerator / denominator
    
    def calculate(self):
        for i in range(5):
            for j in range(5):
                self.XY_joint_law[i][j] = self.calc_prob(10 * (i+1), 10 * (j+1))
        
        self.X_marginal_law = np.sum(self.XY_joint_law, axis=1)
        self.Y_marginal_law = np.sum(self.XY_joint_law, axis=0)
        
        for i in range(5):
            for j in range(5):
                self.Z_law[(i+j)] += self.XY_joint_law[i][j]
        
        expected_value_X = np.sum(self.X_marginal_law * np.array([10, 20, 30, 40, 50]))
        variance_X = np.sum(self.X_marginal_law * np.square(np.array([10, 20, 30, 40, 50]) - expected_value_X))
        
        expected_value_Y = np.sum(self.Y_marginal_law * np.array([10, 20, 30, 40, 50]))
        variance_Y = np.sum(self.Y_marginal_law * np.square(np.array([10, 20, 30, 40, 50]) - expected_value_Y))
        
        expected_value_Z = np.sum(self.Z_law * np.array([20, 30, 40, 50, 60, 70, 80, 90, 100]))
        variance_Z = np.sum(self.Z_law * np.square(np.array([20, 30, 40, 50, 60, 70, 80, 90, 100]) - expected_value_Z))
        
        print("--------------------------------------------------------------------------------")
        print("\tX=10 \tX=20 \tX=30 \tX=40 \tX=50 \tY law")
        for i in range(5):
            print("Y={0} \t{1:.3f} \t{2:.3f} \t{3:.3f} \t{4:.3f} \t{5:.3f} \t{6:.3f}".format(
                10*(i+1),
                self.XY_joint_law[0][i],
                self.XY_joint_law[1][i],
                self.XY_joint_law[2][i],
                self.XY_joint_law[3][i],
                self.XY_joint_law[4][i],
                self.Y_marginal_law[i]
            ))
        print("X law", end=" ")
        for x in self.X_marginal_law:
            print(f"\t{x:.3f}", end=" ")
        print("\t1.000")
        print("--------------------------------------------------------------------------------")
        print("z \t20\t30\t40\t50\t60\t70\t80\t90\t100")
        print("p(Z=z) \t{0:.3f}\t{1:.3f}\t{2:.3f}\t{3:.3f}\t{4:.3f}\t{5:.3f}\t{6:.3f}\t{7:.3f}\t{8:.3f}".format(
            self.Z_law[0], self.Z_law[1], self.Z_law[2], self.Z_law[3], self.Z_law[4],
            self.Z_law[5], self.Z_law[6], self.Z_law[7], self.Z_law[8]
        ))
        print("--------------------------------------------------------------------------------")
        print("expected value of X: \t{:.1f}".format(expected_value_X))
        print("variance of X:  \t{:.1f}".format(variance_X))
        print("expected value of Y: \t{:.1f}".format(expected_value_Y))
        print("variance of Y:  \t{:.1f}".format(variance_Y))
        print("expected value of Z: \t{:.1f}".format(expected_value_Z))
        print("variance of Z:  \t{:.1f}".format(variance_Z))
        print("--------------------------------------------------------------------------------")