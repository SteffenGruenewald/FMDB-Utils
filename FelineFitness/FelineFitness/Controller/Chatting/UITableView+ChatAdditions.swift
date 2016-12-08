//
//  UITableViewController+ChatAdditions.swift
//  Marketmaker
//
//  Created by Big shark on 21/10/2016.
//  Copyright © 2016 Big shark. All rights reserved.
//

import Foundation
import UIKit


extension UITableView {
    func reloadData(completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
            }, completion:{ _ in
                completion()
        })
    }
    
    
    func insertRowsAtBottom(rows: [NSIndexPath]) {
    
        UIView.setAnimationsEnabled(false)
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        self.beginUpdates()
        self.insertRows(at: rows as [IndexPath], with: .none)
        self.endUpdates()
        self.scrollToRow(at: rows[0] as IndexPath, at: .bottom, animated: false)
        CATransaction.commit()
        UIView.setAnimationsEnabled(true)
    }
    
    func totalRows() -> Int {
        var i = 0
        var rowCount = 0
        while i < self.numberOfSections {
            rowCount += self.numberOfRows(inSection: i)
            i += 1
        }
        return rowCount
    }
    
    var lastIndexPath: NSIndexPath? {
        if (self.totalRows()-1) > 0{
            return NSIndexPath(row: self.totalRows()-1, section: 0)
        } else {
            return nil
        }
    }
    
 
    
    func scrollBottomWithoutFlashing() {
        guard let indexPath = self.lastIndexPath else {
            return
        }
        UIView.setAnimationsEnabled(false)
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        self.scrollToRow(at: indexPath as IndexPath, at: .bottom, animated: false)
        CATransaction.commit()
        UIView.setAnimationsEnabled(true)
    }
    
 
    
    func scrollBottomToLastRow() {
        guard let indexPath = self.lastIndexPath else {
            return
        }
        self.scrollToRow(at: indexPath as IndexPath, at: .bottom, animated: false)
    }
    
    func scrollToBottom(animated: Bool) {
        
        
        let bottomOffset = CGPoint(x: 0, y:self.contentSize.height - self.bounds.size.height)
        //if(bottomOffset.y > 0){
            self.setContentOffset(bottomOffset, animated: animated)
        //}
       
    }
    
    var isContentInsetBottomZero: Bool {
        get { return self.contentInset.bottom == 0 }
    }
    
    func resetContentInsetAndScrollIndicatorInsets() {
        self.contentInset = UIEdgeInsets.zero
        self.scrollIndicatorInsets = UIEdgeInsets.zero
    }
}
