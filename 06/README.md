#ADATOK ELŐKÉSZÍTÉSE

Minden jó app mögé kell egy backend, valami egyszerű megoldást kerestünk, az Apple féle CloudKit pedig adta magát... egyszerű, gyorsan lehet vele haladni, és elég biztonságos. 

Feltételekről, árakról itt lehet olvasni: [link](https://developer.apple.com/icloud/documentation/cloudkit-storage/)

###Hogyan kell használni?

A meglévő projektből indulunk ki. 

- Project / General, figyelj a Bundle ID-ra és Team névre.
- Project / Capabilities, kapcsolt be az iCloud-ot, vigyázat, ehhez kell az Apple Dev Account

- key-value storage kell, és a cloudkit, mindkettő pipa
- létrejön egy új container iCloud.<your app’s bundle id> néven
- kell egy fix issue, többször is nyomd meg, sok dolgot nem javít meg elsőre 
- az icloud container neve fontos, erre figyeljetek, globálisan egyedinek kell lennie

###Nézzük mega cloudkit dashboardot
Online is elérhető [innen](https://icloud.developer.apple.com/dashboard/).

####Megérkeztünk a lényeghez, kis bemutatás:

- Scheme esetében az adat típusokat írjuk le, kicsit olyan mint az OOP esetében az osztályok, a recordok lesznek az instanceok
- az adatok a public és private data részekbe kerülnek
- admin részen pedig a csapattagokat lehet korlátozni

####Hozzunk létre új Record Typeot, bal felül + gomb, így nézzen ki
- Title - String  - Sort, Query, Search
- Photo - Asset -
- Description - String -
- DateAdded - Date / Time - Sort
- UploaderName - String - 


#### Record 1
- Title: Öt kihagyhatatlan utazás, amely soha nem lesz ennyire olcsó
- Photo: http://m.blog.hu/fa/fapadosinfo/image/.thumbs/kikoto_2e711af6b4d638ff16232eeeabfd0b1e.jpg
- Description: Lett megint sok olcsó fapados jegy, immár őszre - ez eddig papírforma. De van néhány, amely annyira kirívóan jóáras, hogy szinte bűn kihagyni. Bulisziget, lüktető európai nagyváros, gyönyörű kora őszi riviéra és télen 30 fokot tudó tengerparti célpont. Van itt minden olyan áron, amennyiért valószínűleg sose lesz többet.  
- DateAdded: 2016. július 30., szombat 22:23
- UploaderName: Repülős Rozi

#### Record 2
- Title: Mi történt a Ferrarival? – Vettel nem érti… 
- Photo: http://telesport.cms.mtv.hu/wp-content/uploads/sites/10/2016/07/XPB_830741_1200px.jpg
- Description: Mi történt a Ferrarival és Sebastian Vettellel? A Német Nagydíj időmérő edzése mindkettejüknek valóságos vereséggel ért fel.
- DateAdded: 2016. július 30., szombat 15:53
- UploaderName:  M4 Sport

#### Record 3

- Title: Natúr csirkemell chilis őszibarackszósszal
- Photo: http://m.blog.hu/ti/timilinihobbikonyhaja/image/.thumbs/natur_csirkemellfile_chilis_oszibarackszosszal_2e711af6b4d638ff16232eeeabfd0b1e.jpg
- Description: Rég írtam bejegyzést. Ennek igazából egy az oka, hogy nincs mindig kedvem a "macerához", már, ami az ételek beállítását, fotózását illeti. Szívesen, örömmel megfőzöm, elkészítem, de az utómunkát inkább rábíznám másra. :-) A kicsi épp itt nyomkodja a laptopomat, úgyhogy lehet lesznek fura elütések.
- DateAdded: 2016. július 30., szombat 18:17
- UploaderName: Timilini


Egyelőre ennyi elég is lesz, adhattok még hozzá bőven, ha szeretnétek.

###Húzzuk le ezeket az adatokat a szerverről


```swift
func fetchArticles() {
    let defaultContainer = CKContainer.defaultContainer()
    let publicDatabase = defaultContainer.publicCloudDatabase
    let predicate = NSPredicate(value: true)
    
    let query = CKQuery(recordType: "Article", predicate: predicate)

    ...
}

func fetchArticles() {
	...

	publicDatabase.performQuery(query, inZoneWithID: nil) { (results, error) -> Void in
	    if error != nil {
	        print(error)
	    }
	    else {
	        print(results)
	        
	        for result in results! {
	            // TODO
	        }
	        
	        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
	            // TOTO
	        })
	    }
	}
}


override func viewDidLoad() {
	... 
    fetchArticles()
}

class ViewController: UIViewController {
...
var items = [Article]()
...
}

```

**article.swift**

```swift

import Foundation
import CloudKit

class Article {
    let record: CKRecord
    
    let title: String!
    let photoUrl: NSURL!
    let description: String!
    let dateAdded: NSDate
    let uploaderName: String!
    
    init(record : CKRecord) {
        self.record = record
        
        self.title = record.objectForKey("Title") as! String
        self.photoUrl = (self.record.objectForKey("Photo") as? CKAsset)?.fileURL
        self.description = record.objectForKey("Description") as! String
        self.dateAdded = record.objectForKey("DateAdded") as! NSDate
        self.uploaderName = record.objectForKey("Uploader") as! String
    }
}

func fetchArticles() {
	...
	for result in results! {
		let article = Article(record: result)
		self.items.append(article)
	}
	...
}

func uploadRecord() {
    let firstItem = self.items[0]
    firstItem.title = "New new new"
    
    let asset = CKAsset(fileURL: firstItem.photoUrl!)
    
    let myRecord = CKRecord(recordType: "Article")
    myRecord.setObject(firstItem.title, forKey: "Title")
    myRecord.setObject(firstItem.description, forKey: "Description")
    myRecord.setObject(asset, forKey: "Photo")
    myRecord.setObject(firstItem.dateAdded, forKey: "DateAdded")
    myRecord.setObject(firstItem.uploaderName, forKey: "Uploader")
    
    let defaultContainer = CKContainer.defaultContainer()
    let publicDatabase = defaultContainer.publicCloudDatabase
    publicDatabase.saveRecord(myRecord, completionHandler:
        ({ returnRecord, error in
            if let err = error {
                print(err.localizedDescription)
            } else {
                dispatch_async(dispatch_get_main_queue()) {
                    print("Record saved successfully")
                }
            }
        }))
}
```

###Néhány hasznos tutorial:

- [Beginning CloudKit](https://www.raywenderlich.com/83116/beginning-cloudkit-tutorial)
- [An iOS8 CloudKit example](http://www.techotopia.com/index.php/An_iOS_8_CloudKit_Example)
- [CloudKit introduction tutorial](https://www.appcoda.com/cloudkit-introduction-tutorial/)