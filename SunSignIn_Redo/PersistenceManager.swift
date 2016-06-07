
//
//  PersistenceManager.swift
//  SunSignIn_Redo
//
//  Created by Jennifer Duffey on 5/27/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import Foundation

enum Path: String
{
    case User = "User"
    case Event = "Event"
    case Participant = "Participant"
}

class PersistenceManager
{
    static let sharedManager = PersistenceManager()
    
    class private func documentsDirectory() -> NSString
    {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentDirectory = paths[0] as String
        return documentDirectory
    }
    
    func saveData(dataToSave: AnyObject?, path: Path)
    {
        let file = PersistenceManager.documentsDirectory().stringByAppendingPathComponent(path.rawValue)
        NSKeyedArchiver.archiveRootObject(dataToSave!, toFile: file)
    }
    
    func loadData(path: Path) -> AnyObject?
    {
        let file = PersistenceManager.documentsDirectory().stringByAppendingPathComponent(path.rawValue)
        let result = NSKeyedUnarchiver.unarchiveObjectWithFile(file)
        return result //as? AnyObject
    }
}