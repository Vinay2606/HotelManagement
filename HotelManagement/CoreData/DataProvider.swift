

//

import Foundation
import CoreData


class DataProvider {
    
    func insertRoomData(roomName: String, type: String, floor: CDFloor){
        let entity =  NSEntityDescription.entity(forEntityName: "CDRoom", in: CoreDataStack.shared().managedObjectContext!)
        let room = NSManagedObject(entity: entity!, insertInto: CoreDataStack.shared().managedObjectContext!) as! CDRoom
       
        room.name = roomName
        room.type = type
        room.floor = floor
        room.guestentry = "OFF"

        do {
            try CoreDataStack.shared().managedObjectContext!.save()
        } catch _ {
            print("Insert Room Data not saved")
        }
        
    }
    
    func updateRoom(room: CDRoom, guestentry: String) {
        room.guestentry = guestentry
        do {
            try CoreDataStack.shared().managedObjectContext!.save()
        } catch _ {
            print("Update Room Data not saved")
        }
    }

    
    func insertFloorData(name: String){
        let entity =  NSEntityDescription.entity(forEntityName: "CDFloor", in: CoreDataStack.shared().managedObjectContext!)
        let floor = NSManagedObject(entity: entity!, insertInto: CoreDataStack.shared().managedObjectContext!) as! CDFloor
       
        floor.name = name

        do {
            try CoreDataStack.shared().managedObjectContext!.save()
        } catch _ {
            print("Insert Floor Data not saved")
        }
        
    }
    
    func getFloors() -> [CDFloor] {
        var floors: [CDFloor] = []
        
        let fetchRequest = NSFetchRequest<CDFloor>(entityName: "CDFloor")
        do {
            floors = try CoreDataStack.shared().managedObjectContext!.fetch(fetchRequest)
        } catch let error as NSError {
            // something went wrong, print the error.
            print(error.description)
        }
        
        return floors
    }

    func getFloors(name: String) -> [CDFloor] {
        var floors: [CDFloor] = []
        
        let fetchRequest = NSFetchRequest<CDFloor>(entityName: "CDFloor")
        fetchRequest.predicate = NSPredicate(format: "%K == %@", argumentArray:["name", name])
        do {
            floors = try CoreDataStack.shared().managedObjectContext!.fetch(fetchRequest)
        } catch let error as NSError {
            // something went wrong, print the error.
            print(error.description)
        }
        
        return floors
    }
    


 
    
}
