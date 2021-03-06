//
//  DataManager.swift
//  Rock Box
//
//  Created by Leonardo Piovezan on 6/18/15.
//  Copyright (c) 2015 Leonardo Geus. All rights reserved.
//

import UIKit

class DataManager: NSObject {
    
    
    
    var numeroEstrelas = 0
    var faseEscolhida:Int!
    var pausar = true
    
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
   
    
    func arrayDaFaseAntes(fase: Int) -> Dictionary<String, AnyObject>
    {
        
        
        var arrayComAsFases = lerArquivoJson()
        // println(arrayComAsFases)
        let dictionaryDaFase = arrayComAsFases[fase - 1] as! Dictionary<String, AnyObject>
        
        
        
        return dictionaryDaFase
        
    }
    
    
    func arrayDaFase(fase: Int) -> Array<AnyObject>
    {
        
        
        var arrayComAsFases = lerArquivoJson()
       // println(arrayComAsFases)
        var dictionaryDaFase = arrayComAsFases[fase - 1] as! Dictionary<String, AnyObject>
        print("dictionaryDaFase")

    
        return dictionaryDaFase["planetas"] as! Array<AnyObject>
    }
    
    func arrayDasLetras(fase: Int) -> Array<AnyObject>
    {
        
        
        var arrayComAsFases = lerArquivoJson()
        // println(arrayComAsFases)
        var dictionaryDaFase = arrayComAsFases[fase - 1] as! Dictionary<String, AnyObject>
        
        
        
        return dictionaryDaFase["letras"] as! Array<AnyObject>
        
    }
    
    
    func arrayDasEstrelas(fase: Int) -> Array<AnyObject>
    {
        
        
        var arrayComAsFases = lerArquivoJson()
        // println(arrayComAsFases)
        var dictionaryDaFase = arrayComAsFases[fase - 1] as! Dictionary<String, AnyObject>
        
        
        
        return dictionaryDaFase["estrelas"] as! Array<AnyObject>
        
    }
    

    
    /////////JSOOOON
    
    func lerArquivoJson() -> Array<AnyObject>
    {
        
        moverJsonParaDocuments()
        
        let path = caminhoDocs()
        let jsonData = NSData(contentsOfFile: path)
        var jsonResult = (try! NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers)) as! Dictionary<String, AnyObject>
        var meuArray = jsonResult["local"] as! Array<AnyObject>
        var fase1 = meuArray[0] as! Dictionary<String,AnyObject>
        //var planetasFase1 = fase1["planetas"] as! Array<AnyObject>
//        var planet1 = planetasFase1[0] as! Dictionary<String, AnyObject>
//        var planet2 = planetasFase1[1] as! Dictionary<String, AnyObject>
//        var planet3 = planetasFase1[2] as! Dictionary<String, AnyObject>
        
        
        return meuArray
    }
    
    
    
    func moverJsonParaDocuments () {
        let fileManager = NSFileManager.defaultManager()
        if fileManager.fileExistsAtPath(caminhoDocs()){
            print("Achoou")
        }
        else {
            let caminhoBundle = NSBundle.mainBundle().pathForResource("data", ofType: "json")
            let caminhoDispositivo = caminhoDocs()
            do {
                try fileManager.copyItemAtPath(caminhoBundle!, toPath:caminhoDispositivo)
            // success
                print("sucesso")
                print(caminhoDispositivo, terminator: "")
            } catch _ {
                print("nao sucesso")// failure
            }
        }
        
    
    
    }
    
    func caminhoDocs() -> String {
        let pathToDocumentsFolder = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] 
        print(pathToDocumentsFolder)
        return (pathToDocumentsFolder as NSString).stringByAppendingPathComponent("/data.json")
        
    }
    
    func escreverArquivoJson(fase:Int, quantasEstrelasPegou:Int)
    {
    var arquivoAnterior = lerArquivoJson()
        
       var dicionario = arquivoAnterior[fase - 1] as! Dictionary<String,AnyObject>
    
        dicionario["jaJogou"] = true
        dicionario["quantasEstrelasPegou"] = quantasEstrelasPegou
        
        arquivoAnterior[fase - 1] = dicionario
       
        let dicionarioJson = Dictionary(dictionaryLiteral: ("local",arquivoAnterior))
        print(dicionarioJson)
        let dataJson = try? NSJSONSerialization.dataWithJSONObject(dicionarioJson, options: NSJSONWritingOptions.PrettyPrinted)
        print(caminhoDocs())
        dataJson?.writeToFile(caminhoDocs(), atomically: true)
        
    }

    
}
