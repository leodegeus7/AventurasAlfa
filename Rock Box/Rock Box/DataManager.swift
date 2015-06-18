//
//  DataManager.swift
//  Rock Box
//
//  Created by Leonardo Piovezan on 6/18/15.
//  Copyright (c) 2015 Leonardo Geus. All rights reserved.
//

import UIKit

class DataManager: NSObject {
    
    
    
    
    var faseEscolhida:Int!
    
    class var instance: DataManager
    {
        
        struct Static {
            static var instance: DataManager?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token)
            {
                Static.instance = DataManager()
        }
        
        return Static.instance!
    }
    
    
    
    
    override init()
    {
        
    }
   
    
    func lerArquivoJson() -> Array<AnyObject>
    {
        
        let path = NSBundle.mainBundle().pathForResource("data", ofType: "json")
        let jsonData = NSData(contentsOfFile: path!)
        var jsonResult = NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers, error: nil) as! Dictionary<String, AnyObject>
        var meuArray = jsonResult["local"] as! Array<AnyObject>
        var fase1 = meuArray[0] as! Dictionary<String,AnyObject>
        var planetasFase1 = fase1["planetas"] as! Array<AnyObject>
        var planet1 = planetasFase1[0] as! Dictionary<String, AnyObject>
        var planet2 = planetasFase1[1] as! Dictionary<String, AnyObject>
        var planet3 = planetasFase1[2] as! Dictionary<String, AnyObject>
       
        
        return meuArray
    }
    
    
    func arrayDaFase(fase: Int) -> Array<AnyObject>
    {
        
        
        var arrayComAsFases = lerArquivoJson()
       // println(arrayComAsFases)
        var dictionaryDaFase = arrayComAsFases[fase - 1] as! Dictionary<String, AnyObject>
        
        
    
        return dictionaryDaFase["planetas"] as! Array<AnyObject>
  
    }
    
    
    func writeArquivoJson()
    {
      
    }
}
